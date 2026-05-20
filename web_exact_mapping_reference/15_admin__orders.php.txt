<?php include "auth.php"; ?>
<?php
$file = __DIR__ . "/../backend/manual_orders.json";
$orders = file_exists($file) ? json_decode(file_get_contents($file), true) : [];
if(!is_array($orders)) $orders = [];
$orders = array_reverse($orders);
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
<title>Payment Approvals • SpeedNet</title>
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrious/4.0.2/qrious.min.js"></script>
</head>
<body class="admin-body">
<aside class="admin-sidebar">
  <div class="admin-brand"><span>SN</span><div><b>SpeedNet RDC</b><small>Premium Admin</small></div></div>
  <a href="dashboard.php">Dashboard</a>
  <a class="active" href="orders.php">Payment Approvals</a>
  <a href="../index.html" target="_blank">View Website</a>
  <a href="logout.php">Logout</a>
</aside>

<main class="admin-main">
<header class="admin-topbar">
  <div><p class="admin-kicker">Manual Payment Approval</p><h1>Orange Money / MPSA Orders</h1><p class="admin-muted">Approve payment proof. The client will see the eSIM QR on My eSIMs page.</p></div>
  <a class="admin-logout" href="dashboard.php">← Dashboard</a>
</header>

<section class="admin-panel-card">
<?php if(!$orders): ?>
  <div class="admin-empty">No manual payment submissions yet.</div>
<?php else: ?>
  <div class="admin-table-wrap">
    <table class="admin-table">
      <thead><tr><th>Order</th><th>Payment Details</th><th>Package Bought</th><th>Proof</th><th>Status / QR</th><th>Admin Action</th></tr></thead>
      <tbody>
      <?php foreach($orders as $o): 
        $status = $o['status'] ?? 'pending';
        $qrPayload = $o['qr_payload'] ?? $o['esim_code'] ?? '';
      ?>
        <tr>
          <td>
            <b><?= h($o['id'] ?? '') ?></b>
            <small><?= h($o['created_at'] ?? '') ?></small>
            <small>Customer: <?= h($o['customer_phone'] ?? '-') ?></small>
          </td>
          <td>
            <b><?= h($o['method'] ?? '') ?></b>
            <small>Txn: <?= h($o['transaction_id'] ?? '') ?></small>
            <small>Sender: <?= h($o['sender_phone'] ?? '') ?></small>
            <small>Amount: <?= h(($o['amount'] ?? '').' '.($o['currency'] ?? 'FC')) ?></small>
          </td>
          <td>
            <?= h($o['description'] ?? '') ?>
            <small>Package ID: <?= h($o['package_id'] ?? '-') ?></small>
          </td>
          <td>
            <?php if(!empty($o['screenshot'])): ?>
              <a class="admin-view" target="_blank" href="../<?= h($o['screenshot']) ?>">View proof</a>
            <?php else: ?>
              <span class="admin-muted">No file</span>
            <?php endif; ?>
          </td>
          <td>
            <?= badge($status) ?>
            <?php if(!empty($o['esim_code'])): ?>
              <small><b>eSIM:</b> <?= h($o['esim_code']) ?></small>
              <canvas class="qr-canvas" data-qr="<?= h($qrPayload) ?>"></canvas>
              <button type="button" class="admin-view copy-btn" data-copy="<?= h($o['esim_code']) ?>">Copy eSIM Code</button>
            <?php endif; ?>
            <?php if(!empty($o['admin_note'])): ?><small><?= h($o['admin_note']) ?></small><?php endif; ?>
            <?php if(!empty($o['speednet_note'])): ?><small><?= h($o['speednet_note']) ?></small><?php endif; ?>
          </td>
          <td>
            <?php if($status === 'pending'): ?>
              <form method="post" action="approve_order.php" class="action-form">
                <input type="hidden" name="id" value="<?= h($o['id'] ?? '') ?>">
                <textarea name="admin_note" placeholder="Optional admin note"></textarea>
                <button class="admin-action approve" name="action" value="approve">Approve Payment + Send QR to Client</button>
                <button class="admin-action reject" name="action" value="reject">Reject Payment</button>
              </form>
            <?php else: ?>
              <span class="admin-muted">Processed</span>
            <?php endif; ?>
          </td>
        </tr>
      <?php endforeach; ?>
      </tbody>
    </table>
  </div>
<?php endif; ?>
</section>
</main>
<script>
document.querySelectorAll('.qr-canvas').forEach(function(canvas){
  const value = canvas.getAttribute('data-qr') || '';
  if(value && window.QRious){
    new QRious({element: canvas, value: value, size: 118});
  }
});
document.querySelectorAll('.copy-btn').forEach(function(btn){
  btn.addEventListener('click', function(){
    const text = this.getAttribute('data-copy') || '';
    navigator.clipboard && navigator.clipboard.writeText(text);
    this.textContent = 'Copied';
    setTimeout(()=>this.textContent='Copy eSIM Code', 1200);
  });
});
</script>
</body>
</html>
