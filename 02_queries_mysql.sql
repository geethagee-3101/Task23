-- Task 23: 10 SQL aggregation queries (MySQL)
USE task23_aggregation;

-- Q1 - Total number of customers
SELECT COUNT(*) AS total_customers FROM Customers;

-- Q2 - Total number of orders
SELECT COUNT(*) AS total_orders FROM Orders;

-- Q3 - Total sales revenue
SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS total_revenue FROM OrderDetails;

-- Q4 - Average order value
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM (
  SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS order_total
  FROM OrderDetails
  GROUP BY OrderID
) AS order_totals;

-- Q5 - Minimum and maximum order value
SELECT MIN(order_total) AS minimum_order_value,
       MAX(order_total) AS maximum_order_value
FROM (
  SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS order_total
  FROM OrderDetails
  GROUP BY OrderID
) AS order_totals;

-- Q6 - Number of orders placed by each customer
SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS order_count
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID;

-- Q7 - Sales revenue by customer
SELECT c.CustomerID, c.CompanyName,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS customer_revenue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY customer_revenue DESC;

-- Q8 - Average, minimum and maximum product price
SELECT ROUND(AVG(UnitPrice), 2) AS average_price,
       MIN(UnitPrice) AS minimum_price, MAX(UnitPrice) AS maximum_price
FROM Products;

-- Q9 - Total quantity sold for each product
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS total_quantity_sold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY total_quantity_sold DESC;

-- Q10 - Average freight charge
SELECT ROUND(AVG(Freight), 2) AS average_freight FROM Orders;
