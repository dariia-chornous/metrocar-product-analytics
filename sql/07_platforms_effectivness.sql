WITH downloads AS (
    SELECT
        platform,
        COUNT(DISTINCT app_download_key) AS downloads
    FROM app_downloads
    GROUP BY platform
),
payments AS (
    SELECT
        ad.platform,
        COUNT(DISTINCT s.user_id) AS paid_users,
        SUM(t.purchase_amount_usd) AS total_revenue_usd
    FROM app_downloads ad
    JOIN signups s
        ON s.session_id = ad.app_download_key
    JOIN ride_requests rr
        ON rr.user_id = s.user_id
    JOIN transactions t
        ON t.ride_id = rr.ride_id
    WHERE t.charge_status ILIKE 'approved'
    GROUP BY ad.platform
)
SELECT
    d.platform,
    d.downloads,
    COALESCE(p.paid_users, 0) AS paid_users,
    ROUND(COALESCE(p.paid_users, 0)::numeric / NULLIF(d.downloads, 0), 3) AS conversion_to_payment,
    COALESCE(p.total_revenue_usd, 0) AS total_revenue_usd,
    ROUND(COALESCE(p.total_revenue_usd, 0)::numeric / NULLIF(d.downloads, 0), 2) AS revenue_per_download_usd
FROM downloads d
LEFT JOIN payments p
    ON p.platform = d.platform
ORDER BY revenue_per_download_usd DESC;
