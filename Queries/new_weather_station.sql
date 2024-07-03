-- Assign new weather station values
SET @new_station_id = "ACB2V3D4E5";
SET @new_avg_summer_tmp = 25.0;
SET @new_avg_winter_tmp = -5.0;
SET @new_avg_summer_rain = 230.0;
SET @new_avg_winter_rain = 50.0;
SET @new_coordinates = '54.2500 -126.0000';

START TRANSACTION;

-- Check if the new coordinates match any park coordinates in the view
SELECT COUNT(*) INTO @park_exists
FROM parks_without_weather_station
WHERE Location = @new_coordinates;

-- Check if the weather station ID is unique
SELECT COUNT(*) INTO @id_exists
FROM Weather_stations
WHERE station_id = @new_station_id;

-- Conditions for inserting the new weather station
IF @park_exists > 0 AND @id_exists = 0 THEN
    -- Insert the new weather station
    INSERT INTO Weather_stations (
        station_id, avg_summer_temperature, avg_winter_temperature,
        avg_summer_precipitation, avg_winter_precipitation, coordinates
    ) VALUES (
        @new_station_id, @new_avg_summer_tmp, @new_avg_winter_tmp,
        @new_avg_summer_rain, @new_avg_winter_rain, @new_coordinates
    );

    -- Commit the transaction
    COMMIT;
    SELECT 'Transaction Committed' AS Result;
ELSE
    -- Rollback the transaction
    ROLLBACK;
END IF;