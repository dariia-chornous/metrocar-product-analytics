WITH rides AS (
    SELECT
        rr.ride_id,
        EXTRACT(EPOCH FROM (rr.accept_ts - rr.request_ts)) / 60.0 AS time_to_accept_min,
        rr.cancel_ts,
        rr.dropoff_ts
    FROM ride_requests rr
    WHERE rr.request_ts IS NOT NULL
      AND rr.accept_ts IS NOT NULL
      AND rr.accept_ts >= rr.request_ts
),
bucketed AS (
    SELECT
        ride_id,
        CASE
            WHEN time_to_accept_min < 2  THEN '<2 min'
            WHEN time_to_accept_min < 5  THEN '2–5 min'
            WHEN time_to_accept_min < 10 THEN '5–10 min'
            ELSE '10+ min'
        END AS time_to_accept_bucket,
        CASE
            WHEN cancel_ts IS NOT NULL AND dropoff_ts IS NULL THEN 1
            ELSE 0
        END AS cancelled_after_accept_flag
    FROM rides
)
SELECT
    time_to_accept_bucket,
    COUNT(DISTINCT ride_id) AS accepted_rides,
    COUNT(DISTINCT ride_id) FILTER (WHERE cancelled_after_accept_flag = 1) AS cancelled_after_accept_rides,
    ROUND(
        COUNT(DISTINCT ride_id) FILTER (WHERE cancelled_after_accept_flag = 1)::numeric
        / NULLIF(COUNT(DISTINCT ride_id), 0),
        3
    ) AS cancelled_after_accept_rate
FROM bucketed
GROUP BY time_to_accept_bucket
ORDER BY
    CASE time_to_accept_bucket
        WHEN '<2 min' THEN 1
        WHEN '2–5 min' THEN 2
        WHEN '5–10 min' THEN 3
        ELSE 4
    END;



