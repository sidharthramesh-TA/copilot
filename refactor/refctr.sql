SELECT full_name 
	,  kpi1*kpi2 as ratio
from (
SELECT full_name
	,  product_name
	,  quantity
	,  price
	,  price/quantity kpi1
	,  1/quantity::float kpi2
FROM (
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.email,
    p.product_name,
    p.category,
    p.price,
    s.quantity,
    s.sale_amount,
    s.effective_date AS sale_effective_date,
    s.expiration_date AS sale_expiration_date
FROM
    staging_sales_fact s
JOIN customer_dim c ON s.customer_id = c.customer_id AND c.is_current = 'y'
JOIN product_dim p ON s.product_id = p.product_id AND p.is_current = 'y'
WHERE
    s.is_current = 'y'
)
)


'''

Eliminate Redundant Subquery: The outermost subquery that calculates ratio can be integrated into the inner subquery to simplify the query structure.
Direct Calculation of ratio: Calculate ratio (kpi1*kpi2) directly in the main subquery to avoid unnecessary nesting.
Alias for Subqueries: Use meaningful aliases for subqueries and tables to improve readability.
Column Selection: Since only full_name and the calculated ratio are required in the final output, ensure that only these fields are processed in the final SELECT statement.


'''


SELECT
    c.full_name,
    (p.price / s.quantity) * (1 / s.quantity::float) AS ratio
FROM
    staging_sales_fact s
JOIN
    customer_dim c ON s.customer_id = c.customer_id AND c.is_current = 'y'
JOIN
    product_dim p ON s.product_id = p.product_id AND p.is_current = 'y'
WHERE
    s.is_current = 'y';
