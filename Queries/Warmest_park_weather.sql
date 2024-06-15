CREATE VIEW Park_Weather_Info AS
SELECT p.Park_name, ws.avg_summer_temp, ws.avg_summer_rain
FROM Parks p
JOIN weather_stations ws ON p.coordinates = ws.coordinates
ORDER BY ws.avg_summer_temp DESC, ws.avg_summer_rain ASC
LIMIT 1;
