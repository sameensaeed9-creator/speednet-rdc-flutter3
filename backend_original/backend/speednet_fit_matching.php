<?php
// SpeedNet RDC - Fit matching helper
// Purpose: Web wali tarah SpeedNet package ko Airalo latest synced packages ke sath match karna.
// Exact ID match first, phir data+validity closest fit. Best fit available, no fit unavailable.

function speednet_parse_mb(string $text): float {
    $t = strtolower(str_replace([',',' '], '', $text));
    if (preg_match('/([0-9]+(?:\.[0-9]+)?)gb/', $t, $m)) return floatval($m[1]) * 1000;
    if (preg_match('/([0-9]+(?:\.[0-9]+)?)mb/', $t, $m)) return floatval($m[1]);
    return 0;
}

function speednet_parse_days(string $text): int {
    $t = strtolower($text);
    if (preg_match('/([0-9]+)\s*(day|days|d|jour|jours|dia|dias)/', $t, $m)) return intval($m[1]);
    return 0;
}

function speednet_find_fit_package(PDO $pdo, array $speednet): ?array {
    $speednetKey = $speednet['speednet_bundle_key'] ?? '';
    $explicitId = $speednet['airalo_package_id'] ?? '';
    $name = $speednet['name'] ?? '';
    $validity = $speednet['validity'] ?? '';
    $country = $speednet['country_code'] ?? null;

    // 1) Exact mapped Airalo package ID must be active.
    if ($explicitId) {
        $stmt = $pdo->prepare("SELECT * FROM airalo_packages WHERE package_id=? AND is_active=1 LIMIT 1");
        $stmt->execute([$explicitId]);
        $row = $stmt->fetch();
        if ($row) return $row;
    }

    // 2) Existing map table exact key check.
    if ($speednetKey) {
        $stmt = $pdo->prepare("SELECT p.* FROM speednet_bundle_airalo_map m JOIN airalo_packages p ON p.package_id=m.airalo_package_id WHERE m.speednet_bundle_key=? AND p.is_active=1 LIMIT 1");
        $stmt->execute([$speednetKey]);
        $row = $stmt->fetch();
        if ($row) return $row;
    }

    // 3) Similar fit: data MB within ±15%, validity equal/close.
    $targetMb = speednet_parse_mb($name . ' ' . ($speednet['data'] ?? ''));
    $targetDays = speednet_parse_days($validity);

    if ($targetMb <= 0) return null;

    $sql = "SELECT * FROM airalo_packages WHERE is_active=1";
    $params = [];
    if ($country) {
        $sql .= " AND country_code=?";
        $params[] = $country;
    }
    $rows = $pdo->prepare($sql);
    $rows->execute($params);

    $best = null;
    $bestScore = 999999;

    foreach ($rows->fetchAll() as $pkg) {
        $pkgMb = speednet_parse_mb(($pkg['title'] ?? '') . ' ' . ($pkg['data_amount'] ?? ''));
        $pkgDays = speednet_parse_days(($pkg['validity'] ?? '') . ' days');

        if ($pkgMb <= 0) continue;

        $ratio = abs($pkgMb - $targetMb) / max($targetMb, 1);
        if ($ratio > 0.15) continue; // milti julti only

        $dayPenalty = 0;
        if ($targetDays > 0 && $pkgDays > 0) {
            $dayPenalty = abs($pkgDays - $targetDays);
            if ($dayPenalty > 3 && $targetDays <= 10) continue;
            if ($dayPenalty > 7 && $targetDays > 10) continue;
        }

        $score = ($ratio * 100) + $dayPenalty;
        if ($score < $bestScore) {
            $bestScore = $score;
            $best = $pkg;
        }
    }

    return $best;
}

function speednet_package_availability(PDO $pdo, array $speednet): array {
    $fit = speednet_find_fit_package($pdo, $speednet);

    if (!$fit) {
        return [
            'available' => false,
            'label' => 'Unavailable',
            'matched_package_id' => null,
            'reason' => 'No active matching Airalo package found',
        ];
    }

    return [
        'available' => true,
        'label' => 'Available',
        'matched_package_id' => $fit['package_id'],
        'matched_title' => $fit['title'] ?? '',
        'matched_data' => $fit['data_amount'] ?? '',
        'matched_validity' => $fit['validity'] ?? '',
        'reason' => 'Active exact/similar package found',
    ];
}
