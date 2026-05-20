<?php
header('Content-Type: application/json');
require __DIR__ . '/db.php';
require __DIR__ . '/speednet_fit_matching.php';

$name = $_GET['name'] ?? $_POST['name'] ?? '';
$validity = $_GET['validity'] ?? $_POST['validity'] ?? '';
$price = $_GET['price'] ?? $_POST['price'] ?? '';
$key = $_GET['speednet_bundle_key'] ?? $_POST['speednet_bundle_key'] ?? '';
$packageId = $_GET['airalo_package_id'] ?? $_POST['airalo_package_id'] ?? '';
$country = $_GET['country_code'] ?? $_POST['country_code'] ?? null;

$result = speednet_package_availability($pdo, [
    'name' => $name,
    'validity' => $validity,
    'price' => $price,
    'speednet_bundle_key' => $key,
    'airalo_package_id' => $packageId,
    'country_code' => $country,
]);

echo json_encode(['ok' => true] + $result);
