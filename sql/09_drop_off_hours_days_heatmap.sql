WITH base AS (
    SELECT
        user_id,
        EXTRACT(HOUR FROM request_ts) AS hour_of_day,
        TRIM(TO_CHAR(request_ts, 'Day')) AS day_of_week,
        EXTRACT(ISODOW FROM request_ts) AS day_order,
        dropoff_ts
    FROM ride_requests
    WHERE request_ts IS NOT NULL
      AND accept_ts IS NOT NULL
),
agg AS (
    SELECT
        day_of_week,
        day_order,
        hour_of_day,
        COUNT(DISTINCT user_id) AS accepted_users,
        COUNT(DISTINCT user_id) FILTER (WHERE dropoff_ts IS NOT NULL) AS completed_users
    FROM base
    GROUP BY day_of_week, day_order, hour_of_day
)
SELECT
    day_of_week,
    day_order,
    hour_of_day,
    accepted_users,
    completed_users,
    ROUND(
        (accepted_users - completed_users)::numeric
        / NULLIF(accepted_users, 0),
        3
    ) AS dropoff_rate
FROM agg
ORDER BY day_order, hour_of_day;
