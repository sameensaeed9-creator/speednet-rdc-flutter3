<?php
require_once __DIR__ . '/api_keys.php';
$id = $_GET['id'] ?? '';
if (!$id) speednet_json(['ok'=>false,'message'=>'Order ID missing.'],400);
$file = __DIR__ . '/manual_orders.json';
$orders = file_exists($file) ? json_decode(file_get_contents($file), true) : [];
foreach (($orders ?: []) as $order) {
    if (($order['id'] ?? '') === $id) {
        unset($order['speednet_response']);
        speednet_json(['ok'=>true,'order'=>$order]);
    }
}
speednet_json(['ok'=>false,'message'=>'Order not found.'],404);
?>
