SELECT Park_name, avg_winter_temperature, avg_winter_precipitation, AVG(r.rating_value) AS average_rating
FROM national_park_ratings r
JOIN Parks p ON r.park_id = p.park_id
JOIN Weather_stations w ON p.Location = w.coordinates
WHERE EXTRACT(MONTH FROM date_visited) IN (12, 1, 2)
GROUP BY p.Park_name, w.avg_winter_temperature, w.avg_winter_precipitation;
