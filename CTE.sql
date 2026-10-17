-- COMMON TABLE EXPRESSIONS (CTEs) are a way to create temporary result sets that can be referenced 
-- within a SELECT, INSERT, UPDATE, or DELETE statement.
--  They are defined using the WITH clause and can help improve the readability and organization of complex queries.



-- ! CTE Starts
-- ! CTE - Common Table Expressions

SELECT 
    c.category_name,
    category_stats.category_sales
FROM (
    SELECT 
        p.category_id as stat_id,
        SUM(oi.quantity * oi.unit_price) as category_sales
    FROM order_items as oi
    LEFT JOIN products as p ON p.product_id = oi.product_id
    GROUP BY p.category_id
) as category_stats
LEFT JOIN categories as c ON c.category_id = category_stats.stat_id;


WITH category_stats AS (
    SELECT 
        p.category_id,
        SUM(oi.quantity * oi.unit_price) as category_sales
    FROM order_items as oi
    LEFT JOIN products as p ON p.product_id = oi.product_id
    GROUP BY p.category_id
)
SELECT 
    c.category_name,
    category_stats.category_sales
FROM category_stats
LEFT JOIN categories as c ON c.category_id = category_stats.category_id;

-- WITH var_name AS (
--     ...SQL query
-- )



WITH category_stats AS (
    SELECT 
        p.category_id,
        SUM(oi.quantity * oi.unit_price) as category_sales
    FROM order_items as oi
    LEFT JOIN products as p ON p.product_id = oi.product_id
    GROUP BY p.category_id
),
hsc AS (
    SELECT * FROM category_stats
    ORDER BY category_sales DESC
    LIMIT 1
)
SELECT 
    c.category_name,
    hsc.category_sales
FROM hsc
LEFT JOIN categories as c ON c.category_id = hsc.category_id;


-- ! Reusability

-- ! Give me total spend of a customer
-- ! Also give me average spend of all customer
-- ! Also give me flag TRUE or FALSE basis of if the customer 
-- ! have above average spending


WITH customer_total AS (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spend
    FROm orders as o
    LEFT JOIN order_items as oi ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.customer_id
)
SELECT 
    ct.customer_id,
    ct.customer_spend,
    ROUND((SELECT AVG(customer_spend) FROM customer_total), 2) as avg_spend,
    ct.customer_spend > (SELECT AVG(customer_spend) FROM customer_total) as is_above_avg
FROM customer_total as ct;


-- ! equivalent subquery for the above query

SELECT 
    ct.customer_id,
    ct.customer_spend,
    ROUND(
        (SELECT AVG(customer_spend)
         FROM (
             SELECT 
                 o.customer_id,
                 SUM(oi.quantity * oi.unit_price) AS customer_spend
             FROM orders AS o
             LEFT JOIN order_items AS oi 
                 ON oi.order_id = o.order_id
             WHERE o.status = 'completed'
             GROUP BY o.customer_id
         ) AS customer_total
        ), 
        2
    ) AS avg_spend,
    ct.customer_spend > (
        SELECT AVG(customer_spend)
        FROM (
            SELECT 
                o.customer_id,
                SUM(oi.quantity * oi.unit_price) AS customer_spend
            FROM orders AS o
            LEFT JOIN order_items AS oi 
                ON oi.order_id = o.order_id
            WHERE o.status = 'completed'
            GROUP BY o.customer_id
        ) AS customer_total
    ) AS is_above_avg
FROM (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spend
    FROM orders AS o
    LEFT JOIN order_items AS oi 
        ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.customer_id
) AS ct;