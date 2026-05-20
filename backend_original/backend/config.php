<?php
header('Content-Type: application/json');

// ==== DB settings (XAMPP default) ====
$DB_HOST = 'localhost';
$DB_NAME = 'speednet';   // phpMyAdmin me jo name banaya
$DB_USER = 'root';
$DB_PASS = '';           // agar tumne password nahi lagaya

try {
    $dsn = "mysql:host=$DB_HOST;dbname=$DB_NAME;charset=utf8mb4";
    $pdo = new PDO($dsn, $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    echo json_encode([
        "success" => false,
        "message" => "DB error: " . $e->getMessage()
    ]);
    exit;
}

// simple SMS function (abhi sirf file me save hoga)
function send_sms($phone, $message) {
    $logLine = date('Y-m-d H:i:s') . " | $phone | $message" . PHP_EOL;
    file_put_contents(__DIR__ . '/sms_log.txt', $logLine, FILE_APPEND);
}


// Airtel/Unitel/SpeedNet keys backend/api_keys.php me hain.



// JSON response helper
header('Content-Type: application/json');
?>

