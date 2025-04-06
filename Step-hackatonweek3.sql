show databases;
use unox;
show tables;
select * from movie;
select * from booking;
select * from show1;
describe show1;
describe movie;
describe booking;

#C2
SELECT 
    m.movie_id as movie_id,
    m.title AS Movie,
    DATE_FORMAT(s.show_datetime, '%Y-%m-%d %H:%i') AS Time_Slot,
    SUM(b.total_cost) AS Total_Revenue
FROM movie m
JOIN show1 s ON m.movie_id = s.movie_id
LEFT JOIN booking b ON s.show_id = b.show_id
WHERE b.total_cost IS NOT NULL
GROUP BY m.movie_id, s.show_datetime
ORDER BY total_revenue desc;


#C3
SELECT 
    b.user_id,
    u.name1,
    COUNT(b.booking_id) AS total_bookings
FROM booking b
join user1 u on u.user_id=b.user_id 
GROUP BY b.user_id
ORDER BY total_bookings desc;

#C4
describe fooditem ;
describe fooditemsize;
describe foodorder;
describe foodorderitem;

SELECT 
    fi.item_id,
    fi.name AS name,
    count(foi.order_item_id) AS total_ordered,
    SUM(foi.quantity * foi.price_at_time) AS total_revenue
FROM fooditem fi
JOIN fooditemsize fis ON fi.item_id = fis.item_id
LEFT JOIN foodorderitem foi ON fi.item_id = foi.item_id 
    AND fis.size_id = foi.size_id
GROUP BY fi.item_id
ORDER BY total_revenue DESC;

#C5
Select
		p.user_id ,
        u.name1 as name,
		sum(p.points_earned) as Points
        from pointstransaction p
        join user1 u on p.user_id = u.user_id
	group by user_id
    order by points desc
    ;
  
#M2
SELECT			
User1.user_id,			
User1.name1,			
Membership.current_points			
FROM Membership			
JOIN User1 ON Membership.user_id = User1.user_id;			
  
#C2
SELECT 
    b.user_id, 
    u.name1, 
    SUM(f.total_cost) AS total_food_spending
FROM 
    foodorder f
    JOIN booking b ON f.booking_id = b.booking_id
    JOIN user1 u ON b.user_id = u.user_id
GROUP BY 
    b.user_id
ORDER BY 
    total_food_spending DESC
;

DESCRIBE movie;
DESCRIBE show1;
DESCRIBE booking;
DESCRIBE users;
DESCRIBE foodorder;
DESCRIBE fooditem;
DESCRIBE fooditemsize;
DESCRIBE foodorderitem;


#M2
SELECT 
    delivery_method, 
    COUNT(*) AS booking_count
FROM 
    foodorder
GROUP BY 
    delivery_method
ORDER BY 
    booking_count DESC;
    
#M3
SELECT 
    m.genre, 
    SUM(b.total_cost) AS total_revenue
FROM 
    movie m
JOIN show1 s ON m.movie_id = s.movie_id
JOIN booking b ON s.show_id = b.show_id
GROUP BY 
    m.genre
ORDER BY 
    total_revenue DESC;
    
#H3
#M1
SELECT 
    m.movie_id, 
    m.title, 
    SUM(b.total_cost) AS total_revenue
FROM 
    movie m
JOIN show1 s 
    ON m.movie_id = s.movie_id
JOIN booking b 
    ON s.show_id = b.show_id
WHERE 
    b.total_cost > 0
GROUP BY 
    m.movie_id
ORDER BY 
    total_revenue DESC;
    
#h3
#c1
DROP PROCEDURE IF EXISTS BookMovieTicket1;

DELIMITER $$

CREATE PROCEDURE BookMovieTicket1(
    IN p_user_id INT,
    IN p_show_id INT,
    IN p_seat_id INT,
    IN p_payment_gateway_id INT,
    IN p_transaction_amount DECIMAL(10,2),
    OUT p_booking_id INT,
    OUT p_message VARCHAR(255)
)
proc_main: BEGIN  
    -- Declare variables at the beginning
    DECLARE v_show_seat_id INT;
    DECLARE v_is_available TINYINT(1); 
    DECLARE v_transaction_id INT;

    -- Start transaction
    START TRANSACTION;

    -- Check if the seat is available
    SELECT show_seat_id, is_available 
    INTO v_show_seat_id, v_is_available
    FROM ShowSeat
    WHERE show_id = p_show_id AND seat_id = p_seat_id
    FOR UPDATE; 

    IF v_show_seat_id IS NULL THEN
        SET p_message = 'Error: Seat does not exist for the given show!';
        ROLLBACK;
        LEAVE proc_main;
    END IF;

    IF v_is_available = 0 THEN 
        SET p_message = 'Error: Seat is already booked!';
        ROLLBACK;
        LEAVE proc_main;
    END IF;

    -- Mark seat as booked
    UPDATE ShowSeat 
    SET is_available = 0
    WHERE show_seat_id = v_show_seat_id;

    -- Insert booking record
    INSERT INTO Booking (user_id, show_id, booking_datetime, total_cost)
    VALUES (p_user_id, p_show_id, NOW(), p_transaction_amount);
    
    SET p_booking_id = LAST_INSERT_ID(); 

    -- Insert ticket record
    INSERT INTO Ticket (booking_id, show_seat_id, qr_code, delivery_method, is_downloaded)
    VALUES (p_booking_id, v_show_seat_id, UUID(), 'email', 0);
    
    -- Process Payment
    INSERT INTO Payment (booking_id, gateway_id, transaction_amount, transaction_datetime, status)
    VALUES (p_booking_id, p_payment_gateway_id, p_transaction_amount, NOW(), 'SUCCESS');

    -- Commit transaction
    COMMIT;
    SET p_message = 'Booking successful!';

END$$

DELIMITER ;


SET @booking_id = NULL;
SET @message = NULL;

CALL BookMovieTicket1(
    1,  -- p_user_id
    1, -- p_show_id
    141,-- p_seat_id
    1,  -- p_payment_gateway_id
    250.00,  -- p_transaction_amount
    @booking_id,  -- Output: p_booking_id
    @message  -- Output: p_message
);

SELECT @booking_id, @message;

UPDATE ShowSeat 
SET is_available = 1 
WHERE show_seat_id = 141;


SELECT show_seat_id, is_available 
FROM ShowSeat 
WHERE show_id = 1 ;

#c2
DELIMITER $$

CREATE FUNCTION CalculateLoyaltyPoints(
    p_booking_id INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total_cost DECIMAL(10, 2);
    DECLARE v_loyalty_points INT;

    -- Retrieve the total cost of the booking
    SELECT total_cost INTO v_total_cost
    FROM Booking
    WHERE booking_id = p_booking_id;

    -- Calculate loyalty points (1 point per 100 INR)
    SET v_loyalty_points = FLOOR(v_total_cost / 100);

    RETURN v_loyalty_points;
END $$

DELIMITER ;

select * from Booking;
CalculateLoyaltyPoints{
