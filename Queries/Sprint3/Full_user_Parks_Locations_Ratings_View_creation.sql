CREATE VIEW Parks_Locations_Ratings_View AS
SELECT 
    P.park_id,
    P.Park_name,
    P.Year_established,
    L.Coordinates,
    L.Province,
    L.Address,
    R.rating_id,
    R.rating_value,
    R.date_visited,
    R.date_posted,
    R.comment,
    U.User_id,
    U.Name AS User_name,
    U.Email AS User_email
FROM 
    Parks P
JOIN 
    Location L ON P.Location LIKE CONCAT(L.Coordinates, '%')
LEFT JOIN 
    national_park_ratings R ON P.park_id =R.park_id
LEFT JOIN 
    Users U ON R.user_id = U.User_id; 

-- Grant access to the view
GRANT SELECT ON Parks_Locations_Ratings_View TO Full_User@'%';

-- Grant access to perform transactions
GRANT INSERT, UPDATE, DELETE ON Location TO Full_User@'%';
GRANT INSERT, UPDATE, DELETE ON Parks TO Full_User@'%';
GRANT INSERT, UPDATE, DELETE ON national_park_ratings TO Full_User@'%';

