-- create the database
DROP DATABASE IF EXISTS nile;
CREATE DATABASE nile;

-- select the database
USE nile;

-- create the tables
CREATE TABLE customers (
  id              INT           NOT NULL    AUTO_INCREMENT,
  first_name      VARCHAR(50)   NOT NULL,
  last_name       VARCHAR(50)   NOT NULL,
  email_address   VARCHAR(50)   NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE addresses (
  id                INT           NOT NULL   AUTO_INCREMENT,
  street            VARCHAR(50)   NOT NULL,
  city              VARCHAR(50)   NOT NULL,
  state_province    VARCHAR(2)    NOT NULL,
  country           VARCHAR(2)    NOT NULL,
  zip               VARCHAR(5)    NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE customer_addresses (
  customer_id   INT       NOT NULL,
  address_id    INT       NOT NULL,
  is_billing    BOOLEAN,
  is_shipping   BOOLEAN,
  PRIMARY KEY (customer_id, address_id)
);

-- insert rows into the tables
INSERT INTO customers VALUES
(1, 'gene', 'koval', 'kovale8@students.rowan.edu');

INSERT INTO addresses VALUES
(1, '151 hello world avenue', 'sewell', 'nj', 'us', '08080');

INSERT INTO customer_addresses VALUES
(1, 1, TRUE, TRUE);
