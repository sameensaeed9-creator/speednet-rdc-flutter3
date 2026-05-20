<?php
// This API returns active/inactive package status for Flutter/web cards.
// Connect package_id from your SpeedNet mapping to Airalo synced table.
require __DIR__ . '/db.php';
header('Content-Type: application/json');

$packageId = $_GET['package_id'] ?? '';
if (!$packageId) {
  echo json_encode(['ok'=>false,'message'=>'package_id required']);
  exit;
}

$stmt = $pdo->prepare("SELECT package_id, is_active FROM airalo_packages WHERE package_id=? LIMIT 1");
$stmt->execute([$packageId]);
$row = $stmt->fetch();

echo json_encode([
  'ok' => true,
  'package_id' => $packageId,
  'available' => $row && intval($row['is_active']) === 1,
  'label' => ($row && intval($row['is_active']) === 1) ? 'Available' : 'Unavailable'
]);
