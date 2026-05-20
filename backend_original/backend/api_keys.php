<?php
// SpeedNet private/server keys. Keep this file private and never upload it publicly outside your hosting.
// Manual payment is used now: Orange Money / MPSA. Stripe and Wise have been removed.

// LIVE MODE: true = SpeedNet live API, false = SpeedNet sandbox API
$AIRALO_LIVE_MODE = true;

// Manual payment display details
$AIRTEL_MONEY_NUMBER = '+243892399476';
$UNITEL_MONEY_NUMBER = '+243823778982';
$MANUAL_PAYMENT_ACCOUNT_NAME = 'SpeedNet RDC';

// SpeedNet Partner API credentials
$AIRALO_CLIENT_ID = '3f18c480dce4613d3e7adb9139b9c712';
$AIRALO_CLIENT_SECRET = '809srZGBqRw2krXvYIra0Wy6NPGPddoHdbapNjBk';
$AIRALO_BASE_URL = $AIRALO_LIVE_MODE ? 'https://partners-api.speednet.com' : 'https://sandbox-partners-api.speednet.com';

function speednet_json($arr, $status = 200) {
    http_response_code($status);
    header('Content-Type: application/json');
    echo json_encode($arr);
    exit;
}

function speednet_get_token() {
    global $AIRALO_CLIENT_ID, $AIRALO_CLIENT_SECRET, $AIRALO_BASE_URL;

    if (!$AIRALO_CLIENT_ID || !$AIRALO_CLIENT_SECRET || strpos($AIRALO_CLIENT_ID, 'PASTE_') !== false || strpos($AIRALO_CLIENT_SECRET, 'PASTE_') !== false) {
        return null;
    }

    $cacheFile = __DIR__ . '/speednet_token_cache.json';
    if (file_exists($cacheFile)) {
        $cached = json_decode(file_get_contents($cacheFile), true);
        if (!empty($cached['access_token']) && !empty($cached['expires_at']) && $cached['expires_at'] > time() + 120) {
            return $cached['access_token'];
        }
    }

    $url = rtrim($AIRALO_BASE_URL, '/') . '/v2/token';
    $payload = http_build_query([
        'client_id' => $AIRALO_CLIENT_ID,
        'client_secret' => $AIRALO_CLIENT_SECRET,
        'grant_type' => 'client_credentials'
    ]);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_HTTPHEADER => ['Content-Type: application/x-www-form-urlencoded'],
        CURLOPT_TIMEOUT => 30
    ]);
    $response = curl_exec($ch);
    $error = curl_error($ch);
    $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($error || $http >= 400) {
        return null;
    }

    $data = json_decode($response, true);
    $token = $data['access_token'] ?? $data['data']['access_token'] ?? null;
    $expiresIn = intval($data['expires_in'] ?? $data['data']['expires_in'] ?? 3600);

    if ($token) {
        @file_put_contents($cacheFile, json_encode([
            'access_token' => $token,
            'expires_at' => time() + max(300, $expiresIn - 60)
        ]));
    }

    return $token;
}

function speednet_request($method, $path, $body = null) {
    global $AIRALO_BASE_URL;
    $token = speednet_get_token();
    if (!$token) {
        return ['ok' => false, 'message' => 'SpeedNet access token could not be generated. Check Client ID/Secret and live/sandbox approval.'];
    }

    $ch = curl_init(rtrim($AIRALO_BASE_URL, '/') . $path);
    $headers = ['Authorization: Bearer ' . $token, 'Accept: application/json'];
    $opts = [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 45, CURLOPT_HTTPHEADER => $headers];

    if (strtoupper($method) === 'POST') {
        $headers[] = 'Content-Type: application/json';
        $opts[CURLOPT_POST] = true;
        $opts[CURLOPT_POSTFIELDS] = json_encode($body ?: []);
        $opts[CURLOPT_HTTPHEADER] = $headers;
    }

    curl_setopt_array($ch, $opts);
    $response = curl_exec($ch);
    $error = curl_error($ch);
    $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($error) return ['ok' => false, 'message' => $error];

    $data = json_decode($response, true);
    if ($http >= 400) {
        return ['ok' => false, 'http' => $http, 'message' => 'SpeedNet API error', 'response' => $data ?: $response];
    }

    return ['ok' => true, 'http' => $http, 'response' => $data ?: $response];
}
?>
