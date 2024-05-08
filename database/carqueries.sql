-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jav 23, 2024 at 08:41 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";




CREATE TABLE `admin` (
  `ADMIN_ID` varchar(255) NOT NULL,
  `ADMIN_PASSWORD` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `admin` (`ADMIN_ID`, `ADMIN_PASSWORD`) VALUES
('ADMIN', 'ADMIN');



CREATE TABLE `booking` (
  `BOOK_ID` int(11) NOT NULL,
  `CAR_ID` int(11) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `BOOK_PLACE` varchar(255) NOT NULL,
  `BOOK_DATE` date NOT NULL,
  `DURATION` int(11) NOT NULL,
  `PHONE_NUMBER` bigint(20) NOT NULL,
  `DESTINATION` varchar(255) NOT NULL,
  `RETURN_DATE` date NOT NULL,
  `PRICE` int(11) NOT NULL,
  `BOOK_STATUS` varchar(255) NOT NULL DEFAULT 'UNDER PROCESSING'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `booking` (`BOOK_ID`, `CAR_ID`, `EMAIL`, `BOOK_PLACE`, `BOOK_DATE`, `DURATION`, `PHONE_NUMBER`, `DESTINATION`, `RETURN_DATE`, `PRICE`, `BOOK_STATUS`) VALUES
(66, 2, 'aditya@gmail.com', 'Bangalore', '2024-03-22', 5, 9090909090, 'Chennai', '2024-04-09', 35000, 'UNDER PROCESSING'),
(68, 1, 'ambit@gmail.com', 'Bangalore', '2024-03-22', 4, 8080808080, 'Udupi', '2024-04-02', 50000, 'RETURNED'),
(69, 1, 'kaguya@gmail.com', 'Tokyo', '2024-03-24', 6, 7080708070, 'Osaka', '2024-03-31', 50000, 'RETURNED');



CREATE TABLE `cars` (
  `CAR_ID` int(11) NOT NULL,
  `CAR_NAME` varchar(255) NOT NULL,
  `FUEL_TYPE` varchar(255) NOT NULL,
  `CAPACITY` int(11) NOT NULL,
  `PRICE` int(11) NOT NULL,
  `CAR_IMG` varchar(255) NOT NULL,
  `AVAILABLE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `cars` (`CAR_ID`, `CAR_NAME`, `FUEL_TYPE`, `CAPACITY`, `PRICE`, `CAR_IMG`, `AVAILABLE`) VALUES
(1, 'FERRAI', 'PETROL', 5, 5000, 'ferrari.jpg', 'Y'),
(2, 'LAMBORGINI', 'DIESEL', 6, 7000, 'lamborghini.webp', 'Y'),
(3, 'PORSCHE', 'GAS', 4, 3000, 'porsche.jpg', 'Y'),
(20, 'SWIFT', 'DIESEL', 22, 1000, 'IMG-6239c94ea8a4a0.51789849.jpg', 'Y');



CREATE TABLE `feedback` (
  `FED_ID` int(11) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `COMMENT` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `feedback` (`FED_ID`, `EMAIL`, `COMMENT`) VALUES
(10, 'aditya@gmail.com', 'Hi, I am satisfied with your service. But need to know whether is there any other options\r\n');



CREATE TABLE `payment` (
  `PAY_ID` int(11) NOT NULL,
  `BOOK_ID` int(11) NOT NULL,
  `CARD_NO` varchar(255) NOT NULL,
  `EXP_DATE` varchar(255) NOT NULL,
  `CVV` int(11) NOT NULL,
  `PRICE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `payment` (`PAY_ID`, `BOOK_ID`, `CARD_NO`, `EXP_DATE`, `CVV`, `PRICE`) VALUES
(24, 68, '1122334455667788', '11/24', 333, 50000);



CREATE TABLE `users` (
  `FNAME` varchar(255) NOT NULL,
  `LNAME` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `LIC_NUM` varchar(255) NOT NULL,
  `PHONE_NUMBER` bigint(11) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `GENDER` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `users` (`FNAME`, `LNAME`, `EMAIL`, `LIC_NUM`, `PHONE_NUMBER`, `PASSWORD`, `GENDER`) VALUES
('Aditya', 'Suresh', 'aditya@gmail.com', 'DL2345', 9090909090, 'rrrr5555R', 'Male'),
('Ambit', 'PM', 'ambit@gmail.com', 'DL4567', 8080808080, 'rrrr5555R', 'Male'),
('Kaguya', 'Shinomiya', 'kaguya@gmail.com', 'DL8875', 7080708070, 'rrrr5555R', 'Female');




ALTER TABLE `admin`
  ADD PRIMARY KEY (`ADMIN_ID`);


ALTER TABLE `booking`
  ADD PRIMARY KEY (`BOOK_ID`),
  ADD KEY `CAR_ID` (`CAR_ID`),
  ADD KEY `EMAIL` (`EMAIL`);


ALTER TABLE `cars`
  ADD PRIMARY KEY (`CAR_ID`);


ALTER TABLE `feedback`
  ADD PRIMARY KEY (`FED_ID`),
  ADD KEY `TEST` (`EMAIL`);


ALTER TABLE `payment`
  ADD PRIMARY KEY (`PAY_ID`),
  ADD UNIQUE KEY `BOOK_ID` (`BOOK_ID`);


ALTER TABLE `users`
  ADD PRIMARY KEY (`EMAIL`);


ALTER TABLE `booking`
  MODIFY `BOOK_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;


ALTER TABLE `cars`
  MODIFY `CAR_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;


ALTER TABLE `feedback`
  MODIFY `FED_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;


ALTER TABLE `payment`
  MODIFY `PAY_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;


ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`CAR_ID`) REFERENCES `cars` (`CAR_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`EMAIL`) REFERENCES `users` (`EMAIL`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `feedback`
  ADD CONSTRAINT `TEST` FOREIGN KEY (`EMAIL`) REFERENCES `users` (`EMAIL`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`BOOK_ID`) REFERENCES `booking` (`BOOK_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;






--QUERIES

--1)Retrieve all bookings made by users with a Gmail email address, including the user's full name and phone number, and the booking details.

-- SELECT users.FNAME, users.LNAME, users.PHONE_NUMBER, BOOKING.*
-- FROM users JOIN booking ON users.EMAIL = booking.EMAIL
-- WHERE users.EMAIL LIKE '%@email.com';
-- NOT EXECUTED


--2)Find all cars that are currently available with a capacity of more than 3 passengers, sorted by price in ascending order.

SELECT *
FROM cars
WHERE AVAILABLE = 'Y' AND CAPACITY > 3
ORDER BY PRICE;
--EXECUTED

--3)Identify all users who have made more than three bookings in the past month, including their total spending on these bookings.

SELECT users.EMAIL, users.FNAME, users.LNAME, SUM(BOOKING.PRICE) AS TOTAL_SPENDING
FROM users JOIN BOOKING ON users.EMAIL = BOOKING.EMAIL
WHERE BOOKING.BOOK_DATE BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
GROUP BY users.EMAIL
HAVING COUNT(BOOKING.BOOK_ID) > 1;
--EXECUTED

--4)List all feedback comments left by users who booked a specific car (identified by CAR_ID), along with the user's first name and last initial.

SELECT users.FNAME, CONCAT(users.LNAME, '.') AS LAST_INITIAL, FEEDBACK.COMMENT
FROM users JOIN FEEDBACK ON users.EMAIL = FEEDBACK.EMAIL
WHERE FEEDBACK.EMAIL IN (
  SELECT BOOKING.EMAIL
  FROM BOOKING
  WHERE BOOKING.CAR_ID = '28' -- replace with the desired CAR_ID
);
--EXECUTED

--5)Retrieve payment information (excluding sensitive data like CARD_NO and CVV) for all bookings made to a particular destination in the last week.

SELECT PAYMENT.PAY_ID, PAYMENT.EXP_DATE, PAYMENT.PRICE, BOOKING.DESTINATION
FROM PAYMENT JOIN BOOKING ON PAYMENT.BOOK_ID = BOOKING.BOOK_ID
WHERE BOOKING.DESTINATION = 'Pondicherry' -- replace with the desired destination
AND BOOKING.BOOK_DATE BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 WEEK) AND CURDATE();
--EXECUTED

--6)Retrieve all bookings with their respective user details where the destination is "Vice Beach".
SELECT b.CAR_ID,b.BOOK_PLACE, b.DESTINATION, b.DURATION, u.FNAME, u.LNAME, u.PHONE_NUMBER, u.EMAIL, u.GENDER
FROM BOOKING b
JOIN USERS u ON b.EMAIL = u.EMAIL
WHERE b.DESTINATION = 'Vice Beach';
--EXECUTED


--7)List all users who have made a booking in the last 30 days.
-- SELECT DISTINCT u.*
-- FROM USER u
-- JOIN BOOKING b ON u.EMAIL = b.EMAIL
-- WHERE b.BOOK_DATE >= CURRENT_DATE - INTERVAL '30 days';
--NOT EXECUTED


--8)Identify payment made by users made with credit cards expiring in 2028.
SELECT U.FNAME, U.PHONE_NUMBER, U.EMAIL, P.EXP_DATE
FROM PAYMENT P, Users U, booking B
WHERE P.EXP_DATE LIKE '%/28' AND P.BOOK_ID=B.BOOK_ID AND B.EMAIL=U.EMAIL;
--EXECUTED

--9)Get feedback comments for all bookings made by a specific user, identified by email.
SELECT u.FNAME, u.EMAIL, f.COMMENT
FROM FEEDBACK f, USERS u
WHERE f.EMAIL = u.EMAIL AND f.EMAIL = 'aditya@email.com'
--EXECUTED

--10)Find total payment received from bookings where the booking place is "New York".
SELECT SUM(p.PRICE) AS TOTAL_PAYMENT
FROM PAYMENT p
JOIN BOOKING b ON p.BOOK_ID = b.BOOK_ID
WHERE b.BOOK_PLACE = 'Bangalore';
--EXECUTED

--11)List all cars along with their total number of bookings.
SELECT c.CAR_NAME, c.PRICE, c.AVAILABLE, COUNT(b.BOOK_ID) AS TOTAL_BOOKINGS
FROM CARS c
LEFT JOIN BOOKING b ON c.CAR_ID = b.CAR_ID
GROUP BY c.CAR_ID;
--EXECUTED

--12)Identify users who have not provided feedback for their bookings.
-- SELECT u.FNAME, u.LNAME, u.EMAIL
-- FROM USERS u
-- WHERE u.EMAIL NOT IN (SELECT EMAIL FROM FEEDBACK);
-- --NOT EXECUTED

--13)Get details of all users who booked a specific car, identified by car name.
SELECT u.FNAME, u.LNAME, u.EMAIL, c.CAR_NAME
FROM USERS u
JOIN BOOKING b ON u.EMAIL = b.EMAIL
JOIN CARS c ON b.CAR_ID = c.CAR_ID
WHERE c.CAR_NAME = 'TESLA CYBERTRUCK';
--EXECUTED

--14) Create a view of customers who have rented more than one car and retrieve the data of those customers
create view rentedcarcount as
select email, count(email) as count 
from booking
group by email
order by count(email)>1;

select *
from rentedcarcount
where email in ( select email
                  from rentedcarcount
                  where count > 1);
--EXECUTED                

--15) Create a trigger that automatically inserts a feedback record with a default comment 'No feedback given' for every booking that is completed.
-- CREATE TRIGGER feedback_trigger
-- AFTER UPDATE ON BOOKING
-- FOR EACH ROW
-- WHEN OLD.RETURN_DATE IS NULL AND NEW.RETURN_DATE IS NOT NULL
-- BEGIN
--   INSERT INTO FEEDBACK (FED_ID, COMMENT, EMAIL)
--   VALUES (SEQ_FED_ID.NEXTVAL, 'No feedback given', NEW.EMAIL);
-- END;
--NOT EXEXUTED

--16) Retrieve the total amount paid by all users for all bookings.

SELECT SUM(P.PRICE) AS TOTAL_AMOUNT
FROM PAYMENT P;
--EXECUTED
