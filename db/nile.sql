-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema nile
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nile
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nile`;
CREATE SCHEMA `nile` DEFAULT CHARACTER SET latin1 ;
USE `nile` ;

-- -----------------------------------------------------
-- Table `nile`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Category` (
  `category_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NOT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Customer` (
  `customer_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email_address` VARCHAR(255) NULL DEFAULT NULL,
  `is_admin` TINYINT(4) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Supplier` (
  `supplier_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(255) NOT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Product` (
  `product_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) NOT NULL,
  `product_description` VARCHAR(3000) NULL DEFAULT NULL,
  `supplier_id` SMALLINT(5) NULL DEFAULT NULL,
  `price` DECIMAL(18,2) NULL DEFAULT NULL,
  `inventory` SMALLINT(5) NULL DEFAULT NULL,
  `minimum_stock_level` INT(11) NULL DEFAULT NULL,
  `target_units_sold` INT(11) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_supplier` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `nile`.`Supplier` (`supplier_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Product_Source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Product_Source` (
  `source_id` SMALLINT(5) NOT NULL,
  `source_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`source_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Product_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Product_Category` (
  `product_source` SMALLINT(5) NOT NULL,
  `product_id` SMALLINT(5) NOT NULL,
  `category_id` SMALLINT(5) NOT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_source`, `product_id`, `category_id`),
  INDEX `fk_product_source` (`product_source` ASC) VISIBLE,
  INDEX `fk_product_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `nile`.`Category` (`category_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_source`
    FOREIGN KEY (`product_source`)
    REFERENCES `nile`.`Product_Source` (`source_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`PurchaseOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`PurchaseOrder` (
  `order_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `customer_id` SMALLINT(5) NOT NULL,
  `shipping_date` DATETIME NOT NULL,
  `transaction_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  INDEX `fk_purchaseorder_customer` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchaseorder_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nile`.`Customer` (`customer_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`PurchaseOrder_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`PurchaseOrder_Product` (
  `order_id` SMALLINT(5) NOT NULL,
  `product_source` SMALLINT(5) NOT NULL,
  `product_id` SMALLINT(5) NOT NULL,
  `quantity` SMALLINT(5) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `product_source`, `product_id`),
  INDEX `fk_purchaseorder_order` (`order_id` ASC) VISIBLE,
  INDEX `fk_purchaseorder_source` (`product_source` ASC) VISIBLE,
  CONSTRAINT `fk_purchaseorder_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `nile`.`PurchaseOrder` (`order_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_purchaseorder_source`
    FOREIGN KEY (`product_source`)
    REFERENCES `nile`.`Product_Source` (`source_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Rating` (
  `customer_id` SMALLINT(5) NOT NULL,
  `product_source` SMALLINT(5) NOT NULL,
  `product_id` SMALLINT(5) NOT NULL,
  `rating` SMALLINT(5) NOT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`, `product_source`, `product_id`),
  INDEX `fk_rating_customer` (`customer_id` ASC) VISIBLE,
  INDEX `fk_rating_source` (`product_source` ASC) VISIBLE,
  CONSTRAINT `fk_rating_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nile`.`Customer` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rating_source`
    FOREIGN KEY (`product_source`)
    REFERENCES `nile`.`Product_Source` (`source_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Restocking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Restocking` (
  `restock_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `product_id` SMALLINT(5) NOT NULL,
  `restock_count` SMALLINT(5) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`restock_id`),
  INDEX `fk_restocking_product` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_restocking_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `nile`.`Product` (`product_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`ShoppingCartItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`ShoppingCartItem` (
  `customer_id` SMALLINT(5) NOT NULL,
  `product_source` SMALLINT(5) NOT NULL,
  `product_id` SMALLINT(5) NOT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`, `product_source`, `product_id`),
  INDEX `fk_shoppingcart_customer` (`customer_id` ASC) VISIBLE,
  INDEX `fk_shoppingcartitem_source` (`product_source` ASC) VISIBLE,
  CONSTRAINT `fk_shoppingcart_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nile`.`Customer` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_shoppingcartitem_source`
    FOREIGN KEY (`product_source`)
    REFERENCES `nile`.`Product_Source` (`source_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nile`.`Wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Wishlist` (
  `customer_id` SMALLINT(5) NOT NULL,
  `product_source` SMALLINT(5) NOT NULL,
  `product_id` SMALLINT(5) NOT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`, `product_source`, `product_id`),
  INDEX `fk_wishlist_customer` (`customer_id` ASC) VISIBLE,
  INDEX `fk_wishlist_source` (`product_source` ASC) VISIBLE,
  CONSTRAINT `fk_wishlist_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nile`.`Customer` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_wishlist_source`
    FOREIGN KEY (`product_source`)
    REFERENCES `nile`.`Product_Source` (`source_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `nile` ;

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`Customer_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Customer_View` (`customer_id` INT, `first_name` INT, `last_name` INT, `email_address` INT, `is_admin` INT, `source` INT, `source_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`MinimumStockLevelProducts_Report_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`MinimumStockLevelProducts_Report_View` (`product_id` INT, `product_name` INT, `price` INT, `inventory` INT, `minimum_stock_level` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`NotSellingTooWell_Products_Report_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`NotSellingTooWell_Products_Report_View` (`product_id` INT, `product_name` INT, `target_units_sold` INT, `monthly_count` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`NotTooActive_Customers_Report_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`NotTooActive_Customers_Report_View` (`customer_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`Product_Inventory_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Product_Inventory_View` (`product_id` INT, `product_name` INT, `inventory` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`Product_Total_Count_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Product_Total_Count_View` (`product_source` INT, `product_id` INT, `COUNT` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nile`.`Product_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nile`.`Product_View` (`product_id` INT, `product_name` INT, `product_description` INT, `supplier_id` INT, `price` INT, `category` INT, `category_id` INT, `source_name` INT, `source_id` INT);

-- -----------------------------------------------------
-- procedure Add_Category
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Category`(IN add_category_name varchar(100))
INSERT INTO Category (category_name) VALUES (add_category_name)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Customer
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Customer`(IN add_first_name varchar(100),
IN add_last_name varchar(100),
IN add_email_address varchar(100),
IN add_is_admin int)
BEGIN
	INSERT INTO Customer (first_name, last_name, email_address, is_admin)
    VALUES (add_first_name, add_last_name, add_email_address, add_is_admin);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Product
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Product`(IN add_product_name varchar(100),
add_product_description varchar(8000),
add_supplier_id smallint(5),
add_price decimal(18,2),
add_inventory smallint(5),
add_minimum_stock_level int(11),
add_target_units_sold int(11)
)
INSERT INTO Product (product_name, product_description, supplier_id, price, inventory, minimum_stock_level, target_units_sold)
VALUES (add_product_name, add_product_description, add_supplier_id, add_price, add_inventory, add_minimum_stock_level,
add_target_units_sold)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_ProductCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_ProductCategory`(IN add_product_source smallint(5), add_product_id smallint(5), add_category_id smallint(5))
INSERT INTO Product_Category (product_source, product_id, category_id)
VALUES
(add_product_source, add_product_id, add_category_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_ProductSource
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_ProductSource`(IN add_source_name varchar(50))
INSERT INTO Product_Source (source_name) VALUES (add_source_name)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_PurchaseOrder
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_PurchaseOrder`(IN add_customer_id smallint(5))
INSERT INTO PurchaseOrder
(customer_id, shipping_date, transaction_date)
VALUES
(add_customer_id, Get_ShippingDate(NOW()), NOW())$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_PurchaseOrderProduct
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_PurchaseOrderProduct`(
IN add_order_id smallint(5),
IN add_product_source smallint(5),
IN add_product_id smallint(5),
IN add_quantity smallint(5))
INSERT INTO PurchaseOrder_Product
(order_id, product_source, product_id, quantity)
VALUES
(add_order_id, add_product_source, add_product_id, add_quantity)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Rating
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Rating`(IN add_customer_id smallint(5), IN add_product_source smallint(5), IN add_product_id smallint(5), IN add_rating smallint(5))
INSERT INTO Rating (customer_id, product_source, product_id, rating)
VALUES
(add_customer_id, add_product_source, add_product_id, add_rating)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Restocking
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Restocking`(IN add_product_id smallint(5), add_restock_count smallint(5))
INSERT INTO Restocking
(product_id, restock_count)
VALUES
(add_product_id, add_restock_count)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_ShoppingCartItem
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_ShoppingCartItem`(IN add_customer_id smallint(5), IN add_product_source smallint(5), IN add_product_id smallint(5))
INSERT INTO ShoppingCartItem
(customer_id, product_source, product_id)
VALUES
(add_customer_id, add_product_source, add_product_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Supplier
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Supplier`(IN add_supplier_name varchar(100))
INSERT INTO Supplier (supplier_name) VALUES (add_supplier_name)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Wishlist
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Add_Wishlist`(IN add_customer_id smallint(5), IN add_product_source smallint(5), IN add_product_id smallint(5))
INSERT INTO Wishlist
(customer_id, product_source, product_id)
VALUES
(add_customer_id, add_product_source, add_product_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- function Check_RestockProduct
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Check_RestockProduct`(check_product_id smallint(5)) RETURNS tinyint(1)
BEGIN
	DECLARE inventory smallint(5);
    DECLARE minimum_stock_level smallint(5);
    DECLARE restockYN boolean;
    DECLARE countRestockProductRecords smallint(5);
    SET inventory = Get_Inventory(check_product_id);
    SET minimum_stock_level = Get_MinimumStockLevel(check_product_id);
    SET countRestockProductRecords = Get_RestockProductRecordsCount(check_product_id);
	SET restockYN = IF(countRestockProductRecords = 0 and inventory <= minimum_stock_level,1,0);
	RETURN restockYN;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Decrement_Inventory_Product
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Decrement_Inventory_Product`(IN get_product_id smallint(5), IN get_quantity smallint(5))
UPDATE Product SET inventory = inventory - get_quantity where product_id = get_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_CategoryByCategoryID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_CategoryByCategoryID`(IN delete_category_id smallint(5))
BEGIN
	CALL Delete_ProductCategoryByCategoryID(delete_category_id);
    DELETE FROM Category WHERE category_id = delete_category_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_CustomerByCustomerID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_CustomerByCustomerID`(IN delete_customer_id smallint(5))
BEGIN
	CALL Delete_PurchaseOrderByCustomerID(delete_customer_id);
    CALL Delete_RatingByCustomerID(delete_customer_id);
	CALL Delete_ShoppingCartItemByCustomerID(delete_customer_id);
    CALL Delete_WishlistByCustomerID(delete_customer_id);
	DELETE FROM Customer WHERE customer_id = delete_customer_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Product
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_Product`(IN delete_product_source smallint(5), IN delete_product_id smallint(5))
BEGIN
	CALL Delete_ProductCategoryByProductSourceAndProductID (delete_product_id);
    CALL Delete_PurchaseOrderProductByProductSourceAndProductID (delete_product_source, delete_product_id);
    CALL Delete_RatingByProductSourceAndProductID (delete_product_source, delete_product_id);
    CALL Delete_ShoppingCartItemByProductSourceAndProductID (delete_product_source, delete_product_id);
    CALL Delete_WishlistByProductSourceAndProductID (delete_product_source, delete_product_id);
	DELETE FROM Product WHERE product_id = delete_product_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ProductBySupplierID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ProductBySupplierID`(IN delete_supplier_id smallint(5))
DELETE FROM Product where supplier_id = delete_supplier_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ProductCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ProductCategory`(IN delete_product_source smallint(5), delete_product_id smallint(5), delete_category_id smallint(5))
DELETE FROM Product_Category WHERE product_source = delete_product_source and product_id = delete_product_id and category_id = delete_category_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ProductCategoryByCategoryID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ProductCategoryByCategoryID`(IN delete_category_id smallint(5))
DELETE FROM Product_Category WHERE category_id = delete_category_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ProductCategoryByProductSourceAndProductID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ProductCategoryByProductSourceAndProductID`(IN delete_product_source smallint(5), delete_product_id smallint(5))
DELETE FROM Product_Category
WHERE product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ProductCategoryBySupplierID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ProductCategoryBySupplierID`(IN delete_supplier_id smallint(5))
DELETE FROM Product_Category
WHERE product_id IN
(SELECT product_id FROM Product where supplier_id = delete_supplier_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_PurchaseOrder
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_PurchaseOrder`(IN delete_order_id smallint(5))
DELETE FROM PurchaseOrder where order_id = delete_order_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_PurchaseOrderByCustomerID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_PurchaseOrderByCustomerID`(IN delete_customer_id smallint(5))
BEGIN
	DELETE FROM PurchaseOrder WHERE customer_id = delete_customer_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_PurchaseOrderProduct
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_PurchaseOrderProduct`(IN delete_order_id smallint(5))
DELETE FROM PurchaseOrder_Product where order_id = delete_order_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_PurchaseOrderProductByProductSourceAndProductID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_PurchaseOrderProductByProductSourceAndProductID`(IN delete_product_source smallint(5), IN delete_product_id smallint(5))
DELETE FROM PurchaseOrder_Product
WHERE product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Rating
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_Rating`(IN delete_customer_id smallint(5),
delete_product_source smallint(5), delete_product_id smallint(5))
DELETE FROM Rating WHERE customer_id = delete_customer_id
and  product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_RatingByCustomerID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_RatingByCustomerID`(IN delete_customer_id smallint(5))
DELETE FROM Rating WHERE customer_id = delete_customer_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_RatingByProductSourceAndProductID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_RatingByProductSourceAndProductID`(IN delete_product_source smallint(5), IN delete_product_id smallint(5))
DELETE FROM Rating WHERE product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Restocking
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_Restocking`(IN delete_restock_id smallint(5))
DELETE FROM Restocking WHERE restock_id = delete_restock_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ShoppingCartItem
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ShoppingCartItem`(IN delete_customer_id smallint(5), IN delete_product_source smallint(5), IN delete_product_id smallint(5))
DELETE FROM ShoppingCartItem
WHERE customer_id = delete_customer_id
and product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ShoppingCartItemByCustomerID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ShoppingCartItemByCustomerID`(IN delete_customer_id smallint(5))
DELETE FROM ShoppingCartItem WHERE customer_id = delete_customer_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ShoppingCartItemByProductSourceAndProductID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_ShoppingCartItemByProductSourceAndProductID`(IN delete_product_source smallint(5), IN delete_product_id smallint(5))
DELETE FROM ShoppingCartItem WHERE product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_SupplierBySupplierID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_SupplierBySupplierID`(IN delete_supplier_id smallint(5))
BEGIN
CALL Delete_ProductCategoryBySupplierID(delete_supplier_id);
CALL Delete_ProductBySupplierID(delete_supplier_id);
DELETE FROM Supplier WHERE supplier_id = delete_supplier_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Wishlist
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_Wishlist`(IN delete_customer_id smallint(5), IN delete_product_source smallint(5), IN delete_product_id smallint(5))
DELETE FROM Wishlist
WHERE customer_id = delete_customer_id and product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_WishlistByCustomerID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_WishlistByCustomerID`(IN delete_customer_id smallint(5))
DELETE FROM Wishlist WHERE customer_id = delete_customer_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_WishlistByProductSourceAndProductID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Delete_WishlistByProductSourceAndProductID`(IN delete_product_source smallint(5), IN delete_product_id varchar(50))
DELETE FROM Wishlist WHERE product_source = delete_product_source and product_id = delete_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_CategoryID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_CategoryID`(get_category_name varchar(200)) RETURNS int(11)
BEGIN
	DECLARE result int;
    SET result = (Select category_id FROM Category where category_name = get_category_name);
	RETURN result;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_Inventory
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_Inventory`(get_product_id smallint(5)) RETURNS smallint(5)
RETURN (SELECT inventory FROM Product where product_id = get_product_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_MinimumStockLevel
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_MinimumStockLevel`(get_product_id smallint(5)) RETURNS smallint(5)
RETURN (SELECT minimum_stock_level FROM Product where product_id = get_product_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_MonthlyCount
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_MonthlyCount`(get_product_id int) RETURNS int(11)
BEGIN
	DECLARE quantitySum int;
    SET quantitySum = (SELECT SUM(quantity) FROM PurchaseOrder_Product WHERE product_source = Get_SourceID('Nile') and product_id = get_product_id and created BETWEEN NOW() - INTERVAL 30 DAY AND NOW());
    RETURN quantitySum;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_RestockProductRecordsCount
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_RestockProductRecordsCount`(get_product_id smallint(5)) RETURNS smallint(5)
RETURN (SELECT COUNT(*) FROM Restocking where product_id = get_product_id)$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_ShippingDate
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_ShippingDate`(d datetime) RETURNS datetime
BEGIN
DECLARE result_date datetime;

IF WEEKDAY(d) = 0 || WEEKDAY(d) = 6 THEN
	SET result_date = DATE_ADD(d, INTERVAL 4 DAY);
END IF;
IF WEEKDAY(d) = 1 || WEEKDAY(d) = 2 || WEEKDAY(d) = 3 || WEEKDAY(d) = 4 THEN
	SET result_date = DATE_ADD(d, INTERVAL 6 DAY);
END IF;
IF WEEKDAY(d) = 5 THEN
	SET result_date = DATE_ADD(d, INTERVAL 5 DAY);
END IF;
RETURN result_date;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_SourceID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_SourceID`(get_source_name varchar(50)) RETURNS int(11)
BEGIN
	DECLARE result int;
    SET result = (Select source_id FROM Product_Source where source_name = get_source_name);
	RETURN result;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_SourceName
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_SourceName`(get_source_id int) RETURNS varchar(50) CHARSET latin1
BEGIN
	DECLARE result varchar(50);
    SET result = (Select source_name FROM Product_Source where source_id = get_source_id);
	RETURN result;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function Get_SupplierID
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE FUNCTION `Get_SupplierID`(get_supplier_name varchar(200)) RETURNS int(11)
BEGIN
	DECLARE result int;
    SET result = (Select supplier_id FROM Supplier where supplier_name = get_supplier_name);
	RETURN result;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Search_ProductsByCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Search_ProductsByCategory`(IN get_category_id int)
SELECT * FROM Product_View
WHERE category_id = get_category_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Category
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_Category`(IN update_category_id smallint(5), IN update_category_name varchar(100))
UPDATE Category SET category_name = update_category_name
WHERE category_id = update_category_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Customer
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_Customer`(IN update_customer_id smallint(5),
IN update_first_name varchar(100),
IN update_last_name varchar(100),
IN update_email_address varchar(100),
IN update_is_admin int)
UPDATE Customer SET first_name = update_first_name, last_name = update_last_name,
email_address = update_email_address, is_admin = update_is_admin
where customer_id = update_customer_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Product
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_Product`(IN update_product_id smallint(5),
update_product_name varchar(100),
update_product_description varchar(8000),
update_supplier_id smallint(5),
update_price decimal(18,2),
update_minimum_stock_level int(11),
update_target_units_sold int(11))
UPDATE Product SET
product_name = update_product_name,
product_description = update_product_description,
supplier_id = update_supplier_id,
price = update_price,
minimum_stock_level = update_minimum_stock_level,
target_units_sold = update_target_units_sold
WHERE product_id = update_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_PurchaseOrder
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_PurchaseOrder`(
IN update_order_id smallint(5),
IN update_customer_id smallint(5),
IN update_shipping_date datetime,
IN update_transaction_date datetime)
UPDATE PurchaseOrder
SET customer_id = update_customer_id,
shipping_date = update_shipping_date,
transaction_date = update_transaction_date
WHERE order_id = update_order_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_PurchaseOrderProduct
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_PurchaseOrderProduct`(
IN update_order_id smallint(5),
IN update_product_source smallint(5),
IN update_product_id smallint(5),
IN update_quantity smallint(5))
UPDATE PurchaseOrder_Products
SET quantity = update_quantity
WHERE order_id = update_order_id
and product_source = update_product_source and product_id = update_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Rating
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_Rating`(IN update_customer_id smallint(5), IN update_product_source smallint(5), IN update_product_id smallint(5), IN update_rating smallint(5))
Update Rating
SET rating = update_rating
WHERE customer_id = update_customer_id and product_source = update_product_source and product_id = update_product_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Restocking
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_Restocking`(IN update_restock_id smallint(5), IN update_product_id smallint(5), update_restock_count smallint(5))
UPDATE Restocking
SET product_id = update_product_id,
restock_count = update_restock_count
WHERE restock_id = update_restock_id$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Supplier
-- -----------------------------------------------------

DELIMITER $$
USE `nile`$$
CREATE PROCEDURE `Update_Supplier`(IN update_supplier_id smallint(5), IN update_supplier_name varchar(100))
UPDATE Supplier SET supplier_name = update_supplier_name WHERE supplier_id = update_supplier_id$$

DELIMITER ;

-- -----------------------------------------------------
-- View `nile`.`Customer_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`Customer_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`Customer_View` AS select `nile`.`Customer`.`customer_id` AS `customer_id`,`nile`.`Customer`.`first_name` AS `first_name`,`nile`.`Customer`.`last_name` AS `last_name`,`nile`.`Customer`.`email_address` AS `email_address`,`nile`.`Customer`.`is_admin` AS `is_admin`,'Nile' AS `source`,`GET_SOURCEID`('Nile') AS `source_id` from `nile`.`Customer` union select `sakila`.`customer`.`customer_id` AS `customer_id`,`sakila`.`customer`.`first_name` AS `first_name`,`sakila`.`customer`.`last_name` AS `last_name`,`sakila`.`customer`.`email` AS `email`,0 AS `0`,'Sakila' AS `sakila`,`GET_SOURCEID`('Sakila') AS `GET_SOURCEID('sakila')` from `sakila`.`customer` union select `northwind`.`customers`.`id` AS `id`,`northwind`.`customers`.`first_name` AS `first_name`,`northwind`.`customers`.`last_name` AS `last_name`,`northwind`.`customers`.`email_address` AS `email_address`,0 AS `0`,'Northwind' AS `northwind`,`GET_SOURCEID`('Northwind') AS `GET_SOURCEID('northwind')` from `northwind`.`customers` union select `t`.`CustomerID` AS `CustomerID`,`t`.`firstname` AS `firstname`,`t`.`lastname` AS `lastname`,`t`.`emailaddress` AS `emailaddress`,0 AS `0`,'Adventureworks' AS `adventureworks`,`GET_SOURCEID`('Adventureworks') AS `GET_SOURCEID('adventureworks')` from (select `adventureworks`.`individual`.`CustomerID` AS `CustomerID`,`adventureworks`.`contact`.`FirstName` AS `firstname`,`adventureworks`.`contact`.`LastName` AS `lastname`,`adventureworks`.`contact`.`EmailAddress` AS `emailaddress` from ((`adventureworks`.`contact` join `adventureworks`.`individual` on((`adventureworks`.`contact`.`ContactID` = `adventureworks`.`individual`.`ContactID`))) join `adventureworks`.`customer` on((`adventureworks`.`individual`.`CustomerID` = `adventureworks`.`customer`.`CustomerID`)))) `t`;

-- -----------------------------------------------------
-- View `nile`.`MinimumStockLevelProducts_Report_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`MinimumStockLevelProducts_Report_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`MinimumStockLevelProducts_Report_View` AS select `nile`.`Product`.`product_id` AS `product_id`,`nile`.`Product`.`product_name` AS `product_name`,`nile`.`Product`.`price` AS `price`,`nile`.`Product`.`inventory` AS `inventory`,`nile`.`Product`.`minimum_stock_level` AS `minimum_stock_level` from `nile`.`Product` where (`nile`.`Product`.`inventory` < `nile`.`Product`.`minimum_stock_level`);

-- -----------------------------------------------------
-- View `nile`.`NotSellingTooWell_Products_Report_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`NotSellingTooWell_Products_Report_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`NotSellingTooWell_Products_Report_View` AS select `nile`.`Product`.`product_id` AS `product_id`,`nile`.`Product`.`product_name` AS `product_name`,`nile`.`Product`.`target_units_sold` AS `target_units_sold`,`GET_MONTHLYCOUNT`(`nile`.`Product`.`product_id`) AS `monthly_count` from `nile`.`Product` where (`nile`.`Product`.`target_units_sold` > `GET_MONTHLYCOUNT`(`nile`.`Product`.`product_id`));

-- -----------------------------------------------------
-- View `nile`.`NotTooActive_Customers_Report_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`NotTooActive_Customers_Report_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`NotTooActive_Customers_Report_View` AS select `c`.`customer_id` AS `customer_id` from `nile`.`Customer` `c` where ((select max(`p`.`transaction_date`) from `nile`.`PurchaseOrder` `p` where (`c`.`customer_id` = `p`.`customer_id`)) <= (now() + interval -(30) day));

-- -----------------------------------------------------
-- View `nile`.`Product_Inventory_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`Product_Inventory_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`Product_Inventory_View` AS select `nile`.`Product`.`product_id` AS `product_id`,`nile`.`Product`.`product_name` AS `product_name`,`nile`.`Product`.`inventory` AS `inventory` from `nile`.`Product`;

-- -----------------------------------------------------
-- View `nile`.`Product_Total_Count_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`Product_Total_Count_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`Product_Total_Count_View` AS select `nile`.`PurchaseOrder_Product`.`product_source` AS `product_source`,`nile`.`PurchaseOrder_Product`.`product_id` AS `product_id`,sum(`nile`.`PurchaseOrder_Product`.`quantity`) AS `COUNT` from `nile`.`PurchaseOrder_Product` group by `nile`.`PurchaseOrder_Product`.`product_source`,`nile`.`PurchaseOrder_Product`.`product_id`;

-- -----------------------------------------------------
-- View `nile`.`Product_View`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nile`.`Product_View`;
USE `nile`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `nile`.`Product_View` AS select `nile`.`Product`.`product_id` AS `product_id`,`nile`.`Product`.`product_name` AS `product_name`,`nile`.`Product`.`product_description` AS `product_description`,`nile`.`Product`.`supplier_id` AS `supplier_id`,`nile`.`Product`.`price` AS `price`,`nile`.`Category`.`category_name` AS `category`,`nile`.`Category`.`category_id` AS `category_id`,'Nile' AS `source_name`,`GET_SOURCEID`('Nile') AS `source_id` from ((`nile`.`Product` join `nile`.`Product_Category` on(((`nile`.`Product`.`product_id` = `nile`.`Product_Category`.`product_id`) and (`nile`.`Product_Category`.`product_source` = `GET_SOURCEID`('Nile'))))) join `nile`.`Category` on((`nile`.`Product_Category`.`category_id` = `nile`.`Category`.`category_id`))) union select `sakila`.`film`.`film_id` AS `film_id`,`sakila`.`film`.`title` AS `title`,`sakila`.`film`.`description` AS `description`,`GET_SUPPLIERID`('Sakila') AS `GET_SUPPLIERID('Sakila')`,`sakila`.`film`.`rental_rate` AS `rental_rate`,`nile`.`Category`.`category_name` AS `category`,`nile`.`Category`.`category_id` AS `category_id`,'Sakila' AS `sakila`,`GET_SOURCEID`('Sakila') AS `Get_SourceID ('sakila')` from ((`sakila`.`film` join `nile`.`Product_Category` on(((`sakila`.`film`.`film_id` = `nile`.`Product_Category`.`product_id`) and (`nile`.`Product_Category`.`product_source` = `GET_SOURCEID`('Sakila'))))) join `nile`.`Category` on((`nile`.`Product_Category`.`category_id` = `nile`.`Category`.`category_id`))) union select `northwind`.`products`.`id` AS `id`,`northwind`.`products`.`product_name` AS `product_name`,`northwind`.`products`.`description` AS `description`,`GET_SUPPLIERID`('Northwind') AS `GET_SUPPLIERID('Northwind')`,`northwind`.`products`.`list_price` AS `list_price`,`nile`.`Category`.`category_name` AS `category`,`nile`.`Category`.`category_id` AS `category_id`,'Northwind' AS `northwind`,`GET_SOURCEID`('Northwind') AS `Get_SourceID('northwind')` from ((`northwind`.`products` join `nile`.`Product_Category` on(((`northwind`.`products`.`id` = `nile`.`Product_Category`.`product_id`) and (`nile`.`Product_Category`.`product_source` = `GET_SOURCEID`('Northwind'))))) join `nile`.`Category` on((`nile`.`Product_Category`.`category_id` = `nile`.`Category`.`category_id`))) union select `adventureworks`.`product`.`ProductID` AS `ProductId`,`adventureworks`.`product`.`Name` AS `Name`,NULL AS `NULL`,`GET_SUPPLIERID`('Adventureworks') AS `GET_SUPPLIERID('Adventureworks')`,`adventureworks`.`product`.`ListPrice` AS `ListPrice`,`nile`.`Category`.`category_name` AS `category`,`nile`.`Category`.`category_id` AS `category_id`,'Adventureworks' AS `adventureworks`,`GET_SOURCEID`('Adventureworks') AS `Get_SourceID('adventureworks')` from ((`adventureworks`.`product` join `nile`.`Product_Category` on(((`adventureworks`.`product`.`ProductID` = `nile`.`Product_Category`.`product_id`) and (`nile`.`Product_Category`.`product_source` = `GET_SOURCEID`('Adventureworks'))))) join `nile`.`Category` on((`nile`.`Product_Category`.`category_id` = `nile`.`Category`.`category_id`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `nile`;

DELIMITER $$
USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Category`
BEFORE UPDATE ON `nile`.`Category`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Customer`
BEFORE UPDATE ON `nile`.`Customer`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Supplier`
BEFORE UPDATE ON `nile`.`Supplier`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Product`
BEFORE UPDATE ON `nile`.`Product`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Product_Category`
BEFORE UPDATE ON `nile`.`Product_Category`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_PurchaseOrder`
BEFORE UPDATE ON `nile`.`PurchaseOrder`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_AfterInsert_PurchaseOrder_Product`
AFTER INSERT ON `nile`.`PurchaseOrder_Product`
FOR EACH ROW
BEGIN
	IF New.product_source = Get_SourceID('Nile') THEN
		BEGIN
			CALL Decrement_Inventory_Product(NEW.product_id, NEW.quantity);
		END;
		BEGIN
			DECLARE check_product_restock boolean;
			SET check_product_restock = Check_RestockProduct(NEW.product_id);
			IF check_product_restock = 1 THEN
				CALL Add_Restocking(NEW.product_id, Get_MinimumStockLevel(New.product_id));
			END IF;
		END;
    END IF;
END$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_PurchaseOrder_Product`
BEFORE UPDATE ON `nile`.`PurchaseOrder_Product`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Rating`
BEFORE UPDATE ON `nile`.`Rating`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Restocking`
BEFORE UPDATE ON `nile`.`Restocking`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_ShoppingCartItem`
BEFORE UPDATE ON `nile`.`ShoppingCartItem`
FOR EACH ROW
SET NEW.last_modified = NOW()$$

USE `nile`$$
CREATE
TRIGGER `nile`.`Trigger_BeforeUpdate_Wishlist`
BEFORE UPDATE ON `nile`.`Wishlist`
FOR EACH ROW
SET NEW.last_modified = NOW()$$


DELIMITER ;
