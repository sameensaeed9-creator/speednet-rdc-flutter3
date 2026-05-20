<?php
require_once "config.php";

$phone      = isset($_POST['phone']) ? trim($_POST['phone']) : '';
$bundle     = isset($_POST['bundle_name']) ? trim($_POST['bundle_name']) : '';
$amount     = isset($_POST['amount']) ? intval($_POST['amount']) : 0;

if ($phone == '' || $bundle == '' || $amount <= 0) {
    echo json_encode(["success" => false, "message" => "Missing fields"]);
    exit;
}

// abhi sirf confirm kar rahe hain, details agar chaho to alag table me save kar sakti ho
echo json_encode(["success" => true, "message" => "Form ok, proceed to payment"]);

