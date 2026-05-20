<?php
require_once "config.php";

$phone  = isset($_POST['phone']) ? trim($_POST['phone']) : '';
$bundle = isset($_POST['bundle_name']) ? trim($_POST['bundle_name']) : '';

if ($phone == '' || $bundle == '') {
    echo json_encode(["success" => false, "message" => "Missing fields"]);
    exit;
}

// yahan hum ek simple esim data string bana rahe hain
$qr_data = "esim://speednet?phone=".urlencode($phone)."&bundle=".urlencode($bundle)."&ts=".time();

// DB me save
$stmt = $pdo->prepare("INSERT INTO esims (phone, bundle_name, qr_data) VALUES (?, ?, ?)");
$stmt->execute([$phone, $bundle, $qr_data]);

// frontend ko qr_data bhej do
echo json_encode([
    "success" => true,
    "message" => "eSIM generated",
    "qr_data" => $qr_data
]);

