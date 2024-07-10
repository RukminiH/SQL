-- CREATE A NEW DATABASE customer_order_management
DROP DATABASE IF EXISTS customer_order_management;
CREATE DATABASE customer_order_management;
USE customer_order_management;

-- CREATE TABLE 
DROP TABLE IF EXISTS customer_order_management.customers;
CREATE TABLE customer_order_management.customers
(
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NULL,
    last_name VARCHAR(50) NULL,
    country VARCHAR(50) NULL,
    score INT,
    PRIMARY KEY (customer_id)
);

-- INSERT CUSTOMER DATA
INSERT INTO customer_order_management.customers VALUES (1, 'Maria', 'Cramer', 'Germany', 350);
INSERT INTO customer_order_management.customers VALUES (2, 'John', 'Steel', 'USA', 900);
INSERT INTO customer_order_management.customers VALUES (3, 'Georg', 'Muller', 'Germany', 500);
INSERT INTO customer_order_management.customers VALUES (4, 'Martin', 'Pipps', 'UK', 750);
INSERT INTO customer_order_management.customers VALUES (5, 'Peter', 'Frankin', 'USA', NULL);

-- CREATE TABLE ORDERS
DROP TABLE IF EXISTS customer_order_management.orders;
CREATE TABLE customer_order_management.orders
(
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NULL,
    quantity INT NULL,
    PRIMARY KEY (order_id)
);

-- INSERT ORDER DATA
INSERT INTO customer_order_management.orders VALUES (1001, 1, '2021-01-11', 250);
INSERT INTO customer_order_management.orders VALUES (1002, 2, '2021-04-05', 1150);
INSERT INTO customer_order_management.orders VALUES (1003, 3, '2021-06-18', 500);
INSERT INTO customer_order_management.orders VALUES (1004, 6, '2021-08-31', 750);

-- CREATE TABLE EMPLOYEE
DROP TABLE IF EXISTS customer_order_management.employees;
CREATE TABLE customer_order_management.employees
(
    emp_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    emp_country VARCHAR(50) NULL,
    salary INT NULL,
    PRIMARY KEY (emp_id)
);

-- INSERT EMPLOYEES DATA
INSERT INTO customer_order_management.employees VALUES (1, 'John', 'Steel', 'USA', 55000);
INSERT INTO customer_order_management.employees VALUES (2, 'Ann', 'Labrune', 'France', 75000);
INSERT INTO customer_order_management.employees VALUES (3, 'Marie', 'Bertrand', 'Brazil', 75000);
INSERT INTO customer_order_management.employees VALUES (4, 'Georg', 'Afonso', 'UK', 75000);
INSERT INTO customer_order_management.employees VALUES (5, 'Marie', 'Steel', 'UK', 75000);

-- USE DATABASE customer_order_management;
-- RETRIEVE ALL DATA AND COLUMNS FROM CUSTOMERS
SELECT * 
FROM customers;

SELECT * 
FROM employees;

SELECT * 
FROM orders;

-- RETRIEVE ONLY FIRST NAME AND COUNTRY OF ALL CUSTOMERS
SELECT
    first_name,
    country
FROM customers;

-- HOW TO RETRIEVE UNIQUE VALUES USING DISTINCT
-- NOTE: as default SELECT doesn't remove duplicate in the result
-- DISTINCT: remove duplicates data in the result set
-- LIST ALL COUNTRIES OF ALL CUSTOMERS WITHOUT DUPLICATES
SELECT DISTINCT
    country
FROM customers;

-- NOTE: as default SELECT doesn't order the result in any order
-- ORDER BY: sorts the result in a particular order
-- Retrieve all customers where the result is sorted by score (smallest first)
SELECT *
FROM customers
ORDER BY score ASC;

-- Retrieve all customers where the result is sorted by score (highest first)
SELECT *
FROM customers
ORDER BY score DESC;

-- Retrieve all customers, sorting the result by country (alphabetically means asc) and then by score (highest first)
SELECT *
FROM customers
ORDER BY country ASC, score DESC;

-- OR

SELECT *
FROM customers
ORDER BY 4 ASC, 5 DESC;

-- Note: Avoid using numbers in ORDER BY; it is better to use the names of columns

-- Filtering Data
-- WHERE: filters rows based on specified conditions
-- List ONLY German customers
SELECT *
FROM customers
WHERE country = 'Germany';

-- FIND ALL CUSTOMERS WHOSE SCORE IS HIGHER THAN 500
SELECT *
FROM customers
WHERE score > 500;

-- SQL Comparison Operators (=, >, <, >=, <=, !=)
-- Comparison operators: compare two values and return TRUE and FALSE
-- Find all customers whose score is less than 500
SELECT * 
FROM customers
WHERE score < 500;

-- Find all customers whose score is less than or equal to 500
SELECT *
FROM customers
WHERE score <= 500;

-- Find all customers whose score is higher than or equal to 500
SELECT *
FROM customers
WHERE score >= 500;

SELECT *
FROM customers
WHERE country != 'Germany';

-- SQL Logical Operators (AND | OR | NOT)
-- SQL - AND
-- Find all customers who come from Germany AND whose score is less than 400
SELECT * 
FROM customers
WHERE country = 'Germany' 
AND score < 400;

-- SQL - OR Operator
-- Find all customers who come from Germany OR whose score is less than 400
SELECT * 
FROM customers
WHERE country = 'Germany'
OR score < 400;

-- SQL - NOT Operators
-- Find all customers whose score is NOT less than 400
-- NOTE: reverses the result of any Boolean Operators
SELECT *
FROM customers
WHERE NOT score < 400;

-- SQL BETWEEN 
-- Find all customers whose score falls in the range between 100 and 500.
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

-- OR
SELECT *
FROM customers
WHERE score >= 100 AND score <= 500;

-- NOTE: Instead of using BETWEEN, use >= AND <=

-- SQL IN
-- Find all customers whose ID is equal to 1, 2, or 5
SELECT *
FROM customers
WHERE customer_id 
IN (1, 2, 5);

-- OR
SELECT * 
FROM customers
WHERE customer_id = 1
OR customer_id = 2
OR customer_id = 5;

-- SQL LIKE
-- Find all customers whose first name starts with M
SELECT * 
FROM customers
WHERE first_name 
LIKE 'M%';

-- Find all customers whose first name ends with N
SELECT *
FROM customers
WHERE first_name 
LIKE '%n';

-- Find all customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name
LIKE '%r%';

-- Find all customers whose first name contains 'r' in the 3rd position
SELECT * 
FROM customers
WHERE first_name
LIKE '__R%';

-- JOIN DATA
-- SQL JOINS
-- SQL ALIASES
-- Aliases: Specifies a short alias name for a table or a column.
SELECT
    c.customer_id AS cid
FROM customers AS c;

-- SQL INNER JOIN
-- List customer ID, first name, order ID, quantity. Exclude the customers who have not placed any orders
-- INNER JOIN: Returns ONLY the matching rows
SELECT 
    c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- LEFT JOIN
-- LIST customer ID, first name, order ID, quantity. Include the customers who have not placed any orders
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

-- RIGHT JOIN
-- LIST customer ID, first name, order ID, quantity. Include all orders, regardless of whether there is a matching customer
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

-- FULL JOIN
-- List customer ID, first name, order ID, quantity. Include everything! All customers and all orders
-- NOTE: FULL JOIN is not supported in MySQL
-- AVOID using FULL JOINs, it is harmful and causes performance problems
SELECT
    c.customer_id,
    c.first_name,
    o.customer_id,
    o.quantity
FROM customers AS c
FULL JOIN orders AS o
ON c.customer_id = o.customer_id;

-- OR
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
UNION
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

-- SQL UNION
-- UNION: combines the ROWS from both tables
-- List first name, last name, and country of all persons from customers and employees
-- In the query, both tables must have exactly the same number of columns and in the same order
-- UNION ALL: combines the ROWS WITHOUT removing duplicates
SELECT
    first_name,
    last_name,
    country
FROM customers
UNION ALL
SELECT
    first_name,
    last_name,
    emp_country
FROM employees;

-- UNION
SELECT
    first_name,
    last_name,
    country
FROM customers
UNION
SELECT
    first_name,
    last_name,
    emp_country
