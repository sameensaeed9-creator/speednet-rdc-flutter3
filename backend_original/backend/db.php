<?php
header('Content-Type: application/json');
$pdo = new PDO(
  'mysql:host='.(getenv('DB_HOST') ?: 'localhost').';dbname='.(getenv('DB_NAME') ?: 'speednet_db').';charset=utf8mb4',
  getenv('DB_USER') ?: 'speednet_user',
  getenv('DB_PASS') ?: 'speednet_password',
  [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC]
);
