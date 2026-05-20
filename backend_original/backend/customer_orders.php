<?php
require_once __DIR__ . '/api_keys.php';

$file = __DIR__ . '/manual_orders.json';
$orders = file_exists($file) ? json_decode(file_get_contents($file), true) : [];
if (!is_array($orders)) $orders = [];

$phone = trim($_GET['phone'] ?? '');
$orderId = trim($_GET['order_id'] ?? '');

$result = [];
foreach ($orders as $o) {
    $match = false;
    if ($orderId && (($o['id'] ?? '') === $orderId)) $match = true;
    if ($phone) {
        $customer = preg_replace('/\D+/', '', $o['customer_phone'] ?? '');
        $sender = preg_replace('/\D+/', '', $o['sender_phone'] ?? '');
        $needle = preg_replace('/\D+/', '', $phone);
        if ($needle && ($customer === $needle || $sender === $needle || str_ends_with($customer, $needle) || str_ends_with($sender, $needle))) {
            $match = true;
        }
    }
    if ($match) {
        $result[] = [
            'id' => $o['id'] ?? '',
            'status' => $o['status'] ?? 'pending',
            'method' => $o['method'] ?? '',
            'transaction_id' => $o['transaction_id'] ?? '',
            'amount' => $o['amount'] ?? '',
            'currency' => $o['currency'] ?? 'FC',
            'description' => $o['description'] ?? '',
            'created_at' => $o['created_at'] ?? '',
            'approved_at' => $o['approved_at'] ?? '',
            'admin_note' => $o['admin_note'] ?? '',
            'esim_code' => $o['esim_code'] ?? '',
            'qr_payload' => $o['qr_payload'] ?? ($o['esim_code'] ?? ''),
            'activation_code' => $o['activation_code'] ?? '',
            'lpa' => $o['lpa'] ?? '',
            'iccid' => $o['iccid'] ?? '',
            'speednet_order_id' => $o['speednet_order_id'] ?? ''
        ];
    }
}

usort($result, function($a,$b){ return strcmp($b['created_at'] ?? '', $a['created_at'] ?? ''); });
speednet_json(['ok'=>true, 'orders'=>$result]);
?>