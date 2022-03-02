-- SELECT REQUEST TO GET THE BOOKINGS DETAILS --

SELECT
	CONCAT(Client.lastName, ' ', Client.firstName) AS Client,
  (2022 - Client.birth_year) AS Age,
  CASE
    WHEN Client.is_student = 0 THEN 'No'
    WHEN Client.is_student = 1 THEN 'Yes'
    ELSE 'N/D'
  END AS Student,
  DATE_FORMAT(screenings.date, '%d/%m/%Y') AS Date,
  screenings.time AS Time,
  theaters.name AS Theater,
  theaters.city AS City,
  screeningrooms.name AS Room,
  movies.name AS Movie,
  CONCAT(movies.duration, 'min') AS Duration,
  paymentmodes.name AS PaymentMode,
  CONCAT(REPLACE(prices.price, '.', '€'), ' : ', prices.name) AS Price,
  CONCAT(Vendor.lastName, ' ', Vendor.firstName) AS Vendor
FROM bookings
	INNER JOIN users AS Client
    ON Client.user_id = bookings.client_id
  INNER JOIN users AS Vendor
    ON Vendor.user_id = bookings.vendor_id
  INNER JOIN screenings
    ON screenings.screening_id = bookings.screening
  INNER JOIN screeningrooms
    ON screenings.screening_room = screeningrooms.room_id
  INNER JOIN theaters
    ON theaters.theater_id = screeningrooms.theater
  INNER JOIN movies
    ON movies.movie_id = screenings.movie
  INNER JOIN paymentmodes
    ON paymentmodes.mode_id = bookings.payment_mode
  INNER JOIN prices
    ON prices.price_id = bookings.price
ORDER BY
	Date, Time
;

-- DISPLAYS (by Date, then by Time):

-- Client Full Name,
-- Client Age,
-- Whether Client is Student or not,
-- Booked Screening Date,
-- Booked Screening Time,
-- Theater Name,
-- Theater Location,
-- Theater's Screening Room Name,
-- Movie Name,
-- Movie Duration in minutes,
-- Payment Mode,
-- Price with possible Discount Name,
-- Seller Full Name.