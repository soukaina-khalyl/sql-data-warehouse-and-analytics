/*
==================================================================================
Exploratory Data Analysis (EDA) on Gold Layer of the Data Warehouse
==================================================================================

This SQL script performs a structured exploration of the Gold layer tables
(fact_sales, dim_customers, dim_products) to understand the data 
and extract key business insights. 
The script covers different types of analysis

==================================================================================
*/

-------------------------------------------------- DATABASE EXPLORATION ---------------------------------

-- Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

--Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'


------------------------------------------------ DIMENSIONS EXPLORATION ----------------------------------

-- Explore All Countries our customers come from 
SELECT DISTINCT country 
FROM gold.dim_customers

-- Explore product Categories and subcategories
SELECT DISTINCT category, subcategory, product_name 
FROM gold.dim_products
ORDER BY 1, 2, 3


------------------------------------------------ Date Exploration -----------------------------------------

-- First and last order date
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- Youngest and oldest customer 
SELECT 
MIN(birthdate) AS oldest_customer,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_customer,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers


------------------------------------------------ Measures Exploration ----------------------------------------

-- Key metrics of the business 
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products' AS measure_name, COUNT(product_key) AS measure_value FROM gold.dim_products
UNION ALL 
SELECT 'Total Nr. Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers


------------------------------------------------ Magnitude Analysis -------------------------------------------

-- Customers by country
SELECT 
country,
COUNT(customer_key) AS total_customers 
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

-- Customers by gender
SELECT 
gender,
COUNT(customer_key) AS total_customers 
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC

-- Products by category
SELECT 
category,
COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC

-- Average cost by category
SELECT 
category,
AVG(cost) AS avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC

-- Total revenue per category
SELECT 
category,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_revenue DESC

-- Total revenue per customer
SELECT 
c.customer_key,
c.first_name,
c.last_name,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC

-- Total items sold per country
SELECT 
c.country,
SUM(quantity) AS total_sold_items
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC


------------------------------------------------ Ranking Analysis -----------------------------------------

-- Top 5 products by revenue
SELECT TOP 5
p.product_name,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- Worst 5 performing products in terms of sales 
SELECT TOP 5
p.product_name,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue 

-- Top 5 customers by revenue
SELECT TOP 5
c.first_name,
c.last_name,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.first_name, c.last_name
ORDER BY total_revenue DESC

-- Top 5 months by revenue
SELECT TOP 5 
MONTH(order_date) AS month,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales
GROUP BY MONTH(order_date)
ORDER BY total_revenue DESC

