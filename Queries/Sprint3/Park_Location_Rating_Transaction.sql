-- Start the transaction
START TRANSACTION;

-- Step 2: Insert a new location
INSERT INTO Location (Coordinates, Province, Address)
VALUES ('45.4215 -75.6972', 'Ontario', '1000 Palladium Dr, Ottawa, ON K2V 1A5');

-- Step 3: Determine the next park_id
SELECT IFNULL(MAX(park_id), 0) + 1 INTO @new_park_id FROM Parks;

-- Insert a new park with the new park_id
INSERT INTO Parks (park_id, Park_name, Year_established, Location)
VALUES (@new_park_id, 'New National Park', 2024, '45.4215,-75.6972');

-- Step 4: Get the next rating number
SELECT COUNT(*) + 1 INTO @next_rating_num FROM national_park_ratings;

-- Generate the new rating_id
SET @new_rating_id = CONCAT('rating', @next_rating_num);

-- Step 5: Insert a new user rating for the new park
INSERT INTO national_park_ratings (user_id, rating_id, rating_value, date_visited, date_posted, comment, park_id)
VALUES ('jsmith31', @new_rating_id, 5, '2024-07-01', '2024-07-02', 'Amazing new park!', @new_park_id);

-- Commit the transaction if all operations succeed
COMMIT;

-- Rollback the transaction if any operation fails
ROLLBACK;
