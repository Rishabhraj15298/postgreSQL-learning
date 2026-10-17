-- ! Joins Start

-- ! Give me all orders including employee details of the employee who processed
-- ! that order 
-- ! only include orders punched by employees

SELECT * FROM orders;
SELECT * FROM employees;

SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    INNER JOIN employees as e ON o.employee_id = e.employee_id;


-- ! give me all orders and include employee details of employee who processed
-- ! that order and if it is directly coming from customer keep employee
-- ! details empty

SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    LEFT JOIN employees  e ON o.employee_id = e.employee_id;


SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    RIGHT JOIN employees as e ON o.employee_id = e.employee_id;


SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    FULL OUTER JOIN employees as e ON o.employee_id = e.employee_id;


SELECT * 
FROM departments
CROSS JOIN categories;

-- ! Joins examples

-- ! Give me all customers who did not place any order

SELECT 
    c.first_name,
    c.email,
    o.status,
    o.order_id
FROM customers as c
LEFT JOIN orders as o ON o.customer_id = c.customer_id
WHERE o.status IS NULL;

-- ! Give me orders which have not been paid

SELECT * 
FROM orders as o
LEFT JOIN payments as p ON p.order_id = o.order_id
WHERE p.payment_id IS NULL;


-- ! Give information about all orders thata are there in the DB
-- ! Include info about order_items, product, customer and 
-- ! category the product belongs to


SELECT 
    o.order_id,
    o.status,
    oi.product_id,
    oi.unit_price,
    p.product_name,
    p.price,
    c.category_name,
    cu.first_name,
    cu.last_name
FROM orders as o
LEFT JOIN order_items as oi ON oi.order_id = o.order_id
LEFT JOIN products as p ON p.product_id = oi.product_id
LEFT JOIN categories as c ON c.category_id = p.category_id
LEFT JOIN customers as cu ON cu.customer_id = o.customer_id;


-- ! Give me info about employees including their manager's info

SELECT 
    emp.first_name as "Employee First Name",
    emp.last_name as "Employee Last Name",
    manager_tbl.first_name as "Manager First Name",
    manager_tbl.last_name as "Manager Last Name"
FROm employees as emp
LEFT JOIN employees as manager_tbl ON emp.manager_id = manager_tbl.employee_id;



SELECT COUNT(*) as product_count FROM products;

-- ! Give me total number of products in each category

SELECT category_id, COUNT(*) 
FROM products
GROUP BY category_id;

-- ! Give me total number of active and inactive
-- ! products in each category

SELECT category_id, is_active, COUNT(*) 
FROM products
GROUP BY category_id, is_active;


-- ! Give me total number of products in each category
-- ! include category name in the results

SELECT 
    p.category_id, 
    c.category_name,
    COUNT(*) 
FROM products as p
LEFT JOIN categories as c on c.category_id = p.category_id
GROUP BY p.category_id, c.category_name;


-- ! Give me total number of products in each category

-- ! and give me categories having > 5 products

SELECT category_id, COUNT(*) 
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;


-- ! Find departments having more than one managed employee,
-- ! where their combined salary of whole department exceeds 200000 rupees.


SELECT 
    department_id,
    COUNT(*),
    SUM(salary) as total_dep_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(*) > 1;
