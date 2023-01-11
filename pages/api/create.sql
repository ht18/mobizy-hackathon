DROP DATABASE IF EXISTS `mobizy`;

CREATE DATABASE `mobizy`;

USE `mobizy`;

DROP TABLE IF EXISTS `company`, `user`, `individual`, `vehicle`, `booked`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `description` varchar(255) NULL, 
  `hashed_password` varchar(600) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT UC_Email UNIQUE (email)
);

INSERT INTO user (email, description, hashed_password) VALUES ("email_1@gmail.com", "user_description_1", "hashed_password_1"), ("email_2@gmail.com", "user_description_2", "hashed_password_2"), ("email_3@gmail.com", "user_description_3", "hashed_password_3"), ("email_4@gmail.com", "user_description_4", "hashed_password_4"), ("email_5@gmail.com", "user_description_5", "hashed_password_5"), ("email_6@gmail.com", "user_description_6", "hashed_password_6");

CREATE TABLE `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `role` varchar(60) NOT NULL DEFAULT "COMPANY_ROLE",
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_company_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
); 

INSERT INTO company (name, user_id) VALUES ("company_name_1", 4), ("company_name_2", 5);

CREATE TABLE `individual` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `licence` varchar(100) NOT NULL,
  `role` varchar(60) NOT NULL DEFAULT "INDIVIDUAL_ROLE",
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_individual_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
); 

INSERT INTO individual (firstname, lastname, licence, user_id) VALUES ("individual_firstname_1", "individual_lastname_1", "individual_licence_1", 1), ("individual_firstname_2", "individual_lastname_2", "individual_licence_2", 1);

CREATE TABLE `vehicle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `photo_path` varchar(100) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  `date_of_purchase` YEAR(4) NOT NULL,
  `fuel`int NOT NULL,
  `kilometers` int NOT NULL,
  `location` varchar(100) NOT NULL,
  `nbr_seats` int NOT NULL,
  `gearbox` varchar(50) NOT NULL DEFAULT "manual",
  `is_ramp` tinyint(1) NOT NULL DEFAULT 0,
  `is_sonar` tinyint(1) NOT NULL DEFAULT 0,
  `is_sphere` tinyint(1) NOT NULL DEFAULT 0,
  `daily_price` int NOT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vehicle_company` FOREIGN KEY (`company_id`) REFERENCES `vehicle` (`id`)
); 

INSERT INTO vehicle 
(brand, model, photo_path, description, date_of_purchase, fuel, kilometers, location, nbr_seats, gearbox, is_ramp, is_sonar, is_sphere, daily_price, company_id) VALUES
("vehicle_brand_1", "vehicle_model_1", "vehicle_photo_path_1", "vehicle_description_1", 2014, 100, 1000, 'Paris', 3, "automatic", 0, 0, 1, 20, 1),
("vehicle_brand_2", "vehicle_model_2", "vehicle_photo_path_2", "vehicle_description_2", 2002, 100, 1000, 'Hambourg', 3, "manual", 0, 1, 0, 200, 2),
("vehicle_brand_3", "vehicle_model_3", "vehicle_photo_path_3", "vehicle_description_3", 2020, 100, 1000, 'Stockholm', 3, "manual", 1, 0, 1, 50, 2),
("vehicle_brand_4", "vehicle_model_4", "vehicle_photo_path_4", "vehicle_description_4", 2008, 100, 1000, 'Sydney', 3, "manual", 1, 0, 1, 30, 1),
("vehicle_brand_5", "vehicle_model_5", "vehicle_photo_path_5", "vehicle_description_5", 2014, 100, 1000, 'Valencia', 3, "manual", 1, 1, 1, 20, 1);

CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `user_id` int NOT NULL,
  `vehicle_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reservation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_reservation_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `user` (`id`)
); 

INSERT INTO reservation (start_date, end_date, user_id, vehicle_id) VALUES ("2021-02-15 9:55:12", "2021-02-17 9:55:12", 1, 1), ("2022-02-15 9:55:12", "2022-02-17 9:55:12", 1, 2), ("2022-02-15 9:55:12", "2022-02-17 9:55:12", 2, 1);