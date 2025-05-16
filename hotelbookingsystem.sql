
---

###  `hotel_booking_system.sql`

```sql
-- Create the database
CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;

-- Guest Table
CREATE TABLE guest (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50)
);

-- Payment Status Table
CREATE TABLE payment_status (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_status_name VARCHAR(20) DEFAULT "NOT PAID"
);

-- Booking Table
CREATE TABLE booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    payment_status_id INT,
    checkin_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    checkout_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    num_adults INT,
    num_children INT,
    booking_amount DECIMAL(10,2) CHECK (booking_amount > 0),
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id),
    FOREIGN KEY (payment_status_id) REFERENCES payment_status(payment_id)
);

-- Addon Table
CREATE TABLE addon (
    addon_id INT PRIMARY KEY AUTO_INCREMENT,
    addon_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

-- Booking_Addon Table (M:M between booking and addons)
CREATE TABLE booking_addon (
    booking_id INT NOT NULL,
    addon_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (addon_id) REFERENCES addon(addon_id)
);

-- Bed Type Table
CREATE TABLE bed_type (
    bed_type_id INT PRIMARY KEY AUTO_INCREMENT,
    bed_type_name VARCHAR(100)
);

-- Room Class Table
CREATE TABLE room_class (
    room_class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(100),
    base_price DECIMAL(10,2)
);

-- Feature Table
CREATE TABLE feature (
    feature_id INT PRIMARY KEY AUTO_INCREMENT,
    feature_name VARCHAR(100)
);

-- Room Class - Feature Mapping (M:M)
CREATE TABLE room_class_feature (
    room_class_id INT,
    feature_id INT,
    FOREIGN KEY (room_class_id) REFERENCES room_class(room_class_id),
    FOREIGN KEY (feature_id) REFERENCES feature(feature_id)
);

-- Room Class - Bed Type Mapping (M:M with extra field)
CREATE TABLE room_class_bed_type (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_class_id INT,
    bed_type_id INT,
    num_beds INT,
    FOREIGN KEY (room_class_id) REFERENCES room_class(room_class_id),
    FOREIGN KEY (bed_type_id) REFERENCES bed_type(bed_type_id)
);

-- Room Status Table
CREATE TABLE room_status (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(100)
);

-- Floor Table
CREATE TABLE floor (
    floor_id INT PRIMARY KEY AUTO_INCREMENT,
    floor_number VARCHAR(5)
);

-- Room Table
CREATE TABLE room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10),
    status_id INT,
    room_class_id INT,
    floor_id INT,
    FOREIGN KEY (status_id) REFERENCES room_status(id),
    FOREIGN KEY (room_class_id) REFERENCES room_class(room_class_id),
    FOREIGN KEY (floor_id) REFERENCES floor(floor_id)
);

-- Booking_Room Table (M:M between booking and rooms)
CREATE TABLE booking_room (
    booking_id INT,
    room_id INT,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);
