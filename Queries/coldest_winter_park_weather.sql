SELECT p.Park_name, ws.avg_winter_temperature, ws.avg_winter_precipitation
FROM Parks p
JOIN Weather_stations ws ON p.Location = ws.coordinates
ORDER BY ws.avg_winter_temperature ASC, ws.avg_winter_precipitation DESC
LIMIT 1;
