-- Create the stored procedure
CREATE PROCEDURE Add11weatherstation()
BEGIN
    DECLARE park_exists INT;
    DECLARE id_exists INT;

    -- Check if the new coordinates match any park coordinates in the view
    SELECT COUNT(*) INTO park_exists
    FROM Parks, Weather_stations
    WHERE Parks.Location = @new_coordinates AND Weather_stations.coordinates <> @new_coordinates;

    -- Check if the weather station ID is unique
    SELECT COUNT(*) INTO id_exists
    FROM Weather_stations
    WHERE station_id = @new_station_id;

    -- Conditions for inserting the new weather station
    IF id_exists = 0 THEN
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
        SELECT 'Transaction Rolled Back' AS Result;
    END IF;
END;
