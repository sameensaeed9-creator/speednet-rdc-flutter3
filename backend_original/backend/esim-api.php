<?php
require_once __DIR__ . '/api_keys.php';

$action = $_GET['action'] ?? 'packages';

if ($action === 'packages') {
    $result = speednet_request('GET', '/v2/packages');
    speednet_json($result, $result['ok'] ? 200 : 400);
}

if ($action === 'buy') {
    $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
    $packageId = $input['package_id'] ?? $_GET['package_id'] ?? '';
    if (!$packageId) speednet_json(['ok' => false, 'message' => 'package_id missing'], 400);
    $result = speednet_request('POST', '/v2/orders', ['package_id' => $packageId, 'quantity' => 1]);
    speednet_json($result, $result['ok'] ? 200 : 400);
}

if ($action === 'order') {
    $id = $_GET['id'] ?? '';
    if (!$id) speednet_json(['ok' => false, 'message' => 'order id missing'], 400);
    $result = speednet_request('GET', '/v2/orders/' . urlencode($id));
    speednet_json($result, $result['ok'] ? 200 : 400);
}

speednet_json(['ok' => false, 'message' => 'Invalid action'], 400);
?>
