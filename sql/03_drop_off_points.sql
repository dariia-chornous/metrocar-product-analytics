WITH base AS (  
    SELECT
        ad.app_download_key,
        s.user_id
    FROM app_downloads ad
    LEFT JOIN signups s
        ON s.session_id = ad.app_download_key
),
funnel AS (
    SELECT 'Download' AS funnel_step, 1 AS step_order,
           COUNT(DISTINCT app_download_key) AS users
    FROM base

    UNION ALL
    SELECT 'Signup', 2,
           COUNT(DISTINCT user_id)
    FROM base
    WHERE user_id IS NOT NULL

    UNION ALL
    SELECT 'Ride requested', 3,
           COUNT(DISTINCT rr.user_id)
    FROM ride_requests rr
    JOIN base b ON b.user_id = rr.user_id
    WHERE rr.request_ts IS NOT NULL

    UNION ALL
    SELECT 'Ride accepted', 4,
           COUNT(DISTINCT rr.user_id)
    FROM ride_requests rr
    JOIN base b ON b.user_id = rr.user_id
    WHERE rr.request_ts IS NOT NULL
      AND rr.accept_ts IS NOT NULL

    UNION ALL
    SELECT 'Ride completed', 5,
           COUNT(DISTINCT rr.user_id)
    FROM ride_requests rr
    JOIN base b ON b.user_id = rr.user_id
    WHERE rr.request_ts IS NOT NULL
      AND rr.accept_ts IS NOT NULL
      AND rr.dropoff_ts IS NOT NULL

    UNION ALL
    SELECT 'Payment', 6,
           COUNT(DISTINCT rr.user_id)
    FROM ride_requests rr
    JOIN base b ON b.user_id = rr.user_id
    JOIN transactions t ON t.ride_id = rr.ride_id
    WHERE rr.dropoff_ts IS NOT NULL
      AND t.charge_status ILIKE 'approved'

    UNION ALL
    SELECT 'Review', 7,
           COUNT(DISTINCT r.user_id)
    FROM reviews r
    JOIN ride_requests rr ON rr.ride_id = r.ride_id
    JOIN base b ON b.user_id = r.user_id
    WHERE rr.dropoff_ts IS NOT NULL
),
pairs AS (
    SELECT
        funnel_step AS to_step,
        users AS users_to,
        step_order,
        LAG(funnel_step) OVER (ORDER BY step_order) AS from_step,
        LAG(users) OVER (ORDER BY step_order) AS users_from
    FROM funnel
)
SELECT
    from_step,
    to_step,
    users_from,
    users_to,
    (users_from - users_to) AS users_lost,
    ROUND((users_from - users_to)::numeric / NULLIF(users_from, 0), 3) AS dropoff_rate
FROM pairs
WHERE from_step IS NOT NULL
ORDER BY step_order;

