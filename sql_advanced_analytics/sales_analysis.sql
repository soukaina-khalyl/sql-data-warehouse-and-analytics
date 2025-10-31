/*
========================================================================
File: 1_sales_analysis.sql
========================================================================
Purpose:
- Analyze overall sales performance over time at the monthly level.

Highlights:
- Uses DATETRUNC(MONTH, order_date) to group sales into months.
- Calculates key business metrics per month:
    � Total sales
    � Number of unique customers
    � Total quantity sold
- Suitable for time-series analysis and dashboard visualizations.     
*/


-- Query 1: Monthly sales trend | total sales, customer count, and quantity sold

SELECT DATETRUNC(MONTH, order_date) AS order_date
	,sum(sales_amount) AS total_Sales
	,COUNT(DISTINCT customer_key) AS total_customers
	,SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date)

-- Query 2: Running total of sales and moving average price by year

SELECT order_date,
		total_sales,
		 -- window function 
		SUM(total_sales)
	OVER ( PARTITION BY order_date
ORDER BY  order_date ) AS running_total_sales ,AVG(avg_price)
	OVER (
ORDER BY  order_date ) AS moving_average_price
FROM 
	(SELECT DATETRUNC(YEAR,
		 order_date) AS order_date ,
		SUM(sales_amount) AS total_sales ,
		AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY  DATETRUNC(YEAR, order_date) ) AS monthly_sales

-- Query 3: Analyze the yearly performance of products by comparing each products sales
-- to both it's average sales performance and the previous year's sales 

WITH yearly_product_sales AS
 (SELECT year(s.order_date) AS order_year ,
         p.product_name ,
         sum(s.sales_amount) AS current_sales
  FROM gold.fact_sales s
  LEFT JOIN gold.dim_products p ON s.product_key = p.product_key
  WHERE s.order_date IS NOT NULL
  GROUP BY year(s.order_date) ,
           p.product_name)
SELECT order_year ,
       product_name ,
       current_sales ,
       AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales ,
       current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg ,
       CASE
           WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
           WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
           ELSE 'Avg'
       END avg_change , 
	   -- Year-over-year Analysis
       lag(current_sales) OVER (PARTITION BY product_name
                           ORDER BY order_year) AS previous_year_sales ,
       current_sales - lag(current_sales) OVER (PARTITION BY product_name
                                           ORDER BY order_year) AS diff_py ,
       CASE
			WHEN current_sales - lag(current_sales) OVER (PARTITION BY product_name
                                                    ORDER BY order_year) > 0 THEN 'Increae'
			WHEN current_sales - lag(current_sales) OVER (PARTITION BY product_name
                                                    ORDER BY order_year) < 0 THEN 'Decrease'
            ELSE 'No change'
       END py_change
FROM yearly_product_sales
ORDER BY product_name ,
         order_year
