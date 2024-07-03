START TRANSACTION;
-- set park id and coordinates which are going to be deleted
SET @park_id_to_delete = 3;
SET @coordinates_to_delete = (SELECT Location FROM Parks WHERE park_id = @park_id_to_delete);

-- delete all rows from tables which rely on the now deleted park
  DELETE FROM Location WHERE Coordinates = @coordinates_to_delete;
  DELETE FROM Weather_stations WHERE coordinates = @coordinates_to_delete;
  DELETE FROM national_park_ratings WHERE park_id = @park_id_to_delete;
  DELETE FROM Parks WHERE park_id = @park_id_to_delete;

-- commit the changes to the database
  COMMIT;
  SELECT 'Park and associated data deleted successfully.' AS Result;
