<?php
session_start();
if (isset($_SESSION['admin']) && $_SESSION['admin'] === true) {
    header("Location: dashboard.php");
    exit();
}
$error = "";
if(isset($_POST['login'])){
    $user = trim($_POST['username'] ?? '');
    $pass = $_POST['password'] ?? '';
    if($user === "speednetrdc" && $pass === "speednetrdc#"){
        $_SESSION['admin'] = true;
        $_SESSION['admin_name'] = 'SpeedNet';
        header("Location: dashboard.php");
        exit();
    } else {
        $error = "Invalid admin name or password.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SpeedNet Admin Login</title>
  <link rel="stylesheet" href="style.css">
</head>
<body class="admin-login-body">
  <div class="admin-login-wrap">
    <div class="admin-login-card">
      <div class="admin-logo-pulse">SN</div>
      <p class="admin-kicker">Private Admin Access</p>
      <h1>SpeedNet Control Panel</h1>
      <p class="admin-muted">Login to manage packages bought, payment approvals and eSIM QR generation.</p>
      <?php if($error): ?><div class="admin-error"><?= htmlspecialchars($error) ?></div><?php endif; ?>
      <form method="POST" class="admin-form" autocomplete="off">
        <label>Admin Name</label>
        <input type="text" name="username" placeholder="Enter admin name" required>
        <label>Password</label>
        <input type="password" name="password" placeholder="Enter password" required>
        <button name="login" type="submit">Login to Dashboard</button>
      </form>
      <div class="admin-secret-note">This panel is hidden from the public website navigation.</div>
    </div>
  </div>
</body>
</html>
