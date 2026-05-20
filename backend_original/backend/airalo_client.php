<?php
function airalo_cfg(){ return require __DIR__.'/airalo_config.php'; }
function airalo_call($method,$path,$body=null,$token=null){
 $c=airalo_cfg(); $ch=curl_init(rtrim($c['base_url'],'/').$path);
 $h=['Accept: application/json']; if($token)$h[]='Authorization: Bearer '.$token; if($body)$h[]='Content-Type: application/json';
 curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_CUSTOMREQUEST=>$method,CURLOPT_HTTPHEADER=>$h,CURLOPT_TIMEOUT=>45]);
 if($body) curl_setopt($ch,CURLOPT_POSTFIELDS,json_encode($body));
 $raw=curl_exec($ch); $code=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
 if($code<200||$code>=300) throw new Exception('Airalo API error '.$code.': '.$raw);
 return json_decode($raw,true) ?: [];
}
function airalo_token(){
 $c=airalo_cfg();
 $r=airalo_call('POST','/v2/token',['client_id'=>$c['client_id'],'client_secret'=>$c['client_secret'],'grant_type'=>'client_credentials']);
 $t=$r['data']['access_token'] ?? $r['access_token'] ?? null;
 if(!$t) throw new Exception('Access token missing');
 return $t;
}
function airalo_norm($p,$country){
 $id=$p['id'] ?? $p['package_id'] ?? $p['slug'] ?? '';
 return [
  'package_id'=>(string)$id,
  'country_code'=>$country,
  'title'=>(string)($p['title'] ?? $p['name'] ?? $id),
  'data_amount'=>(string)($p['data'] ?? $p['amount'] ?? ''),
  'validity'=>(string)($p['validity'] ?? $p['days'] ?? ''),
  'net_price'=>isset($p['net_price'])?(float)$p['net_price']:(isset($p['price'])?(float)$p['price']:null),
  'currency'=>(string)($p['currency'] ?? 'USD'),
  'raw_json'=>json_encode($p,JSON_UNESCAPED_UNICODE)
 ];
}
