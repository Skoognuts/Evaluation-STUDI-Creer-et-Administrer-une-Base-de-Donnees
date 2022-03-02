-- SELECT REQUEST TO GET THE CLIENTS DETAILS --

SELECT DISTINCT
	roles.name AS Role,
  users.lastName AS LastName,
	users.firstName AS FirstName,
  (2022 - users.birth_year) AS Age,
  users.email AS Email,
  CASE
    WHEN users.is_student = 0 THEN 'No'
    WHEN users.is_student = 1 THEN 'Yes'
    ELSE 'N/D'
  END AS Student,
  CASE
    WHEN prices.name = 'FULL PRICE' THEN 'No'
    ELSE prices.name
  END AS Discount,
  (SELECT 
    COUNT(bookings.booking_id) 
    FROM bookings
    WHERE bookings.client_id = users.user_id
  ) AS Bookings
FROM users
	INNER JOIN roles
    ON users.role = roles.role_id
  INNER JOIN bookings
    ON bookings.client_id = users.user_id
  INNER JOIN prices
    ON prices.price_id = bookings.price
WHERE
	roles.name = 'CUSTOMER'
ORDER BY LastName
;

-- DISPLAYS (by Client Last Name):

-- Client Role (CUSTOMER),
-- Client Last Name,
-- Client First Name,
-- Client Age,
-- Client Email Address,
-- Whether Client is Student or not,
-- Whether Client is eligible for Discount, will display Discount Name if necessary,
-- Client Total Bookings Count.
