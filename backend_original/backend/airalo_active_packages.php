<?php
require __DIR__.'/db.php';
$stmt=$pdo->query("SELECT * FROM airalo_packages WHERE is_active=1 ORDER BY country_code, net_price ASC");
echo json_encode(['ok'=>true,'data'=>$stmt->fetchAll()]);
