CREATE VIEW Park_Winter_Weather_Info AS
SELECT p.Park_name, ws.avg_winter_temperature, ws.avg_winter_precipitation
FROM Parks p
JOIN weather_stations ws ON p.coordinates = ws.coordinates
ORDER BY ws.avg_winter_temperature ASC, ws.avg_winter_precipitation DESC
LIMIT 1;
