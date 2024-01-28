  -- solution
    -- Write a query to find the total quantity shipped for each product category. 
select o.ProductID,p.ProductName, sum(quantity) as total_shipment 
from shipments.Orders o
left join shipments.products p
on o.ProductID = p.ProductID
group by 1,2;


-- Identify warehouses with the most efficient shipping processes based on average shipping times.
select w.WarehouseID, w.WarehouseName,avg(DATEDIFF(s.ShipmentDate, o.OrderDate)) as avg_shipping_time from shipments.Warehouses w
left join shipments.Shipments s 
on w.WarehouseID = s.WarehouseID
left join
shipments.Orders o 
on s.OrderID = o.OrderID
group by w.WarehouseID, w.WarehouseName
order by avg_shipping_time ASC;


-- Calculate the total value of shipments for each supplier.


-- Calculate the total value of shipments for each supplier.
select s.SupplierID, su.SupplierName,SUM(p.UnitPrice * o.Quantity) AS total_shipment_value from shipments.Shipments s
join shipments.Orders o 
on s.OrderID = o.OrderID
join shipments.Products p 
on o.ProductID = p.ProductID
join shipments.Suppliers su 
on s.SupplierID = su.SupplierID
group by s.SupplierID, su.SupplierName
ORDER BY total_shipment_value DESC;

-- Retrieve the top 5 products with the highest total shipment quantities.
select * from 
(  
select ProductID, ProductName,total_quantity, row_number()over(order by total_quantity desc) as sequence
from 
(
select o.ProductID,p.ProductName, sum(quantity) as total_quantity from shipments.Orders o
left join shipments.Products p
on o.ProductID = p.ProductID
group by 1,2
order by 2 desc) a
) b
where sequence<=5;

-- Create a report showing the distribution of shipment values for each product category.
select p.ProductID, p.ProductName,count(s.ShipmentID) AS total_shipments, sum(p.UnitPrice * o.Quantity) AS total_shipment_value
from shipments.Products p
join shipments.Orders o 
on p.ProductID = o.ProductID
join shipments.Shipments s 
on o.OrderID = s.OrderID
group by 1,2
order by p.ProductName, total_shipment_value DESC;



-----------------------------------


-- Identify suppliers with a significant increase or decrease in shipment values compared to the previous year.
SELECTs.SupplierID,su.SupplierName,
    sum(case when year(s.ShipmentDate) = year(curdate()) then p.UnitPrice * o.Quantity else 0 end) AS current_year_value,
    sum(case when year(s.ShipmentDate) = year(curdate()) - 1 then p.UnitPrice * o.Quantity else 0 end) AS previous_year_value,
    (sum(case when year(s.ShipmentDate) = year(curdate()) then p.UnitPrice * o.Quantity else 0 end) -
    sum(case when year(s.ShipmentDate) = year(curdate()) - 1 then p.UnitPrice * o.Quantity else 0 end)) AS value_difference
from shipments.Shipments s
left join shipments.Orders o 
on s.OrderID = o.OrderID
left join shipments.Products p 
on o.ProductID = p.ProductID
left join shipments.Suppliers su 
on s.SupplierID = su.SupplierID
where
    YEAR(s.ShipmentDate) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
group by s.SupplierID, su.SupplierName
having abs(value_difference) > 0; 
-------------------------------------------------------------------------------------------------------------------------

-- Create a view for a consolidated summary of shipment and product performance.
CREATE VIEW shipments.ShipmentPerformanceSummary AS
SELECT p.ProductID, p.ProductName,count(o.OrderID) as total_orders, sum(o.Quantity) as total_quantity, 
avg(datediff(s.ShipmentDate, o.OrderDate)) as average_shipping_time,min(s.ShipmentDate) as earliest_shipment_date,
max(s.ShipmentDate) as latest_shipment_date
from shipments.Products p
left join shipments.Orders o 
on p.ProductID = o.ProductID
left join shipments.Shipments s 
on o.OrderID = s.OrderID
group by p.ProductID, p.ProductName;

--------------------------------------------------------------------------------------------------------------------

