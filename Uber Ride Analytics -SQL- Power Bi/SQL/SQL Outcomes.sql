create database uber;
use uber;

create table bookings(
Date_ date,
Time_ time,
Booking_ID varchar(100),
Booking_Status varchar(100),
Customer_ID varchar(100),
Vehicle_Type varchar(100),
Pickup_Location varchar(100),
Drop_Location varchar(100),
V_TAT varchar(100),
C_TAT varchar(100),
Canceled_Rides_by_Customer varchar(100),
Canceled_Rides_by_Driver varchar(100),
Incomplete_Rides  varchar(100),
Incomplete_Rides_Reason varchar(100),
Booking_Value int,
Payment_Method varchar(100),
Ride_Distance int,
Driver_Ratings varchar(100),
Customer_Rating varchar(100)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/booking123.csv'
INTO TABLE bookings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
Date_,
Time_,
Booking_ID,
Booking_Status,
Customer_ID,
Vehicle_Type,
Pickup_Location,
Drop_Location,
V_TAT,
C_TAT,
Canceled_Rides_by_Customer,
Canceled_Rides_by_Driver,
Incomplete_Rides,
Incomplete_Rides_Reason,
Booking_Value,
Payment_Method,
Ride_Distance,
Driver_Ratings,
Customer_Rating
);

select * from bookings;

-- 1. Retrieve all successful bookings:
create view successful_bookings as
select * from bookings where Booking_Status = "Success";

select * from successful_bookings;

-- 2. Find the average ride distance for each vehicle type:
create view avg_ride_distance as
select Vehicle_Type,avg(Ride_Distance) as avg_distace
from bookings
group by Vehicle_Type;

select * from avg_ride_distance;

-- 3. Get the total number of cancelled rides by customers:
create view cancelled_rides as
select count(*) from bookings where Booking_Status = 'Canceled by Customer';

 select * from cancelled_rides;
 
-- 4. List the top 5 customers who booked the highest number of rides:
create view top_5 as
select Customer_ID,count(Booking_ID) as Number_of_rides
from bookings
group by Customer_ID
order by Number_of_rides desc 
limit 5;

select * from top_5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
create view CBD_DTPR as
select count(*) from bookings 
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

select * from CBD_DTPR;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
create view driver_rating as
select Vehicle_Type,max(Driver_Ratings) as max_rating,min(Driver_Ratings) as min_rating
from bookings where Vehicle_Type = "Prime Sedan";

select * from driver_rating;

-- 7. Retrieve all rides where payment was made using UPI:
create view payment_upi as 
select * from bookings where Payment_Method = 'UPI';

select * from payment_upi;

-- 8. Find the average customer rating per vehicle type:
create view avg_customer_rating_per_vehicle as
select Vehicle_Type,avg(Customer_Rating) as avg_customer_rating
from bookings
group by Vehicle_Type;

select * from avg_customer_rating_per_vehicle;

-- 9. Calculate the total booking value of rides completed successfully:
create view successfull_booking_value as
select sum(Booking_Value) as Successful_Booking_Value from bookings where Booking_Status ='Success';

select * from successfull_booking_value;

-- 10. List all incomplete rides along with the reason
create view incomplete_rides as
select Booking_ID,Incomplete_Rides_Reason from bookings where Incomplete_Rides= 'yes';

select * from incomplete_rides;


