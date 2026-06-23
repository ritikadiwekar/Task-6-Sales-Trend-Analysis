-- TASK 6 
-- [ Sales Trend Analysis Using Aggregations ]

-- OBJECTIVE: Analyze monthly revenue and order volume

CREATE DATABASE sales_trend;
USE sales_trend;

CREATE TABLE online_sales (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

INSERT INTO online_sales VALUES
(1,'2024-01-05',500,101),
(2,'2024-01-10',700,102),
(3,'2024-01-15',300,103),
(4,'2024-02-05',800,101),
(5,'2024-02-08',900,104),
(6,'2024-02-12',600,105),
(7,'2024-03-02',1200,102),
(8,'2024-03-10',400,103),
(9,'2024-03-15',700,104),
(10,'2024-04-01',1500,101),
(11,'2024-04-08',1000,102),
(12,'2024-04-12',900,103),
(13,'2024-05-05',2000,104),
(14,'2024-05-10',1200,105),
(15,'2024-05-15',1100,101),
(16,'2024-06-01',1800,102),
(17,'2024-06-08',900,103),
(18,'2024-06-12',1000,104),
(19,'2024-06-18',1500,105),
(20,'2024-06-25',1300,101);

SELECT * FROM online_sales;

-- Q1] Monthly Revenue
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Monthly_revenue
FROM online_sales
GROUP by EXTRACT(MONTH FROM order_date)
ORDER BY Month;

-- Q2] Monthly Order Volume
SELECT
	EXTRACT(MONTH FROM order_date) AS Month,
    COUNT(DISTINCT order_id) AS order_volume 
FROM online_sales
GROUP by EXTRACT(MONTH FROM order_date)
ORDER BY Month;

-- Q3] Revenue + Volume Together
SELECT 
	MONTH(order_date) AS Month,
    SUM(amount) AS Monthly_revenue,
	COUNT(DISTINCT order_id) AS order_volume 
FROM online_sales
GROUP by MONTH(order_date)
ORDER BY Month;

-- Q4] Highest Revenue Month
SELECT 
	MONTH(order_date) AS highest_revenue_month,
    SUM(amount) AS revenue
FROM online_sales
GROUP by MONTH(order_date)
ORDER BY revenue DESC
LIMIT 1;

-- Q5] Specific Period Analysis
SELECT 
	MONTH(order_date) AS Month,
    SUM(amount) AS revenue,
	COUNT(DISTINCT order_id) AS orders 
FROM online_sales
WHERE order_date BETWEEN  '2024-01-01' AND '2024-03-31'
GROUP BY MONTH(order_date);

-- Q6] Average Order Value per Month
SELECT 
	MONTH(order_date) AS Month,
	ROUND(AVG(amount),2) AS avg_order_amount
FROM online_sales
GROUP by MONTH(order_date)
ORDER BY Month;

-- Q7] Total Revenue by Product
SELECT 
	product_id,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY product_id;

-- Q8] Top 3 Products by Revenue
SELECT 
	product_id,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY product_id
ORDER by total_revenue DESC
LIMIT 3;

-- Q9] Lowest Revenue Month
SELECT 
	MONTH(order_date) AS lowest_revenue_month,
    SUM(amount) AS revenue
FROM online_sales
GROUP by MONTH(order_date)
ORDER BY revenue asc
LIMIT 1;

-- Q10] Total Orders per Product
SELECT
    product_id,
    COUNT(order_id) AS Total_Orders
FROM online_sales
GROUP BY product_id
ORDER BY Total_Orders DESC;

-- Q11] Revenue Above 3000
SELECT
    MONTH(order_date) AS Month,
    SUM(amount) AS Revenue
FROM online_sales
GROUP BY MONTH(order_date)
HAVING SUM(amount) > 3000;

-- Q12] Revenue Contribution %
SELECT
    product_id,
    SUM(amount) AS Revenue,
    ROUND(
        SUM(amount)*100 /
        (SELECT SUM(amount) FROM online_sales),
        2
    ) AS Revenue_Percentage
FROM online_sales
GROUP BY product_id;

-- END TASK --





