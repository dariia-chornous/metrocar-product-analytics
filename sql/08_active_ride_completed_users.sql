SELECT
    s.age_range AS age_group,
    COUNT(DISTINCT rr.user_id) AS active_users,
    COUNT(DISTINCT CASE
        WHEN rr.dropoff_ts IS NOT NULL THEN rr.user_id
    END) AS ride_completed_users
FROM signups s
JOIN ride_requests rr
    ON s.user_id = rr.user_id
GROUP BY s.age_range
ORDER BY age_range;
