
-- 1. Create departments table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- 2. Insert departments
INSERT INTO departments (department_name)
VALUES
    ('SALES'),
    ('SUPPORT'),
    ('WAREHOUSE');

INSERT INTO departments (department_id, department_name)
VALUES (4, 'TECH');


-- 3. Create employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK (salary > 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date DATE NOT NULL,
    last_login TIMESTAMP,
    employee_status VARCHAR(20) NOT NULL DEFAULT 'active'
        CHECK (
            employee_status IN ('active', 'on_leave', 'terminated')
        ),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    department_id INT REFERENCES departments(department_id),
    manager_id INT REFERENCES employees(employee_id)
);


-- 4. Insert employees
INSERT INTO employees (
    first_name, last_name, email, phone, bio,
    job_title, salary, is_active, hire_date,
    last_login, employee_status, department_id, manager_id
)
VALUES
(
    'Rahul', 'Sharma', 'rahul@example.com', '9876543210',
    'Experienced sales professional', 'Sales Manager', 75000,
    TRUE, '2022-01-15', '2026-10-14 09:30:00',
    'active', 1, NULL
),
(
    'Priya', 'Verma', 'priya@example.com', '9876543211',
    'Customer support specialist', 'Support Executive', 40000,
    TRUE, '2023-03-10', '2026-10-14 10:15:00',
    'active', 2, 1
),
(
    'Amit', 'Patel', 'amit@example.com', '9876543212',
    'Manages warehouse operations', 'Warehouse Supervisor', 50000,
    TRUE, '2021-07-20', '2026-10-13 17:45:00',
    'active', 3, 1
),
(
    'Sneha', 'Gupta', 'sneha@example.com', '9876543213',
    'Software development specialist', 'Software Engineer', 65000,
    TRUE, '2024-06-01', NULL,
    'on_leave', 4, 1
),
(
    'Vikas', 'Singh', 'vikas@example.com', '9876543214',
    'Former support team member', 'Support Executive', 35000,
    FALSE, '2020-11-05', '2025-12-20 14:00:00',
    'terminated', 2, 1
);


-- 5. Display all departments
SELECT * FROM departments;

-- 6. Display all employees
SELECT * FROM employees;
