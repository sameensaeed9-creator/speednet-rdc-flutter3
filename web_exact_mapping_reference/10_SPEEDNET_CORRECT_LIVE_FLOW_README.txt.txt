SpeedNet Correct Live Package Flow

1) Bundle/Special Offer Buy Click
- script.js calls backend/package_status.php?fresh=1&package_id=...
- If the package is missing/discontinued/out of stock, the user sees:
  "This package is currently unavailable. Please select another package."
- Payment page does not open for unavailable packages.

2) Payment Page
- payment.html checks the latest package availability again on page load.
- Submit button is disabled if unavailable.
- On submit, it checks latest availability again before uploading payment proof.

3) Backend Payment Submit
- backend/manual_payment_submit.php requires bundleId/package_id.
- It calls speednet_check_package_availability($packageId, true).
- If unavailable, order is not saved and payment proof is rejected.

4) Admin Approval
- admin/approve_order.php calls speednet_check_package_availability($packageId, true) before creating the SpeedNet/Airalo order.
- If unavailable, status becomes approved_speednet_package_unavailable and no eSIM order is created.

5) Package Sync
- backend/sync_packages.php can still be run every hour from cron:
  php /home/USER/public_html/backend/sync_packages.php
- The important submit/approve checks now force fresh sync too, so unavailable packages are blocked even before cron runs.

Upload these updated files especially:
- script.js
- payment.html
- style.css
- backend/speednet_package_map.php
- backend/package_status.php
- backend/manual_payment_submit.php
- admin/approve_order.php
