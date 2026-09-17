
-- SQL Analysis - Superstore Dataset
-- Task 3: SkillAudit.ai

-- Query 1: What is the total sales?
SELECT SUM(Sales) AS Total_Sales
FROM superstore;


-- Query 2: What is the total sales by category?
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Query 3: What is the total sales by region?
SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Query 4: What is the total sales by customer segment?
SELECT
    Segment,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- Query 5: How many unique orders are there in each category?
SELECT
    Category,
    COUNT(DISTINCT "Order ID") AS Total_Orders
FROM superstore
GROUP BY Category
ORDER BY Total_Orders DESC;


-- Query 6: What are the total sales and number of orders for each customer segment?
SELECT
    s.Segment,
    s.Total_Sales,
    o.Total_Orders
FROM
    (
        SELECT Segment, SUM(Sales) AS Total_Sales
        FROM superstore
        GROUP BY Segment
    ) s
JOIN
    (
        SELECT Segment, COUNT(DISTINCT "Order ID") AS Total_Orders
        FROM superstore
        GROUP BY Segment
    ) o
ON s.Segment = o.Segment
ORDER BY s.Total_Sales DESC;


-- Query 7: What is the average sales per order?
SELECT
    AVG(Order_Sales) AS Average_Sales_Per_Order
FROM
    (
        SELECT
            "Order ID",
            SUM(Sales) AS Order_Sales
        FROM superstore
        GROUP BY "Order ID"
    );


-- Query 8: Which orders have sales greater than the average order sales?
SELECT
    "Order ID",
    SUM(Sales) AS Order_Sales
FROM superstore
GROUP BY "Order ID"
HAVING SUM(Sales) > (
    SELECT AVG(Order_Sales)
    FROM (
        SELECT
            "Order ID",
            SUM(Sales) AS Order_Sales
        FROM superstore
        GROUP BY "Order ID"
    )
)
ORDER BY Order_Sales DESC;


-- Query 9: What is the total sales and average sales for each category?
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Average_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Query 10: What are the top 10 products by sales?
SELECT
    "Product Name",
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY "Product Name"
ORDER BY Total_Sales DESC
LIMIT 10;
