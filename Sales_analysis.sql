Create database sales_analysis;
use sales_analysis;
drop table superstore;
drop table sales_performance;
CREATE TABLE sales (Row_ID INT, Order_ID VARCHAR(50), Order_Date DATE, Ship_Date DATE, Ship_Mode VARCHAR(50),
Customer_ID VARCHAR(50), Customer_Name VARCHAR(100), Segment VARCHAR(50), Country VARCHAR(50),City VARCHAR(50),
State VARCHAR(50), Postal_Code INT, Region VARCHAR(50), Product_ID VARCHAR(50),Category VARCHAR(50), 
Sub_Category VARCHAR(50), Product_Name VARCHAR(255), Sales DECIMAL(10,2), Quantity INT,
Discount DECIMAL(5,2), Profit DECIMAL(10,2));

SHOW TABLES;
SELECT COUNT(*) FROM sales;
-- Total Sales--
SELECT ROUND(SUM(Sales),2) AS total_sale FROM sales;

-- Total Profit --
SELECT ROUND(SUM(Profit),2) AS total_profit FROM sales;

-- Sales by Region --
SELECT Region, ROUND(SUM(Sales),2) AS total_sales FROM sales GROUP BY Region ORDER BY total_sales DESC;

-- Profit by category --
SELECT Category, ROUND(SUM(Profit),2) AS total_profit FROM sales GROUP BY Category 
ORDER BY total_profit DESC;

DESCRIBE sales;
-- Top 10 Products--
SELECT 
    `Product Name`,
    ROUND(SUM(Sales),2) AS total_sales
FROM sales
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Customers --
SELECT 
    `Customer Name`,
    ROUND(SUM(Sales),2) AS total_sales
FROM sales
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Monthly sales trend --
SELECT 
    YEAR("Order Date") AS order_year,
    MONTH("Order Date") AS order_month,
    ROUND(SUM(Sales),2) AS monthly_sales
FROM sales
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- Rank products by Sales--
SELECT 
    'Product Name',
    Category,
    Sales,
    RANK() OVER(
        PARTITION BY Category
        ORDER BY Sales DESC
    ) AS sales_rank
FROM sales;

-- Sales by segment--
SELECT 
    Segment,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit
FROM sales
GROUP BY Segment;

-- Discount impact on profit--
SELECT 
    Discount,
    ROUND(AVG(Profit),2) AS avg_profit
FROM sales
GROUP BY Discount
ORDER BY Discount;

CREATE VIEW sales_summary AS SELECT Region,
    Category,
    Segment,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    COUNT(DISTINCT 'CustomerID') AS total_customers
FROM sales
GROUP BY Region, Category, Segment;

SELECT * 
FROM sales_summary;