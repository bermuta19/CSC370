CREATE OR REPLACE VIEW parks_without_weather_station AS
SELECT p.park_id, p.Park_name, p.Location
FROM Parks p
LEFT JOIN Weather_stations ws ON p.Location = ws.coordinates
WHERE ws.coordinates IS NULL;
