<?php
return [
 'client_id' => getenv('AIRALO_CLIENT_ID') ?: 'PUT_AIRALO_CLIENT_ID_HERE',
 'client_secret' => getenv('AIRALO_CLIENT_SECRET') ?: 'PUT_AIRALO_CLIENT_SECRET_HERE',
 'base_url' => getenv('AIRALO_BASE_URL') ?: 'https://partners-api.airalo.com',
 'countries' => ['CD','CG','AO'],
 'language' => 'en',
 'limit' => 100
];
