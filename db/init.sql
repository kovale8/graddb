-- create the database
DROP DATABASE IF EXISTS nile;
CREATE DATABASE nile;

-- select the database
USE nile;

-- create the tables

-- Address
CREATE TABLE `Address` (
  `address_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Address Type
CREATE TABLE `AddressType` (
  `address_type_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `address_type` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Category
CREATE TABLE `Category` (
  `category_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Product
CREATE TABLE `Product` (
  `product_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_description` varchar(3000) DEFAULT NULL,
  `category_id` smallint(5) DEFAULT NULL,
  `price` decimal(18,2) DEFAULT NULL,
  `minimum_stock_level` int(11) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `fk_product_category` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `Category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Offer
CREATE TABLE `Offer` (
  `offer_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `product_id` smallint(5) NOT NULL,
  `offer_code` varchar(15) DEFAULT NULL,
  `offer_description` varchar(3000) DEFAULT NULL,
  `discount` decimal(18,2) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`offer_id`),
  KEY `fk_offer_product` (`product_id`),
  CONSTRAINT `fk_offer_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Restock
CREATE TABLE `Restock` (
  `restock_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `product_id` smallint(5) NOT NULL,
  `restock_item_count` int(11) DEFAULT NULL,
  `date_restocked` date DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`restock_id`),
  KEY `fk_restock_product` (`product_id`),
  CONSTRAINT `fk_restock_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Supplier
CREATE TABLE `Supplier` (
  `supplier_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Supplier Address
CREATE TABLE `Supplier_Address` (
  `supplier_id` smallint(5) NOT NULL,
  `address_id` smallint(5) NOT NULL,
  `address_type` smallint(5) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`, `address_id`, `address_type`),
  KEY `fk_supplier_address_customer` (`supplier_id`),
  KEY `fk_supplier_address_address` (`address_id`),
  CONSTRAINT `fk_supplier_address_address` FOREIGN KEY (`address_id`) REFERENCES `Address` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_supplier_address_customer` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`supplier_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Customer
CREATE TABLE `Customer` (
  `customer_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Customer Address
CREATE TABLE `Customer_Address` (
  `customer_id` smallint(5) NOT NULL,
  `address_id` smallint(5) NOT NULL,
  `address_type` smallint(5) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`, `address_id`, `address_type`),
  KEY `fk_customer_address_customer` (`customer_id`),
  KEY `fk_customer_address_address` (`address_id`),
  KEY `fk_customer_address_addresstype` (`address_type`),
  CONSTRAINT `fk_customer_address_address` FOREIGN KEY (`address_id`) REFERENCES `Address` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_address_addresstype` FOREIGN KEY (`address_type`) REFERENCES `AddressType` (`address_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_address_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Wishlist
CREATE TABLE `Wishlist` (
  `customer_id` smallint(5) NOT NULL,
  `product_id` smallint(5) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`,`product_id`),
  KEY `fk_wishlist_product` (`product_id`),
  CONSTRAINT `fk_wishlist_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_wishlist_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Shopping Cart
CREATE TABLE `ShoppingCart` (
  `customer_id` smallint(5) NOT NULL,
  `product_id` smallint(5) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`,`product_id`),
  KEY `fk_shoppingcart_product` (`product_id`),
  CONSTRAINT `fk_shoppingcart_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_shoppingcart_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Rating
CREATE TABLE `Rating` (
  `product_id` smallint(5) NOT NULL,
  `customer_id` smallint(5) NOT NULL,
  `rating` int(11) NOT NULL,
  `comments` varchar(3000) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`,`product_id`),
  KEY `fk_rating_product` (`product_id`),
  CONSTRAINT `fk_rating_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_rating_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Order
CREATE TABLE `Order` (
  `order_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `customer_id` smallint(5) NOT NULL,
  `confirmation_number` varchar(255) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `delivered_date` datetime DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `fk_order_customer` (`customer_id`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Order Address
CREATE TABLE `Order_Address` (
  `order_id` smallint(5) NOT NULL,
  `address_id` smallint(5) NOT NULL,
  `address_type` smallint(5) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `address_id`, `address_type`),
  KEY `fk_order_address_order` (`order_id`),
  KEY `fk_order_address_address` (`address_id`),
  CONSTRAINT `fk_order_address_address` FOREIGN KEY (`address_id`) REFERENCES `Address` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_address_customer` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Order Products
CREATE TABLE `Order_Products` (
  `order_id` smallint(5) NOT NULL,
  `product_id` smallint(5) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_product_product` (`product_id`),
  CONSTRAINT `fk_order_product_order` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_product_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
