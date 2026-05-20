<?php
include "auth.php";
require_once __DIR__ . '/../backend/api_keys.php';
require_once __DIR__ . '/../backend/speednet_package_map.php';

$file = __DIR__ . '/../backend/manual_orders.json';
$orders = file_exists($file) ? json_decode(file_get_contents($file), true) : [];
if (!is_array($orders)) $orders = [];

$id = $_POST['id'] ?? $_GET['id'] ?? '';
$action = $_POST['action'] ?? $_GET['action'] ?? 'approve';
$note = trim($_POST['admin_note'] ?? '');

foreach ($orders as &$order) {
    if (($order['id'] ?? '') === $id) {

        if ($action === 'reject') {
            $order['status'] = 'rejected';
            $order['customer_visible'] = true;
            $order['admin_note'] = $note ?: 'Payment rejected by admin.';
            $order['approved_at'] = date('c');
            break;
        }

        $websitePackageId = trim($order['package_id'] ?? '');
        $speednetPackageId = function_exists('speednet_get_speednet_package_id') ? speednet_get_speednet_package_id($websitePackageId) : $websitePackageId;

        if (!$speednetPackageId) {
            $order['status'] = 'approved_speednet_mapping_required';
            $order['customer_visible'] = true;
            $order['approved_at'] = date('c');
            $order['admin_note'] = 'Payment approved, but real SpeedNet package ID is missing. Add mapping for website package ID: ' . $websitePackageId;
            break;
        }

        $result = speednet_request('POST', '/v2/orders', [
            'package_id' => $speednetPackageId,
            'quantity' => 1
        ]);

        $order['speednet_package_id'] = $speednetPackageId;
        $order['speednet_response'] = $result;
        $order['approved_at'] = date('c');
        $order['customer_visible'] = true;

        if (!empty($result['ok'])) {
            $data = $result['response'];
            $sim = $data['data']['sims'][0] ?? $data['data']['sim'] ?? $data['data']['esims'][0] ?? [];
            $qr = $sim['qrcode'] ?? $sim['qr_code'] ?? $sim['qrcode_url'] ?? $sim['qr_url'] ?? null;
            $activationCode = $sim['activation_code'] ?? $sim['manual_activation_code'] ?? $sim['matching_id'] ?? null;
            $lpa = $sim['lpa'] ?? $sim['smdp_address'] ?? null;
            $iccid = $sim['iccid'] ?? null;
            $orderId = $data['data']['id'] ?? $data['data']['order_id'] ?? null;

            if ($qr || $activationCode || $iccid) {
                $order['status'] = 'approved_esim_generated';
                $order['esim_code'] = $qr ?: ($activationCode ?: $iccid);
                $order['qr_payload'] = $qr ?: ($activationCode ?: $iccid);
                $order['activation_code'] = $activationCode;
                $order['lpa'] = $lpa;
                $order['iccid'] = $iccid;
                $order['speednet_order_id'] = $orderId;
                $order['admin_note'] = $note ?: 'Payment approved. Your eSIM is ready.';
            } else {
                $order['status'] = 'approved_speednet_no_qr_returned';
                $order['admin_note'] = 'SpeedNet order created, but QR/activation code was not found in response.';
                $order['speednet_order_id'] = $orderId;
            }
        } else {
            $order['status'] = 'approved_speednet_error';
            $order['admin_note'] = $result['message'] ?? 'SpeedNet API error. Check API credentials, package ID, and account approval.';
        }
        break;
    }
}
unset($order);

file_put_contents($file, json_encode($orders, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
header('Location: orders.php');
exit;
?>