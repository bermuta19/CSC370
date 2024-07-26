CREATE TRIGGER trg_validate_rating
BEFORE INSERT ON national_park_ratings
FOR EACH ROW
BEGIN
    IF NEW.rating_value < 1 OR NEW.rating_value > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating value must be between 1 and 5';
    END IF;
END;

CREATE TRIGGER trg_auto_set_date_posted
BEFORE INSERT ON national_park_ratings
FOR EACH ROW
BEGIN
    SET NEW.date_posted = CURRENT_TIMESTAMP;
END;

CREATE TRIGGER trg_uppercase_park_name
BEFORE INSERT ON Parks
FOR EACH ROW
BEGIN
    SET NEW.Park_name = UPPER(NEW.Park_name);
END;

CREATE TRIGGER trg_uppercase_park_name_update
BEFORE UPDATE ON Parks
FOR EACH ROW
BEGIN
    SET NEW.Park_name = UPPER(NEW.Park_name);
END;
