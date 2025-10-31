/*
======================================================================
Customer Segmentation by Value & Behavior
======================================================================
Purpose:
- Classify customers into segments (VIP, Regular, New)
  based on:
    � Lifetime value (total spending)
    � Length of customer relationship (lifespan in months)
- Support targeted marketing and retention strategies

-VIP : at least 12 months of history and spending more than $5000
-Regular : at least 12 months of history but spending $5000 or less
-New : lifespan less than 12 months 
*/

WITH customer_spending AS
 (SELECT c.customer_key ,
         sum(s.sales_amount) AS total_spending ,
         min(order_date) AS first_order ,
         max(order_date) AS last_order ,
         datediff(MONTH, min(order_date), max(order_date)) AS lifespan
  FROM gold.fact_sales s
  LEFT JOIN gold.dim_customers c ON s.customer_key = c.customer_key
  GROUP BY c.customer_key)
SELECT customer_segment ,
       count(customer_key) AS total_customers
FROM
 (SELECT customer_key ,
         CASE
             WHEN lifespan >= 12
                  AND total_spending > 5000 THEN 'VIP'
             WHEN lifespan >= 12
                  AND total_spending <= 5000 THEN 'Regular'
             ELSE 'New'
         END customer_segment
  FROM customer_spending) AS segments
GROUP BY customer_segment
ORDER BY total_customers DESC
