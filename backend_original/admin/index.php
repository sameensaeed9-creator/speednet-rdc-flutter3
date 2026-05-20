<?php
session_start();
if(isset($_SESSION['admin']) && $_SESSION['admin'] === true){
  header("Location: dashboard.php");
} else {
  header("Location: login.php");
}
exit();
?>