WITH base AS (
    SELECT
        TRIM(TO_CHAR(request_ts, 'Day')) AS day_of_week,
        EXTRACT(ISODOW FROM request_ts) AS day_order,
        user_id,
        dropoff_ts
    FROM ride_requests
    WHERE request_ts IS NOT NULL
      AND accept_ts IS NOT NULL
)
SELECT
    day_of_week,
    COUNT(DISTINCT user_id) AS accepted_users,
    COUNT(DISTINCT CASE WHEN dropoff_ts IS NOT NULL THEN user_id END) AS completed_users,
    ROUND(
        (COUNT(DISTINCT user_id)
         - COUNT(DISTINCT CASE WHEN dropoff_ts IS NOT NULL THEN user_id END))::numeric
        / NULLIF(COUNT(DISTINCT user_id), 0),
        3
    ) AS dropoff_rate
FROM base
GROUP BY day_of_week, day_order
ORDER BY day_order;




