-- Sql 1 project 


-- =====================================================
--               DATA DIGGER SQL PROJECT
-- =====================================================

-- STEP 1: CREATE DATABASE

CREATE DATABASE DataDigger;
USE DataDigger;


-- STEP 2: CREATE TABLES


-- 1. Customers Table

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

-- 

-- 2. Orders Table

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

-- -----------------------------------------------------

-- 3. Products Table

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

-- -----------------------------------------------------

-- 4. OrderDetails Table

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

-- =====================================================
-- STEP 3: INSERT SAMPLE DATA
-- =====================================================

-- Customers Data

INSERT INTO Customers (Name, Email, Address)
VALUES
('Alice', 'alice@gmail.com', 'Delhi'),
('Bob', 'bob@gmail.com', 'Mumbai'),
('Charlie', 'charlie@gmail.com', 'Jaipur'),
('David', 'david@gmail.com', 'Udaipur'),
('Emma', 'emma@gmail.com', 'Pune');

-- -----------------------------------------------------

-- Orders Data

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2026-05-01', 2500.00),
(2, '2026-05-05', 1500.00),
(3, '2026-05-10', 3000.00),
(1, '2026-05-15', 4500.00),
(4, '2026-05-20', 1200.00);

-- -----------------------------------------------------

-- Products Data

INSERT INTO Products (ProductName, Price, Stock)
VALUES
('Laptop', 55000, 10),
('Mobile', 20000, 15),
('Keyboard', 1000, 30),
('Mouse', 500, 50),
('Headphones', 2500, 20);

-- -----------------------------------------------------

-- OrderDetails Data

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal)
VALUES
(1, 1, 1, 55000),
(2, 2, 1, 20000),
(3, 5, 2, 5000),
(4, 3, 3, 3000),
(5, 4, 2, 1000);

-- =====================================================
-- STEP 4: CUSTOMERS TABLE QUERIES
-- =====================================================

-- Retrieve all customer details

SELECT * FROM Customers;

-- -----------------------------------------------------

-- Update customer address

UPDATE Customers
SET Address = 'Bangalore'
WHERE CustomerID = 2;

-- -----------------------------------------------------

-- Delete customer using CustomerID

DELETE FROM Customers
WHERE CustomerID = 5;

-- -----------------------------------------------------

-- Display customers whose name is Alice

SELECT * FROM Customers
WHERE Name = 'Alice';

-- =====================================================
-- STEP 5: ORDERS TABLE QUERIES
-- =====================================================

-- Retrieve all orders made by a specific customer

SELECT * FROM Orders
WHERE CustomerID = 1;

-- -----------------------------------------------------

-- Update an order's total amount

UPDATE Orders
SET TotalAmount = 5000
WHERE OrderID = 2;

-- -----------------------------------------------------

-- Delete an order using OrderID

DELETE FROM Orders
WHERE OrderID = 5;

-- -----------------------------------------------------

-- Retrieve orders placed in the last 30 days

SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

-- -----------------------------------------------------

-- Retrieve highest, lowest, and average order amount

SELECT
MAX(TotalAmount) AS HighestOrder,
MIN(TotalAmount) AS LowestOrder,
AVG(TotalAmount) AS AverageOrder
FROM Orders;

-- =====================================================
-- STEP 6: PRODUCTS TABLE QUERIES
-- =====================================================

-- Retrieve all products sorted by price descending

SELECT * FROM Products
ORDER BY Price DESC;

-- -----------------------------------------------------

-- Update the price of a specific product

UPDATE Products
SET Price = 22000
WHERE ProductID = 2;



-- Delete a product if it is out of stock

DELETE FROM Products
WHERE Stock = 0;



-- Retrieve products whose price is between 500 and 2000

SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;



-- Retrieve the most expensive and cheapest product

SELECT
MAX(Price) AS MostExpensive,
MIN(Price) AS Cheapest
FROM Products;


-- STEP 7: ORDERDETAILS TABLE QUERIES


-- Retrieve all order details for a specific order

SELECT * FROM OrderDetails
WHERE OrderID = 1;



-- Calculate total revenue generated from all orders

SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;



-- Retrieve top 3 most ordered products

SELECT ProductID,
SUM(Quantity) AS TotalOrdered
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;



-- Count how many times each product has been sold

SELECT ProductID,
COUNT(*) AS TimesSold
FROM OrderDetails
GROUP BY ProductID;


-- STEP 8: JOIN QUERIES


-- Customer Order Details

SELECT
Customers.Name,
Orders.OrderID,
Orders.TotalAmount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;



-- Product Order Details

SELECT
Products.ProductName,
OrderDetails.Quantity
FROM Products
INNER JOIN OrderDetails
ON Products.ProductID = OrderDetails.ProductID;

-- -----------------------------------------------------

-- Complete Order Report

SELECT
Customers.Name,
Orders.OrderID,
Products.ProductName,
OrderDetails.Quantity,
OrderDetails.SubTotal
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON Products.ProductID = OrderDetails.ProductID;


-- STEP 9: DISPLAY ALL TABLE DATA


SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT * FROM Products;

SELECT * FROM OrderDetails;


-- STEP 10: DROP TABLES (OPTIONAL)

DROP TABLE OrderDetails;
DROP TABLE Orders;
DROP TABLE Products;
DROP TABLE Customers;

