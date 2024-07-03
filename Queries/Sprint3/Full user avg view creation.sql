-- craete view to see avg park ratings
CREATE VIEW Average_Park_Ratings_View AS
SELECT 
    P.park_id,
    P.Park_name,
    AVG(R.rating_value) AS average_rating
FROM 
    Parks P
JOIN 
    national_park_ratings R ON P.park_id = R.park_id
GROUP BY 
    P.park_id, P.Park_name;

--create user to view average view
CREATE USER 'Full_User'@'%' IDENTIFIED BY 'password';


-- grant full user access to view avg park ratings
GRANT SELECT ON Average_Park_Ratings_View To Full_User@'%';
