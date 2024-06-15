SELECT Park_name, AVG(rating_value) AS average_rating
FROM national_park_ratings
JOIN Parks ON national_park_ratings.park_id = Parks.park_id
GROUP BY Park_name
HAVING AVG(rating_value) > 3;
