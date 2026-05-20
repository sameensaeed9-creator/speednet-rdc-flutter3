<?php
header('Content-Type: application/json');
require __DIR__ . '/db.php';

function norm_key($s) {
    $s = strtolower($s);
    $s = str_replace('validity:', 'validity', $s);
    $s = preg_replace('/[^a-z0-9]+/', '-', $s);
    return trim(preg_replace('/-+/', '-', $s), '-');
}

$map = require __DIR__ . '/speednet_exact_web_airalo_map.php';

$name = $_GET['name'] ?? $_POST['name'] ?? '';
$validity = $_GET['validity'] ?? $_POST['validity'] ?? '';
$price = $_GET['price'] ?? $_POST['price'] ?? '';

$key1 = norm_key($name);
$key2 = norm_key($name . '-' . $validity);
$key3 = norm_key($name . '-' . $validity . '-' . $price);

$foundKey = null;
$packageId = null;

foreach ([$key3, $key2, $key1] as $k) {
    if (array_key_exists($k, $map)) {
        $foundKey = $k;
        $packageId = $map[$k];
        break;
    }
}

// Also try raw map keys normalized
if (!$foundKey) {
    foreach ($map as $k => $v) {
        $nk = norm_key($k);
        if ($nk && (strpos($key3, $nk) !== false || strpos($nk, $key3) !== false)) {
            $foundKey = $k;
            $packageId = $v;
            break;
        }
    }
}

if (!$foundKey) {
    echo json_encode([
        'ok' => true,
        'available' => false,
        'label' => 'Unavailable',
        'reason' => 'No exact web mapping found'
    ]);
    exit;
}

// If package ID is null, app can show mapped-by-web but backend must be filled before QR.
if (!$packageId) {
    echo json_encode([
        'ok' => true,
        'available' => false,
        'label' => 'Unavailable',
        'mapped_key' => $foundKey,
        'reason' => 'Mapping key found but Airalo package ID is missing. Add ID in speednet_exact_web_airalo_map.php'
    ]);
    exit;
}

$stmt = $pdo->prepare("SELECT package_id, is_active, title FROM airalo_packages WHERE package_id=? LIMIT 1");
$stmt->execute([$packageId]);
$row = $stmt->fetch();

$active = $row && intval($row['is_active']) === 1;

echo json_encode([
    'ok' => true,
    'available' => $active,
    'label' => $active ? 'Available' : 'Unavailable',
    'mapped_key' => $foundKey,
    'matched_package_id' => $packageId,
    'matched_title' => $row['title'] ?? null,
    'reason' => $active ? 'Exact mapped active package' : 'Mapped package inactive/discontinued or not synced'
]);
