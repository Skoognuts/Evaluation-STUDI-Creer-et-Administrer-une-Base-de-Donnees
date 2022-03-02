-- SELECT REQUEST TO GET THE USERS DETAILS --

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
  END AS Student
FROM users
	INNER JOIN roles
    ON users.role = roles.role_id
ORDER BY 
	CASE
    WHEN roles.name = 'ADMINISTRATOR' THEN 1
      WHEN roles.name = 'MANAGER' THEN 2
      WHEN roles.name = 'SELLER' THEN 3
      WHEN roles.name = 'CUSTOMER' THEN 4
    END ASC,
  LastName
;

-- DISPLAYS (by Role, then by Last Name):

-- User Role,
-- User Last Name,
-- User First Name,
-- User Age,
-- User Email Address,
-- Whether User is Student or not.