<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
require_once "config.php";
$input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
$pdo->exec("CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, phone VARCHAR(30) UNIQUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
$pdo->exec("CREATE TABLE IF NOT EXISTS otp_codes (id INT AUTO_INCREMENT PRIMARY KEY, phone VARCHAR(30), otp_code VARCHAR(6), expires_at DATETIME, verified TINYINT(1) DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, INDEX idx_phone (phone)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
$phone = trim($input['phone'] ?? $input['msisdn'] ?? $input['phoneNumber'] ?? '');
if ($phone === '') { echo json_encode(["ok"=>false,"success"=>false,"error"=>"Phone number missing."]); exit; }
try {
  $otp = str_pad((string)random_int(0, 999999), 6, '0', STR_PAD_LEFT);
  $expires = date('Y-m-d H:i:s', time() + 5 * 60);
  $pdo->prepare("DELETE FROM otp_codes WHERE expires_at < NOW()")->execute();
  $stmt = $pdo->prepare("INSERT INTO otp_codes (phone, otp_code, expires_at, verified) VALUES (?, ?, ?, 0)");
  $stmt->execute([$phone, $otp, $expires]);
  $pdo->prepare("INSERT IGNORE INTO users (phone) VALUES (?)")->execute([$phone]);
  send_sms($phone, "Your SpeedNet login code is: $otp (valid 5 minutes)");
  echo json_encode(["ok"=>true,"success"=>true,"message"=>"OTP sent", "otp"=>$otp]);
} catch (Exception $e) { echo json_encode(["ok"=>false,"success"=>false,"error"=>$e->getMessage()]); }
?>
