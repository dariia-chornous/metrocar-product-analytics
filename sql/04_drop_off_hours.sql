SELECT
    EXTRACT(HOUR FROM request_ts) AS hour_of_day,
    COUNT(DISTINCT user_id) AS accepted_users,
    COUNT(DISTINCT CASE WHEN dropoff_ts IS NOT NULL THEN user_id END) AS completed_users,
    ROUND(
    (COUNT(DISTINCT user_id)
     - COUNT(DISTINCT CASE WHEN dropoff_ts IS NOT NULL THEN user_id END))::numeric
    / NULLIF(COUNT(DISTINCT user_id), 0),
    3
    ) AS dropoff_rate
FROM ride_requests
WHERE request_ts IS NOT NULL
  AND accept_ts IS NOT NULL
GROUP BY hour_of_day
ORDER BY hour_of_day;
