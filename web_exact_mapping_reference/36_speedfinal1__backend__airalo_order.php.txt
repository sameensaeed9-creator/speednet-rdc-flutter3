<?php
require_once __DIR__ . '/api_keys.php';

$input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
$packageId = $_GET['package_id'] ?? $input['package_id'] ?? $input['bundleId'] ?? '';
$quantity = intval($_GET['quantity'] ?? $input['quantity'] ?? 1);
$quantity = max(1, $quantity);

if (!$packageId) {
    speednet_json([
        'ok' => false,
        'message' => 'package_id missing. Open like: backend/speednet_order.php?package_id=YOUR_AIRALO_PACKAGE_ID'
    ], 400);
}

$orderPayload = [
    'package_id' => $packageId,
    'quantity' => $quantity
];

$result = speednet_request('POST', '/v2/orders', $orderPayload);
if (!$result['ok']) {
    speednet_json($result, 400);
}

$data = $result['response'];
$sim = $data['data']['sims'][0] ?? $data['data']['sim'] ?? [];
$qr = $sim['qrcode'] ?? $sim['qr_code'] ?? $sim['qrcode_url'] ?? null;
$iccid = $sim['iccid'] ?? null;
$orderId = $data['data']['id'] ?? $data['data']['order_id'] ?? null;

speednet_json([
    'ok' => true,
    'message' => 'SpeedNet order created successfully.',
    'order_id' => $orderId,
    'iccid' => $iccid,
    'esimCode' => $qr ?: ($iccid ?: 'AIRALO_ORDER_CREATED'),
    'speednet' => $data
]);
?>
