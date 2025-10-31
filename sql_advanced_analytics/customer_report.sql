/* 
=================================================================================================
Customer Report View
=================================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Extracts customer info such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Calculates behavioral metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
		- average order value (AOV)
		- average monthly spend
=================================================================================================
*/

CREATE VIEW gold.report_customers
AS
WITH base_query
AS (
	/*-----------------------------------------------------------------------------------------------
1. Base query : Retrieves core columns from tables
-----------------------------------------------------------------------------------------------*/
	SELECT s.order_number
		,s.product_key
		,s.order_date
		,s.sales_amount
		,s.quantity
		,c.customer_key
		,c.customer_number
		,CONCAT (
			c.first_name
			,' '
			,c.last_name
			) AS customer_name
		,datediff(year, c.birthdate, getdate()) AS age
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_customers c ON s.customer_key = c.customer_key
	WHERE order_date IS NOT NULL
	)
	,customer_aggregation
AS (
	/*----------------------------------------------------------------------------------------------
2. Customer Aggregations: Summarizes key metrics at the customer level 
----------------------------------------------------------------------------------------------*/
	SELECT customer_key
		,customer_number
		,customer_name
		,age
		,count(DISTINCT order_number) AS total_orders
		,sum(sales_amount) AS total_sales
		,sum(quantity) AS total_quantity
		,count(DISTINCT product_key) AS total_products
		,max(order_date) AS last_order_date
		,datediff(month, min(order_date), max(order_date)) AS lifespan
	FROM base_query
	GROUP BY customer_key
		,customer_number
		,customer_name
		,age
	)
SELECT customer_key
	,customer_number
	,customer_name
	,age
	,CASE 
		WHEN age < 20
			THEN 'Under 20'
		WHEN age BETWEEN 20
				AND 29
			THEN '20-29'
		WHEN age BETWEEN 30
				AND 39
			THEN '30-39'
		WHEN age BETWEEN 40
				AND 49
			THEN '40-49'
		ELSE '50 and above'
		END AS age_group
	,CASE 
		WHEN lifespan >= 12
			AND total_sales > 5000
			THEN 'VIP'
		WHEN lifespan >= 12
			AND total_sales <= 5000
			THEN 'Regular'
		ELSE 'New'
		END customer_segment
	,last_order_date
	,datediff(month, last_order_date, getdate()) AS recency
	,total_orders
	,total_sales
	,total_quantity
	,total_products
	,lifespan
	,
	---Compuate average order value (AVO)
	CASE 
		WHEN total_orders = 0
			THEN 0
		ELSE total_sales / total_orders
		END avg_order_value
	,
	---Compuate average monthly spend
	CASE 
		WHEN lifespan = 0
			THEN total_sales
		ELSE total_sales / lifespan
		END avg_monthly_spend
FROM customer_aggregation
