<?php
$dir="../uploads/";
if(!file_exists($dir)) mkdir($dir);

$name=uniqid().$_FILES['file']['name'];
move_uploaded_file($_FILES['file']['tmp_name'],$dir.$name);

$data=json_encode(["tx"=>$_POST['tx'],"file"=>$name,"status"=>"pending"]);
file_put_contents("../orders.txt",$data."\n",FILE_APPEND);
echo "ok";
?>