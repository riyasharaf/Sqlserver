CREATE DATABASE HOTELMANAGEMENT
USE HOTELMANAGEMENT

CREATE TABLE hotel
( hotel_no CHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);


CREATE TABLE room
( room_no VARCHAR(4) NOT NULL,
hotel_no CHAR(4) NOT NULL,
type CHAR(1) NOT NULL,
price DECIMAL(5,2) NOT NULL);

CREATE TABLE booking
(hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no CHAR(4) NOT NULL);

CREATE TABLE guest
( guest_no CHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);

INSERT INTO hotel
VALUES ('H111', 'Grosvenor Hotel', 'London');

INSERT INTO room
VALUES ('1', 'H111', 'S', 72.00);
INSERT INTO guest
VALUES ('G111', 'John Smith', 'London');
INSERT INTO booking
VALUES ('H111', 'G111', '1999-01-01',
'1999-01-02', '1');

SELECT * FROM HOTEL
UPDATE room SET price = price*1.05;

CREATE TABLE Auditbooking
(hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no CHAR(4) NOT NULL);


insert into Auditbooking
SELECT * FROM booking
WHERE date_to < '2000-01-01'

DELETE FROM booking
WHERE date_to < '2000-01-01';

INSERT INTO hotel VALUES ('H112', 'The Ritz', 'Paris');
INSERT INTO hotel VALUES ('H113', 'Plaza Hotel', 'New York');
INSERT INTO hotel VALUES ('H114', 'Marina Bay Sands', 'Singapore');
INSERT INTO hotel VALUES ('H115', 'Burj Al Arab', 'Dubai');


INSERT INTO room VALUES ('1', 'H112', 'D', 150.00);
INSERT INTO room VALUES ('2', 'H112', 'S', 90.00);
INSERT INTO room VALUES ('1', 'H113', 'S', 120.00);
INSERT INTO room VALUES ('2', 'H113', 'D', 200.00);
INSERT INTO room VALUES ('1', 'H114', 'S', 180.00);
INSERT INTO room VALUES ('2', 'H114', 'D', 250.00);
INSERT INTO room VALUES ('1', 'H115', 'S', 300.00);
INSERT INTO room VALUES ('2', 'H115', 'D', 500.00);


INSERT INTO guest VALUES ('G112', 'Emma Johnson', 'Paris');
INSERT INTO guest VALUES ('G113', 'David Williams', 'New York');
INSERT INTO guest VALUES ('G114', 'Sophia Brown', 'Singapore');
INSERT INTO guest VALUES ('G115', 'Michael Lee', 'Dubai');
INSERT INTO guest VALUES ('G116', 'Olivia Garcia', 'London');
INSERT INTO guest VALUES ('G117', 'James Anderson', 'Toronto');

INSERT INTO booking VALUES ('H112', 'G112',  '2023-05-10',  '2023-05-15', '1');
INSERT INTO booking VALUES ('H112', 'G113',  '2023-06-01',  '2023-06-05', '2');
INSERT INTO booking VALUES ('H113', 'G114',  '2023-07-20',  '2023-07-22', '1');
INSERT INTO booking VALUES ('H114', 'G115',  '2023-08-15', '2023-08-20', '2');
INSERT INTO booking VALUES ('H115', 'G116',  '2023-09-10',  '2023-09-12', '1');
INSERT INTO booking VALUES ('H115', 'G117',  '2023-10-05',  '2023-10-10', '2');




--1
select * from hotel

--2
select * from hotel where address = 'london'

--3 List the names and addresses of all guests in London, alphabetically ordered by name.

select * from hotel
select * from guest

Select name, address from guest
where address = 'London'
order by name

--4  List all double or family rooms with a price below £40.00 per night, in ascending order of price.

select * from hotel
select * from room
select * from guest
select  *  from booking



Select * from room 
where type = 'D' and PRICE < 40.0
order by price asc

update room set price = 34 where hotel_no = 'H111' 

---5 List the bookings for which no date_to has been specified.

select * from booking
where date_to is null


------AGGREGATE FUNCTIONS

---1   How many hotels are there?

SELECT * FROM HOTEL
SELECT COUNT(DISTINCT(NAME)) AS TOTAL_HOTELS FROM HOTEL

---2  What is the average price of a room?

SELECT * FROM ROOM

SELECT AVG(PRICE) AS AVG_PRICE FROM ROOM 

---3  What is the total revenue per night from all double rooms?

SELECT SUM(PRICE) AS TOTAL_REVENUE
 FROM ROOM WHERE TYPE = 'D'

 --4 How many different guests have made bookings for August?
 SELECT * FROM BOOKING

 SELECT COUNT(DISTINCT guest_no) as guest_no
FROM booking
WHERE MONTH(date_from) = 8 

----------SUBQUERYY

--1 List the price and type of all rooms at the Grosvenor Hotel.

SELECT * FROM ROOM
SELECT * FROM HOTEL

SELECT PRICE , TYPE FROM ROOM 
WHERE HOTEL_NO = (SELECT HOTEL_NO FROM HOTEL WHERE NAME = 'Grosvenor Hotel' )


--2 List all guests currently staying at the Grosvenor Hotel.

SELECT * FROM GUEST
SELECT * FROM HOTEL

SELECT A.NAME   
FROM GUEST A 
JOIN HOTEL B ON A.ADDRESS = B.ADDRESS
WHERE B.NAME = 'Grosvenor Hotel';

--3 List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if
--the room is occupied.

select * from room
select * from hotel
select * from guest
select * from booking

select r.hotel_no , r.type , r.price , g.name from room r 
join hotel h on r.hotel_no = h.hotel_no join guest g  join booking b on b.guest_no = g.guest_no
on h.address = g.address where h.name = 'Grosvenor Hotel'  AND b.date_from <= GETDATE() 
    AND  b.date_to >= GETDATE()

--4 What is the total income from bookings for the Grosvenor Hotel today?

select * from hotel
select * from booking
select * from room

SELECT SUM(r.price) AS total_income
FROM booking b
JOIN room r ON b.hotel_No = r.hotel_No AND b.room_No = r.room_No
JOIN hotel h ON b.hotel_No = h.hotel_No
WHERE h.name = 'Grosvenor Hotel'
  AND '2025-03-17' BETWEEN b.date_From AND b.date_To;


--5 List the rooms that are currently unoccupied at the Grosvenor Hotel.

select * from room
select * from hotel

SELECT r.room_no 
FROM room r 
LEFT JOIN booking b 
ON r.room_no = b.room_no AND r.hotel_no = b.hotel_no
WHERE r.hotel_no = 'H111'
AND b.room_no IS NULL;

----6  What is the lost income from unoccupied rooms at the Grosvenor Hotel?

SELECT SUM(r.price) AS lost_income
FROM room r
WHERE r.hotel_no = (SELECT hotel_no FROM hotel WHERE name = 'Grosvenor Hotel')
AND r.room_no NOT IN (
    SELECT b.room_no
    FROM booking b
    WHERE b.hotel_no = r.hotel_no
    AND GETDATE() BETWEEN b.date_from AND ISNULL(b.date_to, GETDATE())
);


-----------------GROUPING QUERIES
---1. List the number of rooms in each hotel.
SELECT * FROM HOTEL
SELECT * FROM ROOM

SELECT COUNT(DISTINCT(r.ROOM_NO)) as total_rooms , H.name FROM HOTEL H  JOIN ROOM R ON H.HOTEL_NO = R.HOTEL_NO
GROUP BY H.NAME 
---2. List the number of rooms in each hotel in London.

Select COUNT(distinct(room_no)) as no_of_rooms from room r join hotel h
on  H.HOTEL_NO = R.HOTEL_NO 
where h.address =  'London
'
---3. What is the average number of bookings for each hotel in August?

select * from room
select * from hotel
select * from booking

SELECT h.hotel_no, h.name AS hotel_name, COUNT(b.guest_no) AS avg_bookings
FROM hotel h
LEFT JOIN booking b ON h.hotel_no = b.hotel_no
WHERE MONTH(b.date_from) = 8
GROUP BY  h.hotel_no,h.name;





--4. What is the most commonly booked room type for each hotel in London?
select max(room.type) AS MAX_ROOMS from room 
join hotel on room.hotel_no = hotel.hotel_no
group by hotel.address having hotel.address = 'LONDON';


--5. What is the lost income from unoccupied rooms at each hotel today?
select sum(room.price) as lostincome from room
join hotel on room.hotel_no = hotel.hotel_no 
left join booking on room.hotel_no = booking.hotel_no and room.hotel_no = booking.hotel_no
where '2025-03-16' between booking.date_from and booking.date_to 
and booking.room_no is null
group by hotel.hotel_no;
















