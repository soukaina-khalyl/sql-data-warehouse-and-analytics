/*
====================================================================================
Product and Category Performance Analysis
====================================================================================
Purpose:
- Identify top-performing product categories by their contribution to total sales
- Segment products into cost-based groups to better understand pricing distribution
*/


-- which categories contribute the most to overall sales ? 

WITH category_sales AS
 (SELECT category ,
         sum(sales_amount) AS total_sales
  FROM gold.fact_sales s
  LEFT JOIN gold.dim_products p ON s.product_key = p.product_key
  GROUP BY category)
SELECT category ,
       total_sales ,
       sum(total_sales) OVER () AS overall_sales ,
       CONCAT (round((cast(total_sales AS FLOAT) / sum(total_sales) OVER ()) * 100, 2) ,
               '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC

-- Segment products into cost ranges and count how many products fall into each segment 

WITH product_segments AS (
		SELECT product_key
			,product_name
			,cost
			,CASE 
				WHEN cost < 100
					THEN 'Below 100'
				WHEN cost BETWEEN 100
						AND 500
					THEN '100-500'
				WHEN cost BETWEEN 500
						AND 1000
					THEN '500-1000'
				ELSE 'Above 1000'
				END cost_range
		FROM gold.dim_products
		)

SELECT cost_range
	,count(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC
