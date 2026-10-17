-- ! give me all the customers who have cancelled their orders

SELECT *
FROM customers
WHERE customer_id IN (
        SELECT customer_id
        FROM orders
        WHERE status = 'cancelled'
    );
-- ! Give me all the products which are having 
-- ! price > average price across all products
-- ! p1 - 100, p2 - 200, p3 = 1000, p4 - 200, p5- 900
-- ! 1500/4 - average -> 375
-- ! p3, p5 -> returned
SELECT *
FROM products
WHERE price > (
        SELECT AVG(price)
        from products
);

-- ! give me sales on category level
--! electronics - 3000
-- ! clothing - 4000
-- ! give me categories having sales > 500
-- ! return category name in the result

SELECT * FROM orders;
SELECT * FROM order_items;

-- ! derived table
SELECT c.category_name,
    category_stats.category_sales
FROM (
        SELECT p.category_id as stat_id,
            SUM(oi.quantity * oi.unit_price) as category_sales
        FROM order_items as oi
            LEFT JOIN products as p ON p.product_id = oi.product_id
        GROUP BY p.category_id
    ) as category_stats
    LEFT JOIN categories as c ON c.category_id = category_stats.stat_id
WHERE category_sales > 500;
