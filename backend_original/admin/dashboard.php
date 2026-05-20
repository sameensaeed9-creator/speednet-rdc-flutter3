<?php include "auth.php"; ?>
<?php
$orders_file = __DIR__ . "/../backend/manual_orders.json";
$orders = file_exists($orders_file) ? json_decode(file_get_contents($orders_file), true) : [];
if(!is_array($orders)) $orders = [];

$total_orders = count($orders);
$pending = count(array_filter($orders, fn($o)=>($o['status']??'pending')==='pending'));
$approved = count(array_filter($orders, fn($o)=>str_contains(($o['status']??''),'approved')));
$rejected = count(array_filter($orders, fn($o)=>($o['status']??'')==='rejected'));
$total_amount = array_sum(array_map(fn($o)=>floatval(str_replace(',','',$o['amount'] ?? 0)), $orders));
$latest_orders = array_slice(array_reverse($orders), 0, 8);
function money_fc($n){ return number_format((float)$n, 0) . ' FC'; }
function h($v){ return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
function badge($status){
  $status = $status ?: 'pending';
  return '<span class="status-badge status-'.h(str_replace('_','-',strtolower($status))).'">'.h($status).'</span>';
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SpeedNet Premium Admin</title>
<link rel="stylesheet" href="style.css">
</head>
<body class="admin-body">
<aside class="admin-sidebar">
  <div class="admin-brand"><span>SN</span><div><b>SpeedNet RDC</b><small>Premium Admin</small></div></div>
  <a class="active" href="dashboard.php">Dashboard</a>
  <a href="orders.php">Payment Approvals</a>
  <a href="../index.html" target="_blank">View Website</a>
  <a href="logout.php">Logout</a>
</aside>
<main class="admin-main">
<header class="admin-topbar">
  <div><p class="admin-kicker">Welcome, SpeedNet RDC</p><h1>Admin Dashboard</h1><p class="admin-muted">Track packages bought, verify manual payments, and generate eSIM QR codes.</p></div>
  <a class="admin-logout" href="orders.php">Review Payments</a>
</header>

<section class="stats-grid">
  <div class="stat-card"><small>Total Packages Bought</small><b><?= $total_orders ?></b><span>All payment submissions</span></div>
  <div class="stat-card warning"><small>Pending Payments</small><b><?= $pending ?></b><span>Need admin approval</span></div>
  <div class="stat-card success"><small>Approved / QR Generated</small><b><?= $approved ?></b><span>Activated orders</span></div>
  <div class="stat-card danger"><small>Rejected</small><b><?= $rejected ?></b><span>Declined requests</span></div>
  <div class="stat-card wide"><small>Total Submitted Amount</small><b><?= money_fc($total_amount) ?></b><span>Orange Money + MPSA</span></div>
</section>

<section class="admin-panel-card">
  <div class="panel-head"><div><p class="admin-kicker">Latest Orders</p><h2>Recent Package Purchases</h2></div><a class="admin-view" href="orders.php">Open full approvals</a></div>
  <?php if(!$latest_orders): ?>
    <div class="admin-empty">No package purchases yet.</div>
  <?php else: ?>
  <div class="admin-table-wrap">
    <table class="admin-table">
      <thead><tr><th>Order ID</th><th>Package</th><th>Payment</th><th>Status</th></tr></thead>
      <tbody>
      <?php foreach($latest_orders as $o): ?>
        <tr>
          <td><b><?= h($o['id'] ?? '') ?></b><small><?= h($o['created_at'] ?? '') ?></small></td>
          <td><?= h($o['description'] ?? '') ?><small><?= h($o['customer_phone'] ?? '-') ?></small></td>
          <td><?= h($o['method'] ?? '') ?><small><?= h(($o['amount'] ?? '').' '.($o['currency'] ?? 'FC')) ?></small></td>
          <td><?= badge($o['status'] ?? 'pending') ?></td>
        </tr>
      <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php endif; ?>
</section>
</main>
</body>
</html>
