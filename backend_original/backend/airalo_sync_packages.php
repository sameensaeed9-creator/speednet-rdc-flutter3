<?php
require __DIR__.'/db.php'; require __DIR__.'/airalo_client.php';
try{
 $cfg=airalo_cfg(); $token=airalo_token(); $seen=[]; $fetched=0;
 foreach($cfg['countries'] as $country){
  $path='/v2/packages?filter[country]='.urlencode($country).'&filter[type]=local&include=topup&limit='.(int)$cfg['limit'].'&language='.urlencode($cfg['language']);
  $resp=airalo_call('GET',$path,null,$token);
  foreach(($resp['data'] ?? []) as $pkg){
   $n=airalo_norm($pkg,$country); if(!$n['package_id']) continue;
   $seen[]=$n['package_id']; $fetched++;
   $stmt=$pdo->prepare("INSERT INTO airalo_packages(package_id,country_code,title,data_amount,validity,net_price,currency,is_active,raw_json,last_seen_at)
   VALUES(:package_id,:country_code,:title,:data_amount,:validity,:net_price,:currency,1,:raw_json,NOW())
   ON DUPLICATE KEY UPDATE country_code=VALUES(country_code),title=VALUES(title),data_amount=VALUES(data_amount),validity=VALUES(validity),net_price=VALUES(net_price),currency=VALUES(currency),is_active=1,raw_json=VALUES(raw_json),last_seen_at=NOW(),updated_at=NOW()");
   $stmt->execute($n);
  }
 }
 if($seen){
  $ph=implode(',',array_fill(0,count($seen),'?'));
  $pdo->prepare("UPDATE airalo_packages SET is_active=0,updated_at=NOW() WHERE package_id NOT IN ($ph)")->execute($seen);
 }
 $pdo->exec("UPDATE speednet_bundle_airalo_map m LEFT JOIN airalo_packages p ON p.package_id=m.airalo_package_id SET m.is_active=IF(p.package_id IS NOT NULL AND p.is_active=1,1,0),m.updated_at=NOW()");
 $active=(int)$pdo->query("SELECT COUNT(*) FROM airalo_packages WHERE is_active=1")->fetchColumn();
 $inactive=(int)$pdo->query("SELECT COUNT(*) FROM airalo_packages WHERE is_active=0")->fetchColumn();
 $pdo->prepare("INSERT INTO airalo_sync_logs(status,message,fetched_count,active_count,inactive_count) VALUES('success','Packages synced',?,?,?)")->execute([$fetched,$active,$inactive]);
 echo json_encode(['ok'=>true,'fetched_count'=>$fetched,'active_count'=>$active,'inactive_count'=>$inactive]);
}catch(Throwable $e){
 if(isset($pdo)) $pdo->prepare("INSERT INTO airalo_sync_logs(status,message) VALUES('error',?)")->execute([$e->getMessage()]);
 http_response_code(500); echo json_encode(['ok'=>false,'error'=>$e->getMessage()]);
}
