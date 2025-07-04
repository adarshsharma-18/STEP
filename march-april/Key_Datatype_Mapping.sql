-- Changing Data Types and Adding Constraints

-- Adding Primary Keys (PKs) and Foreign Keys (FKs)

ALTER TABLE Screen ADD PRIMARY KEY (screen_id);
ALTER TABLE Seat ADD PRIMARY KEY (seat_id);
ALTER TABLE Movie ADD PRIMARY KEY (movie_id);
ALTER TABLE MovieCast ADD PRIMARY KEY (cast_id);
ALTER TABLE Review ADD PRIMARY KEY (review_id);
ALTER TABLE `Show` ADD PRIMARY KEY (show_id);
ALTER TABLE ShowSeat ADD PRIMARY KEY (show_seat_id);
ALTER TABLE User ADD PRIMARY KEY (user_id);
ALTER TABLE Membership ADD PRIMARY KEY (membership_id);
ALTER TABLE Booking ADD PRIMARY KEY (booking_id);
ALTER TABLE Ticket ADD PRIMARY KEY (ticket_id);
ALTER TABLE PaymentGateway ADD PRIMARY KEY (gateway_id);
ALTER TABLE Payment ADD PRIMARY KEY (payment_id);
ALTER TABLE FoodItem ADD PRIMARY KEY (item_id);
ALTER TABLE FoodItemSize ADD PRIMARY KEY (size_id);
ALTER TABLE FoodOrder ADD PRIMARY KEY (order_id);
ALTER TABLE FoodOrderItem ADD PRIMARY KEY (order_item_id);
ALTER TABLE PointsTransaction ADD PRIMARY KEY (transaction_id);


-- Altering Data Types for Each Table
ALTER TABLE Screen MODIFY COLUMN screen_id INT AUTO_INCREMENT;
ALTER TABLE Screen MODIFY COLUMN name VARCHAR(50) NOT NULL;
ALTER TABLE Screen MODIFY COLUMN class_type VARCHAR(10) NOT NULL;
ALTER TABLE Screen MODIFY COLUMN capacity INT NOT NULL;

ALTER TABLE Seat MODIFY COLUMN seat_id INT AUTO_INCREMENT;
ALTER TABLE Seat MODIFY COLUMN screen_id INT;
ALTER TABLE Seat MODIFY COLUMN seat_number VARCHAR(10) NOT NULL;

ALTER TABLE Movie MODIFY COLUMN movie_id INT AUTO_INCREMENT;
ALTER TABLE Movie MODIFY COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE Movie MODIFY COLUMN genre VARCHAR(50) NOT NULL;
ALTER TABLE Movie MODIFY COLUMN rating DECIMAL(3,1) NOT NULL;
ALTER TABLE Movie MODIFY COLUMN status VARCHAR(20) NOT NULL;
ALTER TABLE Movie MODIFY COLUMN poster_image_url VARCHAR(255) NULL;

ALTER TABLE MovieCast MODIFY COLUMN cast_id INT AUTO_INCREMENT;
ALTER TABLE MovieCast MODIFY COLUMN movie_id INT;
ALTER TABLE MovieCast MODIFY COLUMN person_name VARCHAR(100) NOT NULL;
ALTER TABLE MovieCast MODIFY COLUMN role VARCHAR(100) NOT NULL;

ALTER TABLE Review MODIFY COLUMN review_id INT AUTO_INCREMENT;
ALTER TABLE Review MODIFY COLUMN movie_id INT;
ALTER TABLE Review MODIFY COLUMN content TEXT NOT NULL;
UPDATE Review 
SET review_date = STR_TO_DATE(review_date, '%d-%m-%Y %H:%i')
WHERE review_date LIKE '%-%';
ALTER TABLE Review MODIFY COLUMN review_date DATETIME NOT NULL;
ALTER TABLE Review MODIFY COLUMN reviewer_name VARCHAR(100) NOT NULL;

ALTER TABLE `Show` MODIFY COLUMN show_id INT AUTO_INCREMENT;
ALTER TABLE `Show` MODIFY COLUMN screen_id INT;
ALTER TABLE `Show` MODIFY COLUMN movie_id INT;
UPDATE `Show` 
SET show_datetime = STR_TO_DATE(show_datetime, '%d-%m-%Y %H:%i')
WHERE show_datetime LIKE '%-%';
ALTER TABLE `Show` MODIFY COLUMN show_datetime DATETIME NOT NULL;

ALTER TABLE ShowSeat MODIFY COLUMN show_seat_id INT AUTO_INCREMENT;
ALTER TABLE ShowSeat MODIFY COLUMN show_id INT;
ALTER TABLE ShowSeat MODIFY COLUMN seat_id INT;
-- First update the string values to proper boolean integers
UPDATE ShowSeat SET is_available = 0;
-- Then alter the table
ALTER TABLE ShowSeat MODIFY COLUMN is_available BOOLEAN NOT NULL DEFAULT TRUE;


ALTER TABLE User MODIFY COLUMN user_id INT AUTO_INCREMENT;
ALTER TABLE User MODIFY COLUMN name VARCHAR(100) NOT NULL;
ALTER TABLE User MODIFY COLUMN email VARCHAR(150) NOT NULL;
ALTER TABLE User MODIFY COLUMN phone VARCHAR(15) NULL;

ALTER TABLE Membership MODIFY COLUMN membership_id INT AUTO_INCREMENT;
ALTER TABLE Membership MODIFY COLUMN user_id INT;
ALTER TABLE Membership MODIFY COLUMN current_points INT NOT NULL DEFAULT 0;

ALTER TABLE Booking MODIFY COLUMN booking_id INT AUTO_INCREMENT;
ALTER TABLE Booking MODIFY COLUMN user_id INT;
ALTER TABLE Booking MODIFY COLUMN show_id INT;
ALTER TABLE Booking MODIFY COLUMN booking_datetime DATETIME NOT NULL;
ALTER TABLE Booking MODIFY COLUMN total_cost DECIMAL(10,2) NOT NULL;

ALTER TABLE Ticket MODIFY COLUMN ticket_id INT AUTO_INCREMENT;
ALTER TABLE Ticket MODIFY COLUMN booking_id INT;
ALTER TABLE Ticket MODIFY COLUMN show_seat_id INT;
ALTER TABLE Ticket MODIFY COLUMN qr_code VARCHAR(100) NOT NULL;
ALTER TABLE Ticket MODIFY COLUMN delivery_method VARCHAR(50) NOT NULL;
UPDATE Ticket
SET is_downloaded = CASE 
    WHEN TRIM(LOWER(is_downloaded)) = 'false' THEN 0 
    WHEN TRIM(LOWER(is_downloaded)) = 'true' THEN 1
    ELSE is_downloaded
END;
ALTER TABLE Ticket MODIFY COLUMN is_downloaded BOOLEAN NOT NULL DEFAULT FALSE;
update ticket set scanned_at = NULL where scanned_at not like '20%';
ALTER TABLE Ticket MODIFY COLUMN scanned_at DATETIME NULL;

ALTER TABLE PaymentGateway MODIFY COLUMN gateway_id INT AUTO_INCREMENT;
ALTER TABLE PaymentGateway MODIFY COLUMN name VARCHAR(100) NOT NULL;

ALTER TABLE Payment MODIFY COLUMN payment_id INT AUTO_INCREMENT;
ALTER TABLE Payment MODIFY COLUMN booking_id INT;
ALTER TABLE Payment MODIFY COLUMN gateway_id INT;
ALTER TABLE Payment MODIFY COLUMN transaction_amount DECIMAL(10,2) NOT NULL;
UPDATE Payment
SET transaction_datetime = STR_TO_DATE(transaction_datetime, '%d-%m-%Y %H:%i')
WHERE transaction_datetime LIKE '%-%';
ALTER TABLE Payment MODIFY COLUMN transaction_datetime DATETIME NOT NULL;
ALTER TABLE Payment MODIFY COLUMN status VARCHAR(20) NOT NULL;
ALTER TABLE Payment MODIFY COLUMN failure_reason TEXT NULL;
ALTER TABLE Payment MODIFY COLUMN credit_card_name VARCHAR(100) NULL;
ALTER TABLE Payment MODIFY COLUMN credit_card_number VARCHAR(20) NULL;
update payment set expiry_date = NULL where expiry_date not like '__-%';
UPDATE Payment 
SET expiry_date = STR_TO_DATE(expiry_date, '%d-%m-%Y') 
WHERE expiry_date LIKE '%-%-%';
ALTER TABLE Payment MODIFY COLUMN expiry_date DATE NULL;
ALTER TABLE Payment MODIFY COLUMN cvv VARCHAR(4) NULL;

ALTER TABLE FoodItem MODIFY COLUMN item_id INT AUTO_INCREMENT;
ALTER TABLE FoodItem MODIFY COLUMN name VARCHAR(100) NOT NULL;
ALTER TABLE FoodItem MODIFY COLUMN description TEXT NULL;
UPDATE FoodItem
SET is_combo = CASE 
    WHEN TRIM(LOWER(is_combo)) = 'false' THEN 0 
    WHEN TRIM(LOWER(is_combo)) = 'true' THEN 1
    ELSE is_combo
END;
ALTER TABLE FoodItem MODIFY COLUMN is_combo BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE FoodItemSize MODIFY COLUMN size_id INT AUTO_INCREMENT;
ALTER TABLE FoodItemSize MODIFY COLUMN item_id INT;
ALTER TABLE FoodItemSize MODIFY COLUMN size_name VARCHAR(50) NOT NULL;
ALTER TABLE FoodItemSize MODIFY COLUMN rate DECIMAL(10,2) NOT NULL;

ALTER TABLE FoodOrder MODIFY COLUMN order_id INT AUTO_INCREMENT;
ALTER TABLE FoodOrder MODIFY COLUMN booking_id INT;
ALTER TABLE FoodOrder MODIFY COLUMN screen_id INT;
ALTER TABLE FoodOrder MODIFY COLUMN seat_id INT;
UPDATE FoodOrder
SET order_datetime = STR_TO_DATE(order_datetime, '%d-%m-%Y %H:%i')
WHERE order_datetime LIKE '%-%';
ALTER TABLE FoodOrder MODIFY COLUMN order_datetime DATETIME NOT NULL;
ALTER TABLE FoodOrder MODIFY COLUMN total_cost DECIMAL(10,2) NOT NULL;
ALTER TABLE FoodOrder MODIFY COLUMN delivery_method VARCHAR(50) NOT NULL;

ALTER TABLE FoodOrderItem MODIFY COLUMN order_item_id INT AUTO_INCREMENT;
ALTER TABLE FoodOrderItem MODIFY COLUMN order_id INT;
ALTER TABLE FoodOrderItem MODIFY COLUMN item_id INT;
ALTER TABLE FoodOrderItem MODIFY COLUMN size_id INT;
ALTER TABLE FoodOrderItem MODIFY COLUMN quantity INT NOT NULL;
ALTER TABLE FoodOrderItem MODIFY COLUMN price_at_time DECIMAL(10,2) NOT NULL;

ALTER TABLE PointsTransaction MODIFY COLUMN transaction_id INT AUTO_INCREMENT;
ALTER TABLE PointsTransaction MODIFY COLUMN user_id INT;
ALTER TABLE PointsTransaction MODIFY COLUMN amount DECIMAL(10,2) NOT NULL;
ALTER TABLE PointsTransaction MODIFY COLUMN points_earned INT NOT NULL;
ALTER TABLE PointsTransaction MODIFY COLUMN transaction_datetime DATETIME NOT NULL;
ALTER TABLE PointsTransaction MODIFY COLUMN transaction_type VARCHAR(20) NOT NULL;


-- Adding Foreign Keys (FKs)
ALTER TABLE Seat ADD CONSTRAINT fk_seat_screen FOREIGN KEY (screen_id) REFERENCES Screen(screen_id);
ALTER TABLE MovieCast ADD CONSTRAINT fk_moviecast_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id);
ALTER TABLE Review ADD CONSTRAINT fk_review_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id);
ALTER TABLE `Show` ADD CONSTRAINT fk_show_screen FOREIGN KEY (screen_id) REFERENCES Screen(screen_id);
ALTER TABLE `Show` ADD CONSTRAINT fk_show_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id);
ALTER TABLE ShowSeat ADD CONSTRAINT fk_showseat_show FOREIGN KEY (show_id) REFERENCES `Show`(show_id);
ALTER TABLE ShowSeat ADD CONSTRAINT fk_showseat_seat FOREIGN KEY (seat_id) REFERENCES Seat(seat_id);
ALTER TABLE Membership ADD CONSTRAINT fk_membership_user FOREIGN KEY (user_id) REFERENCES User(user_id);
ALTER TABLE Booking ADD CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES User(user_id);
ALTER TABLE Booking ADD CONSTRAINT fk_booking_show FOREIGN KEY (show_id) REFERENCES `Show`(show_id);
ALTER TABLE Ticket ADD CONSTRAINT fk_ticket_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Ticket ADD CONSTRAINT fk_ticket_showseat FOREIGN KEY (show_seat_id) REFERENCES ShowSeat(show_seat_id);
ALTER TABLE Payment ADD CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Payment ADD CONSTRAINT fk_payment_gateway FOREIGN KEY (gateway_id) REFERENCES PaymentGateway(gateway_id);
ALTER TABLE FoodItemSize ADD CONSTRAINT fk_fooditemsize_item FOREIGN KEY (item_id) REFERENCES FoodItem(item_id);
