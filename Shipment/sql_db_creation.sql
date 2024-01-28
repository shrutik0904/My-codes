create schema shipments;
CREATE TABLE shipments.Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);


INSERT INTO shipments.Products (ProductID, ProductName, UnitPrice)
VALUES
    (1, 'Laptop', 800.00),
    (2, 'Smartphone', 500.00),
    (3, 'Printer', 200.00),
    (4, 'Tablet', 300.00),
    (5, 'Camera', 700.00),
    (6, 'Headphones', 100.00),
    (7, 'Monitor', 250.00),
    (8, 'Mouse', 20.00),
    (9, 'Keyboard', 30.00),
    (10, 'Speaker', 80.00);


CREATE TABLE shipments.Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL
);


INSERT INTO shipments.Suppliers (SupplierID, SupplierName)
VALUES
    (1, 'ABC Electronics'),
    (2, 'XYZ Tech'),
    (3, 'Tech Solutions'),
    (4, 'Gadget World'),
    (5, 'Global Gadgets'),
    (6, 'Electro Supplies'),
    (7, 'Tech Innovators'),
    (8, 'Digital Hub'),
    (9, 'Future Devices'),
    (10, 'Innovative Tech');


CREATE TABLE shipments.Warehouses (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);


INSERT INTO shipments.Warehouses (WarehouseID, WarehouseName, Location)
VALUES
    (1, 'Warehouse A', 'City A'),
    (2, 'Warehouse B', 'City B'),
    (3, 'Warehouse C', 'City C'),
    (4, 'Warehouse D', 'City D'),
    (5, 'Warehouse E', 'City E'),
    (6, 'Warehouse F', 'City F'),
    (7, 'Warehouse G', 'City G'),
    (8, 'Warehouse H', 'City H'),
    (9, 'Warehouse I', 'City I'),
    (10, 'Warehouse J', 'City J');


CREATE TABLE shipments.Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES shipments.Products(ProductID)
);


INSERT INTO shipments.Orders (OrderID, ProductID, Quantity, OrderDate)
VALUES
    (1, 1, 5, '2024-01-15'),
    (2, 3, 2, '2024-01-16'),
    (3, 5, 3, '2024-01-18'),
    (4, 8, 10, '2024-01-20'),
    (5, 2, 7, '2024-01-22'),
    (6, 6, 4, '2024-01-25'),
    (7, 10, 6, '2024-01-26'),
    (8, 4, 8, '2024-01-28'),
    (9, 7, 3, '2024-01-30'),
    (10, 9, 5, '2024-02-01');


CREATE TABLE shipments.Shipments (
    ShipmentID INT PRIMARY KEY,
    OrderID INT,
    SupplierID INT,
    WarehouseID INT,
    ShipmentDate DATE NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES shipments.Orders(OrderID),
    FOREIGN KEY (SupplierID) REFERENCES shipments.Suppliers(SupplierID),
    FOREIGN KEY (WarehouseID) REFERENCES shipments.Warehouses(WarehouseID)
);


INSERT INTO shipments.Shipments (ShipmentID, OrderID, SupplierID, WarehouseID, ShipmentDate)
VALUES
    (1, 1, 1, 3, '2024-01-20'),
    (2, 2, 4, 7, '2024-01-21'),
    (3, 3, 2, 5, '2024-01-23'),
    (4, 4, 7, 1, '2024-01-24'),
    (5, 5, 9, 9, '2024-01-27'),
    (6, 6, 3, 2, '2024-01-29'),
    (7, 7, 6, 4, '2024-02-02'),
    (8, 8, 8, 10, '2024-02-04'),
    (9, 9, 5, 6, '2024-02-06'),
    (10, 10, 10, 8, '2024-02-08');
    
    
    
    ------------------------------------------------------------------
    
  