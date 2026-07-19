DROP DATABASE IF EXISTS EventManagementSystem;

CREATE DATABASE EventManagementSystem;
USE EventManagementSystem; 
--------------


CREATE TABLE Client (
	ClientID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ClientType VARCHAR(20) NOT NULL,
	ClientName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
	State VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	Street VARCHAR(50) NOT NULL,
	StreetNo INT NOT NULL,
	RepName VARCHAR(50) NOT NULL,
	RepPhone VARCHAR(20) NOT NULL
);

CREATE TABLE Accommodation (
	AccommodationID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	AccommodationType VARCHAR(20) NOT NULL,
	AccommodationName VARCHAR(50) NOT NULL,
	State VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	Street VARCHAR(50) NOT NULL,
	StreetNo INT NOT NULL,
    Latitude VARCHAR(20) NOT NULL,
    Longitude VARCHAR(20) NOT NULL
);

CREATE TABLE Room (
    RoomID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    AccommodationID INT NOT NULL,
    RoomNo INT NOT NULL,
    RoomType VARCHAR(20) NOT NULL,
    Capacity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StaffID INT NOT NULL,
    FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

CREATE TABLE BookingAccommodation (
	BookingAccommodationID INT PRIMARY KEY NOT NULL,
    BookingID INT NOT NULL,
    AccommodationID INT NOT NULL,
	RoomID INT NOT NULL,
	RoomNo INT NOT NULL,
	Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

CREATE TABLE Facilities (
	FacilityID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	FacilityType VARCHAR(50) NOT NULL,
	FacilityName VARCHAR(50) NOT NULL,
	HireCharge DECIMAL(10,2) NOT NULL,
    StaffID INT NOT NULL
);

CREATE TABLE BookingFacility (
	BookingFacilityID INT PRIMARY KEY NOT NULL,
    BookingID INT NOT NULL,
	FacilityID INT NOT NULL,
	HireCharge DECIMAL(10,2) NOT NULL,
	DateBooked DATE NOT NULL,
	FOREIGN KEY (FacilityID) REFERENCES Facilities(FacilityID)
);

CREATE TABLE Staff (
	StaffID INT PRIMARY KEY NOT NULL,
    Department VARCHAR(30) NOT NULL,
    StaffName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    IsFullTime BOOLEAN NOT NULL,
    MonthlySalary DECIMAL(10,2) NOT NULL
);

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ClientID INT NOT NULL,
    DateOfBooking DATE NOT NULL,
    StayStartDate DATE NOT NULL,
    StayEndDate DATE NOT NULL,
	NumberOfPeople INT NOT NULL,
    UseRestaurant BOOLEAN NOT NULL,
	BookingAccommodationID INT,
    BookingFacilityID INT,
    BookingBaseFare DECIMAL(10,2),
    PaymentID INT NOT NULL,
    StaffID INT NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
	CONSTRAINT Book_BookAcc_ID FOREIGN KEY (BookingAccommodationID) REFERENCES BookingAccommodation(BookingAccommodationID),
	CONSTRAINT Book_BookFac_ID FOREIGN KEY (BookingFacilityID) REFERENCES BookingFacility(BookingFacilityID),
	FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Payment (
	PaymentID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    BookingID INT NOT NULL,
    ClientID INT NOT NULL,
    TotalTransaction DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

--------------
ALTER TABLE Booking
ADD CONSTRAINT Book_Pay_ID FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID);
ALTER TABLE BookingAccommodation
ADD FOREIGN KEY (BookingID) REFERENCES Booking(BookingID);
ALTER TABLE BookingFacility
ADD FOREIGN KEY (BookingID) REFERENCES Booking(BookingID);
ALTER TABLE Room
ADD FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);
ALTER TABLE Facilities
ADD FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);
--------------


----------------------
----------------------


INSERT INTO Client VALUES
(1, 'Business', 'McCoy Logging Co', 'mccoylogging@gmail.com', 'Selangor', 'Petaling Jaya', 'Jalan SS 2/5', 123, 'John Smith', '021-932-1922'),
(2, 'Business', 'Spiffo\'s Burger', 'spiffosburger@gmail.com', 'Penang', 'Georgetown', 'Lebuh Chulia', 56, 'Taylor White', '014-123-1732'),
(3, 'Business', 'Black Gold Refinery', 'blackgoldrefinery@gmail.com', 'Johor', 'Johor Bahru', 'Jalan Ibrahim', 78, 'Justin Swift', '011-652-4620'),
(4, 'Business', 'Matt\'s Delicious Diner', 'mattsdeliciousdiner@gmail.com', 'Sarawak', 'Kuching', 'Jalan Padungan', 12, 'Kimi Anderson', '041-162-9852'),
(5, 'Business', 'Cool Design Architecture', 'cooldesignarchitecture@gmail.com', 'Perak', 'Ipoh', 'Jalan Sultan Iskandar', 1, 'Maria Davidson', '011-236-4721'),
(6, 'School', 'SmartyPants Academy', 'smartypantsacademy@gmail.com', 'Kelantan', 'Kota Bharu', 'Jalan Hamzah', 7, 'Larry Lee', '014-222-3333'),
(7, 'School', 'Rosewood Elementary', 'rosewoodelementary@gmail.com', 'Kedah', 'Alor Setar', 'Jalan Langgar', 3, 'Kate Brown', '016-778-9988'),
(8, 'School', 'Taylor\'s University', 'taylorsuniversity@gmail.com', 'Terengganu', 'Kuala Terengganu', 'Jalan Sultan Mahmud', 21, 'Henry Black', '062-813-5700'),
(9, 'School', 'Nerd Academy', 'nerdacademy@gmail.com', 'Perlis', 'Kangar', 'Jalan Penjara', 34, 'Grace Jackson', '056-163-9712'),
(10, 'School', 'Le Musicalle Academy', 'lemusicalleacademy@gmail.com', 'Negeri sembilan', 'Seremban', 'Jalan Tuanku Munawir', 45, 'Nathan Turner', '017-099-9987'),
(11, 'Government', 'Malaysian Tourism Department', 'malaysiantourismdepartment@gmail.com', 'Melaka', 'Malacca City', 'Jalan Tun Tan Cheng Lock', 98, 'Olivia Ward', '012-992-7422'),
(12, 'Government', 'Rapid KL Transit', 'rapidkltransit@gmail.com', 'Pahang', 'Kuantan', 'Jalan Besar', 69, 'Peter Smithson', '012-090-0112'),
(13, 'Government', 'DPR Indonesia', 'dprindonesia@gmail.com', 'Putrajaya', 'Putrajaya', 'Persiaran Perdana', 12, 'Rachel Johnson', '015-696-2365'),
(14, 'Government', 'Kominfo', 'kominfo@gmail.com', 'DKI Jakarta', 'Jakarta Pusat', 'Jalan Thamrin', 32, 'Richie Steel', '011-772-8167'),
(15, 'Government', 'CIA', 'cia@gmail.com', 'Jawa Barat', 'Bandung', 'Jalan Asia Afrika', 11, 'Jack Peterson', '014-171-7522'),
(16, 'Family', 'Cox Family', 'irenecox@gmail.com', 'Jawa Timur', 'Surabaya', 'Jalan Gubeng', 17, 'Irene Cox', '019-839-1821'),
(17, 'Family', 'Hoffman Family', 'alicehoffman@gmail.com', 'Bali', 'Denpasar', 'Jalan Gatot Subroto', 45, 'Alice Hoffman', '016-192-9992'),
(18, 'Family', 'Smith Family', 'bobsmith@gmail.com', 'Banten', 'Tangerang', 'Jalan Sudirman', 76, 'Bob Smith', '019-182-7172'),
(19, 'Family', 'Hugh Family', 'zeehugh@gmail.com', 'Riau', 'Pekanbaru', 'Jalan Ahmad Yani', 29, 'Zee hugh', '033-887-7878'),
(20, 'Family', 'Paul Family', 'emmapaul@gmail.com', 'California', 'Los Angeles', 'Zimmerman Lane', 202, 'Emma Paul', '025-254-6987'),
(21, 'Business', 'Sunway Pyramid', 'sunwaypyramid@gmail.com', 'Mississippi', 'Jackson', 'Walnut Street', 2885, 'Liam Turnnip', '069-696-6969'),
(22, 'Business', 'Sunway GEO', 'sunwaygeo@gmail.com', 'Colorado', 'Denver', 'Sampson Street', 4396, 'Adam Carrot', '042-420-0420'),
(23, 'School', 'Sunway University', 'sunwayuniversity@gmail.com', 'Ohio', 'Dayton', 'Harter Street', 2691, 'Lisa Potato', '017-818-2345'),
(24, 'School', 'Monash University', 'monashuniversity@gmail.com', 'Pennsylvania', 'Pittsburgh', 'Platinum Drive', 4874, 'Cole Bennet', '206-342-8631'),
(25, 'Government', 'FBI', 'fbi@gmail.com', 'New Hampshire', 'Londonderry', 'Elliott Street', 4382, 'George Floyd', '717-550-1675'),
(26, 'Government', 'MoH', 'moh@gmail.com', 'Nebraska', 'Pickrell', 'Snowbird Lane', 4045, 'Dani German', '209-300-2557'),
(27, 'Family', 'Geolf Family', 'geolffamily@gmail.com', 'Alabama', 'Lexington', 'Ritter Street', 3747, 'Luffy Monkey', '234-109-6666'),
(28, 'Family', 'Polska Family', 'eulapolska@gmail.com', 'California', 'San Diego', 'Ashcraft Court', 3485, 'Eula Polska', '253-644-2182'),
(29, 'Family', 'Beautiful Fashion Design', 'beautifulfashiondesign@gmail.com', 'Texas', 'Sundown', 'Timber Oak Drive', 4104, 'Spongebob Squarepants', '212-658-3916'),
(30, 'Family', 'Pramuka', 'pramuka@gmail.com', 'Oklahoma', 'Guymon', 'Cody Ridge Road', 914, 'Bob Builder', '248-762-0356'),
(31, 'YouthGroup', 'Inspire Infinity', 'inspireinf@gmail.com', 'Selangor', 'Kuala Lumpur', 'Bukit Bintang', 1231, 'Bobby Two Shoes', '111-218-1092'),
(32, 'YouthGroup', 'Vision Venture', 'visventure@gmail.com', 'Johor', 'Johor Bahru', 'Jalan Nenas', 23, 'Lisa Two Shoes', '882-192-0012'),
(33, 'YouthGroup', 'Thrive Tribe', 'thrivetribe@gmail.com', 'Perak', 'Ipoh', 'Jalan Ipoh', 52, 'Jason Tucker', '283-001-2913'),
(34, 'YouthGroup', 'Brightside', 'brightside@gmail.com', 'Kelantan', 'Kota Bharu', 'Jalan Kelantan', 12, 'Hong Lee', '012-283-0012'),
(35, 'YouthGroup', 'Dream Quest', 'dreamquest@gmail.com', 'Kedah', 'Alor Setar', 'Jalan Kedah', 98, 'Walter White', '056-273-0129');

INSERT INTO Staff VALUES
(1, 'Sales', 'Olivia Turner', '034-252-3558', 'Jalan SS 2/5, Petaling Jaya', TRUE, 2100),
(2, 'Sales', 'Ethan Rodriguez', '035-265-5654', 'Jalan Damansara, Kuala Lumpur', FALSE, 1200),
(3, 'Sales', 'Ava Anderson', '088-985-6542', 'Persiaran Sukan, Shah Alam', TRUE, 2200),
(4, 'Sales', 'Mason Martinez', '045-215-4884', 'Jalan Klang Lama, Petaling Jaya', TRUE, 2100),
(5, 'Sales', 'Sophia Walker', '015-3211-2324', 'Jalan Merdeka, Klang', FALSE, 1100),
(6, 'Sales', 'Aiden Thompson', '011-231-8826', 'Jalan Puchong, Subang Jaya', TRUE, 2100),
(7, 'Sales', 'Harper Davis', '012-168-1548', 'Jalan Ampang, Ampang', FALSE, 1200),
(8, 'Sales', 'Lucas White', '024-516-1652', 'Lebuh Raya Elite, Cyberjaya', TRUE, 2200),
(9, 'Sales', 'Amelia Harris', '031-165-2654', 'Jalan Sentul, Sentul', TRUE, 2200),
(10, 'Sales', 'Liam Nelson', '021-148-4548', 'Persiaran Bunga Raya, Hulu Langat', TRUE, 2200),
(11, 'Accomodation', 'Isabella Clark', '013-248-1684', 'Jalan Kebun, Klang', FALSE, 1300),
(12, 'Accomodation', 'Elijah Baker', '032-165-8771', 'Jalan Kinrara, Puchong', TRUE, 2300),
(13, 'Accomodation', 'Mia Flores', '011-345-4684', 'Jalan Tengku Ampuan, Klang', TRUE, 2350),
(14, 'Accomodation', 'Jackson Hill', '061-154-2431', 'Jalan Raja Chulan, Kuala Lumpur', TRUE, 2200),
(15, 'Accomodation', 'Emma Carter', '081-154-1541', 'Jalan Duta, Kuala Lumpur', TRUE, 2100),
(16, 'Accomodation', 'Noah Mitchell', '770-519-3235', 'Persiaran Sultan Ibrahim, Shah Alam', TRUE, 2000),
(17, 'Accomodation', 'Erick Stewart', '012-321-1541', 'Jalan Sungai Besi, Seri Kembangan', FALSE, 1200),
(18, 'Accomodation', 'Zoe Reed', '530-558-6801', 'Jalan Kepong, Kepong', FALSE, 1100),
(19, 'Accomodation', 'Grace Perry', '015-151-3213', 'Persiaran Tasik, Cyberjaya', TRUE, 2200),
(20, 'Accomodation', 'Logan Simons', '804-009-4381', 'Jalan Subang, Subang Jaya', TRUE, 2300),
(21, 'Additional Facilities', 'Caleb Russel', '567-986-7648', 'Jalan Ampang Hilir, Kuala Lumpur', TRUE, 2300),
(22, 'Additional Facilities', 'Peter Parker', '819-455-3878', 'Jalan Genting Klang, Setapak', TRUE, 1900),
(23, 'Additional Facilities', 'William Chris', '610-809-8693', 'Jalan Miharja, Cheras', TRUE, 1900),
(24, 'Additional Facilities', 'Lily Jenkins', '914-986-0544', 'Jalan Banting, Banting', FALSE, 1000),
(25, 'Additional Facilities', 'Henry Coleman', '067-186-1613', 'Jalan Ulu Klang, Ampang', TRUE, 2100),
(26, 'Additional Facilities', 'Jack Blackman', '066-681-4568', 'Jalan Hulu Langat, Hulu Langat', TRUE, 2000),
(27, 'Additional Facilities', 'Pattrick Star', '065-641-5168', 'Persiaran Alam, Shah Alam', TRUE, 1900),
(28, 'Additional Facilities', 'Micky Cooper', '023-548-6545', 'Jalan Seri Putra, Bangi', FALSE, 900),
(29, 'Additional Facilities', 'Nick Hugh', '011-138-3165', 'Jalan Gombak, Gombak', FALSE, 900),
(30, 'Additional Facilities', 'Sean Mclaughlin', '015-543-4641', 'Jalan Kota, Kuala Selangor', FALSE, 800);

--------------
ALTER TABLE Booking
DROP CONSTRAINT Book_BookAcc_ID;
ALTER TABLE Booking
DROP CONSTRAINT Book_BookFac_ID;
ALTER TABLE Booking
DROP CONSTRAINT Book_Pay_ID;
--------------

INSERT INTO Booking VALUES
(1, 1, '2022-11-11', '2022-12-11', '2022-12-13', 2, TRUE, 1, 1, 400, 1, 1),
(2, 2, '2022-11-13', '2022-12-13', '2022-12-14', 12, TRUE, 2, 2, 400, 2, 1),
(3, 3, '2022-11-11', '2022-12-11', '2022-12-12', 12, TRUE, NULL, 3, 400, 3, 1),
(4, 4, '2022-11-6', '2022-12-6', '2022-12-8', 8, FALSE, NULL, 4, 400, 4, 1),
(5, 5, '2022-11-9', '2022-12-9', '2022-12-12', 1, TRUE, 3, NULL, 400, 5, 2),
(6, 6, '2022-11-15', '2022-12-15', '2022-12-16', 12, FALSE, 4, 5, 500, 6, 2),
(7, 7, '2022-11-11', '2022-12-11', '2022-12-13', 12, FALSE, 5, 6, 500, 7, 2),
(8, 8, '2022-11-19', '2022-12-19', '2022-12-26', 4, FALSE, 6, 7, 500, 8, 2),
(9, 9, '2022-11-20', '2022-12-20', '2022-12-24', 10, TRUE, NULL, NULL, 500, 9, 2),
(10, 10, '2022-11-15', '2022-12-15', '2022-12-20', 4, FALSE, 7, 8, 500, 10, 2),
(11, 11, '2022-11-9', '2022-12-9', '2022-12-12', 2, FALSE, 8, NULL, 600, 11, 2),
(12, 12, '2022-11-4', '2022-12-4', '2022-12-8', 2, FALSE, 9, NULL, 600, 12, 2),
(13, 13, '2022-11-6', '2022-12-6', '2022-12-10', 1, TRUE, NULL, 9, 600, 13, 3),
(14, 14, '2022-12-14', '2022-12-14', '2022-12-16', 2, FALSE, NULL, 10, 600, 14, 3),
(15, 15, '2022-11-25', '2022-12-25', '2023-1-1', 2, TRUE, 10, NULL, 600, 15, 3),
(16, 16, '2022-11-6', '2022-12-6', '2022-12-9', 10, FALSE, 11, 11, 600, 16, 3),
(17, 17, '2022-11-27', '2022-12-27', '2022-12-30', 3, TRUE, 12, 12, 600, 17, 3),
(18, 18, '2022-11-28', '2022-12-28', '2023-1-1', 6, FALSE, NULL, NULL, 600, 18, 4),
(19, 19, '2022-11-28', '2022-12-28', '2023-1-1', 2, FALSE, 13, 13, 600, 19, 4),
(20, 20, '2022-11-30', '2022-12-31', '2023-1-10', 2, FALSE, 14, 14, 600, 20, 5),
(21, 21, '2022-11-30', '2022-12-30', '2023-1-10', 14, TRUE, NULL, NULL, 700, 21, 5),
(22, 22, '2022-11-28', '2022-12-28', '2023-1-3', 15, FALSE, NULL, 15, 700, 22, 5),
(23, 22, '2022-12-2', '2023-1-2', '2023-1-10', 4, FALSE, 15, 16, 700, 23, 5),
(24, 22, '2022-11-30', '2022-12-31', '2023-1-10', 1, TRUE, 16, NULL, 700, 24, 5),
(25, 23, '2022-12-2', '2023-1-2', '2023-1-4', 4, FALSE, 17, 17, 700, 25, 5),
(26, 23, '2022-12-4', '2023-1-4', '2023-1-6', 18, FALSE, NULL, 18, 800, 26, 5),
(27, 24, '2022-12-5', '2023-1-5', '2023-1-10', 16, TRUE, NULL, 19, 800, 27, 5),
(28, 25, '2022-12-6', '2023-1-6', '2023-1-11', 12, TRUE, 18, 20, 800, 28, 5),
(29, 26, '2022-11-24', '2022-12-24', '2023-1-2', 12, FALSE, 19, NULL, 800, 29, 5),
(30, 27, '2022-12-6', '2023-1-6', '2023-1-11', 1, TRUE, 20, NULL, 800, 30, 6),
(31, 28, '2022-11-8', '2022-12-6', '2022-12-15', 10, FALSE, NULL, NULL, 900, 31, 6),
(32, 29, '2022-11-19', '2022-12-16', '2022-12-22', 12, TRUE, 21, 21, 900, 32, 7),
(33, 30, '2022-11-7', '2022-12-5', '2022-12-14', 16, FALSE, NULL, 22, 900, 33, 7),
(34, 31, '2022-11-16', '2022-12-17', '2022-12-22', 19, TRUE, 22, NULL, 900, 34, 7),
(35, 32, '2022-11-8', '2022-12-8', '2022-12-15', 12, TRUE, 23, NULL, 900, 35, 7),
(36, 33, '2022-11-14', '2022-12-15', '2022-12-18', 1, FALSE, 24, 23, 1000, 36, 8),
(37, 34, '2022-11-3', '2022-12-5', '2022-12-10', 15, TRUE, 25, 24, 1000, 37, 8),
(38, 34, '2022-11-9', '2022-12-10', '2022-12-12', 26, FALSE, NULL, 25, 1000, 38, 9),
(39, 35, '2023-11-11', '2023-12-12', '2023-12-15', 8, TRUE, 26, NULL, 1000, 39, 9),
(40, 35, '2023-11-25', '2023-12-15', '2023-12-22', 25, FALSE, 27, NULL, 1000, 40, 10);

INSERT INTO Accommodation VALUES
(1, 'Hotel', 'Snoopy Lupiz', 'Selangor', 'Puchong', 'Jalan Puteri 1/4', '32', 3.025325, 101.616248),
(2, 'Hostel', 'Star Hostel', 'Selangor', 'Petaling Jaya', 'Jalan USJ 10/1E', '18', 3.048982, 101.583542),
(3, 'Camping Ground', 'Mint Camping Grounds', 'Selangor', 'Shah Alam', 'Jalan Tengku Ampuan Zabedah E9', '22', 3.085313, 101.522720);

INSERT INTO Room VALUES
(1, 1, '1001', 'Single', 1, 400, 11),
(2, 1, '1002', 'Single', 1, 400, 11),
(3, 1, '1003', 'Single', 1, 400, 12),
(4, 1, '1004', 'Double', 2, 500, 12),
(5, 1, '1005', 'Double', 2, 500, 12),
(6, 1, '1006', 'Double', 2, 500, 13),
(7, 1, '1007', 'King Suite', 2, 1000, 13),
(8, 1, '1008', 'King Suite', 2, 1000, 14),
(9, 1, '1009', 'Luxury Suite', 4, 1200, 14),
(10, 1, '1010', 'Luxury Suite', 4, 1200, 14),
(11, 2, '100', 'Dormitory', 12, 3000, 15),
(12, 2, '101', 'Dormitory', 12, 3000, 15),
(13, 2, '102', 'Dormitory', 12, 3000, 15),
(14, 2, '103', 'Dormitory', 12, 3000, 16),
(15, 2, '104', 'Dormitory', 12, 3000, 16),
(16, 2, '105', 'Shared Room', 4, 800, 17),
(17, 2, '106', 'Shared Room', 4, 800, 17),
(18, 2, '107', 'Shared Room', 4, 800, 17),
(19, 3, '1', 'Lot', 30, 1800, 18),
(20, 3, '2', 'Lot', 30, 1800, 18),
(21, 3, '3', 'Lot', 30, 1800, 19),
(22, 3, '4', 'Lot', 30, 1800, 19),
(23, 3, '5', 'Lot', 30, 1800, 20),
(24, 3, '6', 'Lot', 30, 1800, 20);

INSERT INTO BookingAccommodation VALUES
(1, 1, 1, 1, '1001', 400),
(2, 2, 2, 11, '100', 3000),
(3, 5, 1, 2, '1002', 400),
(4, 6, 2, 14, '103', 3000),
(5, 7, 2, 13, '102', 3000),
(6, 8, 2, 16, '105', 800),
(7, 10, 2, 17, '106', 800),
(8, 11, 1, 5, '1005', 500),
(9, 12, 2, 18, '107', 800),
(10, 15, 1, 6, '1006', 500),
(11, 16, 2, 15, '104', 3000),
(12, 17, 1, 10, '1010', 1200),
(13, 19, 2, 4, '1004', 500),
(14, 20, 1, 7, '1007', 1000),
(15, 23, 1, 10, '1010', 3000),
(16, 24, 1, 1, '1001', 400),
(17, 25, 1, 9, '1009', 1200),
(18, 28, 2, 15, '104', 3000),
(19, 29, 2, 13, '102', 3000),
(20, 30, 1, 3, '1003', 400),
(21, 32, 2, 15, '104', 3000),
(22, 34, 3, 21, '3', 1200),
(23, 35, 2, 12, '101', 3000),
(24, 36, 3, 22, '4', 400),
(25, 37, 3, 20, '2', 1000),
(26, 39, 2, 13, '102', 3000),
(27, 40, 3, 19, '1', 500);

INSERT INTO Facilities VALUES
(1, 'Indoor Facility', 'board meeting room', 360, 21),
(2, 'Indoor Facility', 'conference halls', 1000, 22),
(3, 'Indoor Facility', 'computing labs', 1200, 23),
(4, 'Equipment', 'portable multi-media projection', 60, 24),
(5, 'Equipment', 'presentation equipment', 60, 24),
(6, 'Outdoor Facility', 'climbing-wall with safety equipment', 840, 25),
(7, 'Outdoor Facility', 'paintball-war games', 1600, 26),
(8, 'Outdoor Facility', 'canoes', 1600, 27),
(9, 'Outdoor Facility', 'swimming', 1700, 28),
(10, 'Outdoor Facility', 'basketball', 500, 29),
(11, 'Outdoor Facility', 'football', 500, 30);

INSERT INTO BookingFacility VALUES
(1, 1, 1, 360, '2022-12-11'),
(2, 2, 1, 360, '2022-12-14'),
(3, 3, 2, 1000, '2022-12-12'),
(4, 4, 3, 1200, '2022-12-7'),
(5, 6, 3, 1200, '2022-12-15'),
(6, 7, 4, 60, '2022-12-12'),
(7, 8, 4, 60, '2022-12-22'),
(8, 10, 5, 60, '2022-12-18'),
(9, 13, 6, 840, '2022-12-8'),
(10, 14, 6, 840, '2022-12-15'),
(11, 16, 7, 1600, '2022-12-7'),
(12, 17, 7, 1600, '2022-12-29'),
(13, 19, 7, 1600, '2022-12-30'),
(14, 20, 8, 1600, '2022-12-31'),
(15, 22, 8, 1600, '2023-1-2'),
(16, 23, 9, 1700, '2023-1-4'),
(17, 25, 10, 500, '2023-1-2'),
(18, 26, 1, 360, '2023-1-6'),
(19, 27, 3, 1200, '2023-1-9'),
(20, 28, 5, 60, '2023-1-9'),
(21, 32, 7, 1600, '2022-12-16'),
(22, 33, 6, 840, '2022-12-13'),
(23, 36, 6, 840, '2022-12-17'),
(24, 37, 8, 1600, '2023-12-7'),
(25, 38, 9, 1700, '2023-12-11');

INSERT INTO Payment VALUES
(1, 1, 1, 1160, '2022-12-04', 'Card'),
(2, 2, 2, 3760, '2022-12-06', 'Card'),
(3, 3, 3, 1400, '2022-12-04', 'Card'),
(4, 4, 4, 1600, '2022-11-29', 'Card'),
(5, 5, 5, 800, '2022-12-02', 'Card'),
(6, 6, 6, 4700, '2022-12-08', 'Card'),
(7, 7, 7, 3560, '2022-12-04', 'Cash'),
(8, 8, 8, 1360, '2022-12-12', 'Card'),
(9, 9, 9, 500, '2022-12-13', 'Card'),
(10, 10, 10, 1360, '2022-12-08', 'Card'),
(11, 11, 11, 1100, '2022-12-02', 'Cash'),
(12, 12, 12, 1400, '2022-11-27', 'Card'),
(13, 13, 13, 1440, '2022-11-29', 'Card'),
(14, 14, 14, 1440, '2022-12-07', 'Card'),
(15, 15, 15, 1100, '2022-12-18', 'Card'),
(16, 16, 16, 5200, '2022-11-29', 'Cash'),
(17, 17, 17, 3400, '2022-12-20', 'Card'),
(18, 18, 18, 600, '2022-12-21', 'Card'),
(19, 19, 19, 2700, '2022-12-21', 'Card'),
(20, 20, 20, 3200, '2022-12-24', 'Card'),
(21, 21, 21, 700, '2022-12-23', 'Card'),
(22, 22, 22, 2300, '2022-12-21', 'Card'),
(23, 23, 22, 5400, '2022-12-26', 'Card'),
(24, 24, 22, 1100, '2022-12-24', 'Card'),
(25, 25, 23, 2400, '2022-12-26', 'Card'),
(26, 26, 23, 1160, '2022-12-28', 'Card'),
(27, 27, 24, 2000, '2022-12-29', 'Card'),
(28, 28, 25, 3860, '2022-12-30', 'Card'),
(29, 29, 26, 3800, '2022-12-17', 'Card'),
(30, 30, 27, 1200, '2022-12-30', 'Card'),
(31, 31, 28, 900, '2022-12-06', 'Cash'),
(32, 32, 29, 5500, '2022-12-09', 'Card'),
(33, 33, 30, 1740, '2022-12-05', 'Cash'),
(34, 34, 31, 2100, '2022-12-17', 'Cash'),
(35, 35, 32, 3900, '2022-12-01', 'Card'),
(36, 36, 33, 2240, '2022-12-08', 'Card'),
(37, 37, 34, 3600, '2022-11-28', 'Card'),
(38, 38, 34, 2700, '2022-12-10', 'Cash'),
(39, 39, 35, 4000, '2023-12-12', 'Cash'),
(40, 40, 35, 1500, '2023-12-08', 'Card');

--------------
ALTER TABLE Booking
ADD CONSTRAINT Book_BookAcc_ID FOREIGN KEY (BookingAccommodationID) REFERENCES BookingAccommodation(BookingAccommodationID);
ALTER TABLE Booking
ADD CONSTRAINT Book_BookFac_ID FOREIGN KEY (BookingFacilityID) REFERENCES BookingFacility(BookingFacilityID);
ALTER TABLE Booking
ADD CONSTRAINT Book_Pay_ID FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID);
--------------

SELECT * FROM Client;
SELECT * FROM Accommodation;
SELECT * FROM Room;
SELECT * FROM BookingAccommodation;
SELECT * FROM Facilities;
SELECT * FROM BookingFacility;
SELECT * FROM Staff;
SELECT * FROM Booking;
SELECT * FROM Payment;

---------------
-- Part C
---------------

-- 4. Provide a list of businesses that have the most service transaction (service
-- transaction means – they have booked many facilities / services using this system)
-- by state or Town.
SELECT
    c.ClientID,
    c.ClientName,
    c.State,
    COUNT(b.BookingID) AS ServiceTransactionCount
FROM Client c
LEFT JOIN Booking b ON c.ClientID = b.ClientID
GROUP BY c.ClientID, c.ClientName, c.State
ORDER BY ServiceTransactionCount DESC;

-- 5. Provide a list of clients by business clients, school and Youth group - representative
-- (name & contact numbers).
SELECT
	ClientName,
	ClientType,
	RepName,
	RepPhone
FROM Client
WHERE ClientType IN ('Business', 'School', 'YouthGroup')
ORDER BY ClientType, ClientName;


-- 6. Write SQL query to list down total number of rooms that are of type dormitories.
SELECT
    COUNT(*) AS TotalDormitoryRooms
FROM
    Room
WHERE
    RoomType = 'Dormitory';

-- 7. Compute an increase of 6% on booking charges for all the facilities. Upon having
-- the increased price now compute the raw income that would be been achieved in
-- 2023 using the new price.
 
-- Update the BookingFacility table with a 6% increase in HireCharge
UPDATE Room
SET Price = Price * 1.06;
UPDATE BookingAccommodation
SET Price = Price * 1.06;
UPDATE Facilities
SET HireCharge = 1.06;
UPDATE BookingFacility
SET HireCharge = HireCharge * 1.06;
UPDATE Booking
SET BookingBaseFare = BookingBaseFare * 1.06;
UPDATE Payment
SET TotalTransaction = TotalTransaction * 1.06;

-- Calculate the raw income for 2023 using the new prices
SELECT
    SUM(TotalTransaction) AS RawIncome2023
FROM
    Payment
WHERE
    YEAR(PaymentDate) = 2023;

-- 8. Provide a report that indicates the total number of booking closed by staff in the
-- year 2022.
SELECT
    s.StaffID,
    s.StaffName,
    COUNT(b.BookingID) AS TotalBookingsClosed
FROM
    Staff s
JOIN
    Booking b ON s.StaffID = b.StaffID
WHERE
    YEAR(b.DateOfBooking) = 2022
GROUP BY
    s.StaffID, s.StaffName;

-- 9. Identify from the system the staff that have closed the highest sales for the year 2022
SELECT
    s.StaffID,
    s.StaffName,
    SUM(b.BookingBaseFare) AS TotalSales
FROM
    Staff s
JOIN
    Booking b ON s.StaffID = b.StaffID
WHERE
    YEAR(b.DateOfBooking) = 2022
GROUP BY
    s.StaffID, s.StaffName
ORDER BY
    TotalSales DESC
LIMIT 1;

-- 4. Provide a list of businesses that have the most service transaction (service
-- transaction means – they have booked many facilities / services using this system)
-- by state or Town.
SELECT
    c.ClientID,
    c.ClientName,
    c.State,
    COUNT(b.BookingID) AS ServiceTransactionCount
FROM Client c
LEFT JOIN Booking b ON c.ClientID = b.ClientID
GROUP BY c.ClientID, c.ClientName, c.State
ORDER BY ServiceTransactionCount DESC;

-- 5. Provide a list of clients by business clients, school and Youth group - representative
-- (name & contact numbers).
SELECT
	ClientName,
	ClientType,
	RepName,
	RepPhone
FROM Client
WHERE ClientType IN ('Business', 'School', 'YouthGroup')
ORDER BY ClientType, ClientName;


-- 6. Write SQL query to list down total number of rooms that are of type dormitories.
SELECT
    COUNT(*) AS TotalDormitoryRooms
FROM
    Room
WHERE
    RoomType = 'Dormitory';

-- 7. Compute an increase of 6% on booking charges for all the facilities. Upon having
-- the increased price now compute the raw income that would be been achieved in
-- 2023 using the new price.
 
-- Update the BookingFacility table with a 6% increase in HireCharge
UPDATE Room
SET Price = Price * 1.06;
UPDATE BookingAccommodation
SET Price = Price * 1.06;
UPDATE Facilities
SET HireCharge = 1.06;
UPDATE BookingFacility
SET HireCharge = HireCharge * 1.06;
UPDATE Booking
SET BookingBaseFare = BookingBaseFare * 1.06;
UPDATE Payment
SET TotalTransaction = TotalTransaction * 1.06;

-- Calculate the raw income for 2023 using the new prices
SELECT
    SUM(TotalTransaction) AS RawIncome2023
FROM
    Payment
WHERE
    YEAR(PaymentDate) = 2023;

-- 8. Provide a report that indicates the total number of booking closed by staff in the
-- year 2022.
SELECT
    s.StaffID,
    s.StaffName,
    COUNT(b.BookingID) AS TotalBookingsClosed
FROM
    Staff s
JOIN
    Booking b ON s.StaffID = b.StaffID
WHERE
    YEAR(b.DateOfBooking) = 2022
GROUP BY
    s.StaffID, s.StaffName;

-- 9. Identify from the system the staff that have closed the highest sales for the year 2022
SELECT
    s.StaffID,
    s.StaffName,
    SUM(b.BookingBaseFare) AS TotalSales
FROM
    Staff s
JOIN
    Booking b ON s.StaffID = b.StaffID
WHERE
    YEAR(b.DateOfBooking) = 2022
GROUP BY
    s.StaffID, s.StaffName
ORDER BY
    TotalSales DESC
LIMIT 1;

---------------
-- Part D
---------------

-- Provide insights into the average duration of stays for different accommodation types.
SELECT
    a.AccommodationType,
    AVG(DATEDIFF(StayEndDate, StayStartDate)) AS AvgBookingDuration
FROM
    Booking b, BookingAccommodation ba
JOIN
    Room r ON ba.RoomID = r.RoomID
JOIN
    Accommodation a ON r.AccommodationID = a.AccommodationID
WHERE
    StayEndDate IS NOT NULL
GROUP BY
    a.AccommodationType;
    
-- Provide an overview of booking statistics.
SELECT
    YEAR(DateOfBooking) AS BookingYear,
    COUNT(BookingID) AS TotalBookings,
    SUM(NumberOfPeople) AS TotalGuests,
    SUM(BookingBaseFare) AS TotalRevenue
FROM
    Booking
GROUP BY
    BookingYear;
    
-- Show the utilization of different facilities.
SELECT
    f.FacilityName,
    COUNT(bf.BookingFacilityID) AS UsageCount
FROM
    Facilities f
LEFT JOIN
    BookingFacility bf ON f.FacilityID = bf.FacilityID
GROUP BY
    f.FacilityName;
    
-- Identify the top clients based on total transaction amount.
SELECT
    c.ClientName,
    SUM(p.TotalTransaction) AS TotalSpent
FROM
    Client c
JOIN
    Payment p ON c.ClientID = p.ClientID
GROUP BY
    c.ClientName
ORDER BY
    TotalSpent DESC
LIMIT 10;
    
-- Analyze the revenue generated by each staff member for both accommodation, facility services, and base fare in the year 2022.

-- Create a temporary table to store the total revenue for each staff member
CREATE TEMPORARY TABLE TempRevenue AS
SELECT
    B.StaffID,
    S.StaffName,
    SUM(BA.Price) AS AccommodationRevenue,
    SUM(BF.HireCharge) AS FacilityRevenue,
    SUM(B.BookingBaseFare) AS BaseFare
FROM
    Booking B
JOIN
    BookingAccommodation BA ON B.BookingAccommodationID = BA.BookingAccommodationID
JOIN
    BookingFacility BF ON B.BookingFacilityID = BF.BookingFacilityID
JOIN
    Staff S ON B.StaffID = S.StaffID
WHERE
    YEAR(B.DateOfBooking) = 2022
GROUP BY
    B.StaffID;

-- Calculate the total revenue for each staff member
SELECT
    StaffID,
    StaffName,
    SUM(AccommodationRevenue) AS TotalAccommodationRevenue,
    SUM(FacilityRevenue) AS TotalFacilityRevenue,
    SUM(BaseFare) AS TotalBaseFare,
    (SUM(AccommodationRevenue) + SUM(FacilityRevenue) + SUM(BaseFare)) AS TotalRevenue
FROM
    TempRevenue
GROUP BY
    StaffID, StaffName;

-- Drop the temporary table
DROP TEMPORARY TABLE IF EXISTS TempRevenue;
