SELECT Park_name, avg_summer_temperature, avg_summer_precipitation, AVG(r.rating_value) AS average_rating
FROM national_park_ratings r
JOIN Parks p ON r.park_id = p.park_id
JOIN Weather_stations w ON p.Location = w.coordinates
WHERE EXTRACT(MONTH FROM date_visited) IN (6, 7, 8)
GROUP BY p.Park_name, w.avg_summer_temperature, w.avg_summer_precipitation;
