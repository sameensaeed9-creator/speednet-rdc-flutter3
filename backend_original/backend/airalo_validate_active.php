<?php
require __DIR__.'/db.php';
$id=$_GET['package_id'] ?? $_POST['package_id'] ?? '';
$stmt=$pdo->prepare("SELECT is_active FROM airalo_packages WHERE package_id=? LIMIT 1");
$stmt->execute([$id]); $row=$stmt->fetch();
if(!$row || (int)$row['is_active']!==1){
 http_response_code(409);
 echo json_encode(['ok'=>false,'message'=>'Package inactive/discontinued. QR blocked.']);
 exit;
}
echo json_encode(['ok'=>true,'message'=>'Active package. QR allowed.']);
