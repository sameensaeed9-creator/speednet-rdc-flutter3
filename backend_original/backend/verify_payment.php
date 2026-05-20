<?php
require_once __DIR__ . '/api_keys.php';
speednet_json(['ok'=>false,'message'=>'Automatic Stripe verification removed. Manual payment approval is handled in admin/orders.php.'], 410);
?>
