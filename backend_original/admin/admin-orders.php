<?php
$file = '../orders.txt';
if($_SERVER['REQUEST_METHOD']=='POST'){
 $data = file_get_contents('php://input');
 file_put_contents($file, $data."\n", FILE_APPEND);
 echo "saved";
}
?>