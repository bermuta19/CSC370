-- create view for seeing limited access of ratings table
CREATE VIEW free_ratings AS
SELECT rating_id,rating_value,comment,park_id
FROM national_park_ratings

-- create free user User
CREATE USER 'Free_User'@'%' IDENTIFIED BY 'password';

-- grant them ability to query limited access ratings table
GRANT SELECT ON free_ratings To Free_User@'%';
