-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/eAt1dY
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(50)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `address_id` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `customers` (
    `customer_id` int  NOT NULL ,
    `customer_first_name` varchar(50)  NOT NULL ,
    `customer_last_name` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `address` (
    `address_id` int  NOT NULL ,
    `delivery_address_1` varchar(200)  NOT NULL ,
    `delivery_address_2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipcode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `address_id`
    )
);

CREATE TABLE `item` (
    `item_id` varchar(10)  NOT NULL ,
    `sku` varchar(20)  NOT NULL ,
    `item_name` varchar(50)  NOT NULL ,
    `item_cat` varchar(50)  NOT NULL ,
    `item_size` varchar(20)  NOT NULL ,
    `item_price` decimal(5,2)  NOT NULL 
);

CREATE TABLE `ingredient` (
    `ingredient_id` varchar(10)  NOT NULL ,
    `ingredient_name` varchar(200)  NOT NULL ,
    `ingredient_weight` int  NOT NULL ,
    `ingredient_measurement` varchar(20)  NOT NULL ,
    `ingredient_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ingredient_id`
    )
);

CREATE TABLE `recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(20)  NOT NULL ,
    `ingredient_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `inventory` (
    `inventory_id` int  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inventory_id`
    )
);

CREATE TABLE `staff` (
    `staff_id` varchar(20)  NOT NULL ,
    `first_name` varchar(50)  NOT NULL ,
    `last_name` varchar(50)  NOT NULL ,
    `position` varchar(50)  NOT NULL ,
    `hourly_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `rota` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

ALTER TABLE `customers` ADD CONSTRAINT `fk_customers_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `orders` (`customer_id`);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_address_id` FOREIGN KEY(`address_id`)
REFERENCES `orders` (`address_id`);

ALTER TABLE `item` ADD CONSTRAINT `fk_item_item_id` FOREIGN KEY(`item_id`)
REFERENCES `orders` (`item_id`);

ALTER TABLE `ingredient` ADD CONSTRAINT `fk_ingredient_ingredient_id` FOREIGN KEY(`ingredient_id`)
REFERENCES `recipe` (`ingredient_id`);

ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `item` (`sku`);

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_item_id` FOREIGN KEY(`item_id`)
REFERENCES `recipe` (`ingredient_id`);

ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `rota` (`shift_id`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_date` FOREIGN KEY(`date`)
REFERENCES `orders` (`created_at`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staff` (`staff_id`);

