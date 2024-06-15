SELECT p.Park_name, ws.avg_summer_temperature, ws.avg_summer_precipitation
FROM Parks p
JOIN Weather_stations ws ON p.Location = ws.coordinates
ORDER BY ws.avg_summer_temperature DESC, ws.avg_summer_precipitation ASC
LIMIT 1;