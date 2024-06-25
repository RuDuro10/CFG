CREATE DATABASE IF NOT EXISTS ClothingStoreManagement;
USE ClothingStoreManagement;
-- Table: ClothingItems
CREATE TABLE IF NOT EXISTS ClothingItems (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    ItemType ENUM('Shirt', 'Pants', 'Dress', 'Shoes') NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(8, 2) NOT NULL,
    Size VARCHAR(10),
    Color VARCHAR(50),
    Material VARCHAR(100),
    CONSTRAINT CHK_Price CHECK (Price > 0)
);
-- Table: RemainingStock
CREATE TABLE IF NOT EXISTS RemainingStock (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ItemCount INT NOT NULL
);
-- Table: Customers
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    MembershipID VARCHAR(20) UNIQUE,
    PointsCollected INT DEFAULT 0
);
-- Insert mock data into ClothingItems table
INSERT INTO ClothingItems (ItemType, Name, Price, Size, Color, Material)
VALUES
    ('Shirt', 'Striped T-Shirt', 19.99, 'M', 'Blue/White', 'Cotton'),
    ('Pants', 'Jeans', 39.99, '32x32', 'Blue', 'Denim'),
    ('Dress', 'Floral Sundress', 29.99, 'S', 'Pink', 'Polyester');
-- Insert mock data into RemainingStock table
INSERT INTO RemainingStock (Name, ItemCount)
VALUES
    ('Cotton', 100),
    ('Denim', 50),
    ('Polyester', 80);
-- Insert mock data into Customers table
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, MembershipID)
VALUES
    ('Michael', 'Brown', 'michael@example.com', '07856743223', 'MEM001'),
    ('Emma', 'Davis', 'emma@example.com', '07856745367', 'MEM002');
-- Add a new item to the store
INSERT INTO ClothingItems (ItemType, Name, Price, Size, Color, Material)
VALUES ('Shoes', 'Sneakers', 49.99, '10', 'White', 'Canvas');
-- Retrieve all clothing items sorted by name
SELECT * FROM ClothingItems ORDER BY Name;
-- Retrieve customer information for a specific email
SELECT * FROM Customers WHERE Email = 'michael@example.com';
-- Delete an item from the ClothingItems table
DELETE FROM ClothingItems WHERE Name = 'Striped T-Shirt';
-- Calculate the total price of all items in stock
SELECT SUM(Price * ItemCount) AS TotalValue FROM ClothingItems JOIN RemainingStock ON ClothingItems.ItemID = RemainingStock.ItemID;
-- Count the number of items in each category
SELECT ItemType, COUNT(*) AS NumItems FROM ClothingItems GROUP BY ItemType;
-- Join ClothingItems and RemainingStock table to get stock information along with item details
SELECT c.Name AS ItemName, r.ItemCount
FROM ClothingItems c
JOIN RemainingStock r ON c.ItemID = r.ItemID;
-- Retrieve the highest priced item
SELECT * FROM ClothingItems WHERE Price = (SELECT MAX(Price) FROM ClothingItems);
-- Retrieve the number of customers in each city
SELECT City, COUNT(*) AS NumCustomers FROM Customers GROUP BY City;
DELIMITER //
CREATE PROCEDURE RegisterCustomer (
    IN firstName VARCHAR(50),
    IN lastName VARCHAR(50),
    IN email VARCHAR(100),
    IN phone VARCHAR(15),
    IN membershipID VARCHAR(20)
)
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, MembershipID)
    VALUES (firstName, lastName, email, phone, membershipID);
END //
DELIMITER ;
-- A new customer registers
CALL RegisterCustomer('Sophia', 'Johnson', 'sophia@example.com', '079578987654', 'MEM003');
-- Michael purchases a pair of Jeans
INSERT INTO Purchases (CustomerID, ItemID, Quantity, Total)
VALUES (1, 2, 1, 39.99);
-- Emma purchases a Floral Sundress
INSERT INTO Purchases (CustomerID, ItemID, Quantity, Total)
VALUES (2, 3, 1, 29.99);
