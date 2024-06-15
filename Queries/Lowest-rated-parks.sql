SELECT Park_name, AVG(rating_value) AS average_rating
FROM national_park_ratings r
JOIN Parks p ON r.park_id = p.park_id
GROUP BY Park_name
HAVING AVG(r.rating_value) = (
        SELECT MIN(avg_rating)
        FROM (
            SELECT AVG(rating_value) AS avg_rating
            FROM national_park_ratings
            GROUP BY park_id
        ) AS subquery
    );
