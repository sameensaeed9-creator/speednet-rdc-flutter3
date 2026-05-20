<?php
require_once "config.php";
$input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
$phone = trim($input['phone'] ?? $input['msisdn'] ?? '');
$otp = trim($input['otp'] ?? '');
if ($phone == '' || $otp == '') { echo json_encode(["ok"=>false,"success"=>false,"error"=>"Phone & OTP required"]); exit; }
$stmt = $pdo->prepare("SELECT * FROM otp_codes WHERE phone = ? AND otp_code = ? ORDER BY id DESC LIMIT 1");
$stmt->execute([$phone, $otp]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$row) { echo json_encode(["ok"=>false,"success"=>false,"error"=>"Wrong code"]); exit; }
if (strtotime($row['expires_at']) < time()) { echo json_encode(["ok"=>false,"success"=>false,"error"=>"OTP expired"]); exit; }
$pdo->prepare("UPDATE otp_codes SET verified = 1 WHERE id = ?")->execute([$row['id']]);
echo json_encode(["ok"=>true,"success"=>true,"message"=>"OTP verified","msisdn"=>$phone]);
?>
