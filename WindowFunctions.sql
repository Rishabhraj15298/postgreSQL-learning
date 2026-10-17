-- ! Window Functions Start
-- ! Give me total product's price sum on category level
SELECT 
    category_id,
    SUM(price) as product_sum
FROM products
GROUP BY category_id;

-- ! Window func
SELECT
    *,
    SUM(price) OVER (PARTITION BY category_id) as category_total_price
FROM products;

-- ! Without affectng or reducing the table structure
-- ! give me average price across all the products

SELECT 
    *,
    AVG(price) OVER () as avg_price
FROM products;

-- ! Give rank to a product based on how pricy it is

SELECT 
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) as prod_row_num,
    RANK() OVER (ORDER BY price DESC) as prod_rank,
    DENSE_RANK() OVER (ORDER BY price DESC) as prod_dense_rank
FROM products;
