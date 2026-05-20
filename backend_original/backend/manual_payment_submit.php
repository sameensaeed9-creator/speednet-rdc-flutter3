<?php
require_once __DIR__ . '/api_keys.php';

$ordersFile = __DIR__ . '/manual_orders.json';
$uploadDir = dirname(__DIR__) . '/uploads/payment_screens';
if (!is_dir($uploadDir)) @mkdir($uploadDir, 0775, true);

function load_manual_orders($file) {
    if (!file_exists($file)) return [];
    $data = json_decode(file_get_contents($file), true);
    return is_array($data) ? $data : [];
}
function save_manual_orders($file, $orders) {
    file_put_contents($file, json_encode($orders, JSON_PRETTY_PRINT));
}

$required = ['method','transaction_id','sender_phone','amount','currency','desc'];
foreach ($required as $key) {
    if (empty($_POST[$key])) speednet_json(['ok'=>false,'message'=>"Missing field: $key"], 400);
}
if (empty($_FILES['screenshot']['name'])) speednet_json(['ok'=>false,'message'=>'Payment screenshot is required.'], 400);

$allowed = ['image/jpeg'=>'jpg','image/png'=>'png','image/webp'=>'webp','image/gif'=>'gif','application/pdf'=>'pdf'];
$mime = mime_content_type($_FILES['screenshot']['tmp_name']);
if (!isset($allowed[$mime])) speednet_json(['ok'=>false,'message'=>'Only image or PDF screenshots are allowed.'], 400);
if ($_FILES['screenshot']['size'] > 8 * 1024 * 1024) speednet_json(['ok'=>false,'message'=>'Screenshot must be less than 8MB.'], 400);

$id = 'SN-' . date('Ymd-His') . '-' . random_int(1000,9999);
$ext = $allowed[$mime];
$fileName = $id . '.' . $ext;
$dest = $uploadDir . '/' . $fileName;
if (!move_uploaded_file($_FILES['screenshot']['tmp_name'], $dest)) speednet_json(['ok'=>false,'message'=>'Could not save uploaded screenshot.'], 500);

$order = [
    'id' => $id,
    'status' => 'pending',
    'method' => trim($_POST['method']),
    'transaction_id' => trim($_POST['transaction_id']),
    'sender_phone' => trim($_POST['sender_phone']),
    'customer_phone' => trim($_POST['phone'] ?? ''),
    'amount' => trim($_POST['amount']),
    'currency' => trim($_POST['currency']),
    'description' => trim($_POST['desc']),
    'package_id' => trim($_POST['bundleId'] ?? ''),
    'screenshot' => 'uploads/payment_screens/' . $fileName,
    'created_at' => date('c'),
    'approved_at' => null,
    'esim_code' => null,
    'speednet_response' => null,
    'admin_note' => null
];

$orders = load_manual_orders($ordersFile);
$orders[] = $order;
save_manual_orders($ordersFile, $orders);
@file_put_contents(dirname(__DIR__) . '/orders.txt', $id . ' | Manual ' . $order['method'] . ' | ' . $order['description'] . ' | ' . $order['amount'] . ' ' . $order['currency'] . ' | Pending' . PHP_EOL, FILE_APPEND);

speednet_json(['ok'=>true,'id'=>$id,'message'=>'Payment submitted. Waiting for admin approval.']);
?>
