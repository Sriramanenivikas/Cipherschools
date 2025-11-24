-- ============================================================================
-- SQL INTERVIEW QUESTIONS - COMPLETE GUIDE (70+ QUESTIONS)
-- ============================================================================
-- Categorized: EASY | MEDIUM | ADVANCED
-- For Placements: TCS, Infosys, Wipro, Accenture, Amazon, Google, Microsoft
-- ============================================================================

-- ############################################################################
--                         SAMPLE DATABASE SETUP
-- ############################################################################

-- Run this first to create sample tables for practice

CREATE DATABASE IF NOT EXISTS interview_practice;
USE interview_practice;

-- Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    department_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    hire_date DATE,
    age INT,
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50),
    budget DECIMAL(15,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(50),
    registration_date DATE
);

-- Sample Data
INSERT INTO departments VALUES
(1, 'Engineering', 'Building A', 500000),
(2, 'Marketing', 'Building B', 300000),
(3, 'HR', 'Building C', 150000),
(4, 'Finance', 'Building D', 400000),
(5, 'Sales', 'Building E', 350000);

INSERT INTO employees (emp_name, email, department_id, salary, manager_id, hire_date, age, city) VALUES
('John Smith', 'john@company.com', 1, 75000, NULL, '2020-01-15', 35, 'New York'),
('Jane Doe', 'jane@company.com', 1, 82000, 1, '2020-03-20', 32, 'New York'),
('Bob Wilson', 'bob@company.com', 2, 65000, 1, '2021-06-10', 28, 'Chicago'),
('Alice Brown', 'alice@company.com', 1, 90000, 1, '2019-11-05', 40, 'New York'),
('Charlie Davis', 'charlie@company.com', 3, 55000, 1, '2022-01-20', 26, 'Boston'),
('Eva Martinez', 'eva@company.com', 2, 70000, 3, '2021-08-15', 30, 'Chicago'),
('Frank Miller', 'frank@company.com', 4, 85000, 1, '2020-05-12', 38, 'Boston'),
('Grace Lee', 'grace@company.com', 1, 78000, 2, '2021-02-28', 29, 'New York'),
('Henry Taylor', 'henry@company.com', 5, 60000, 1, '2022-04-10', 27, 'Miami'),
('Ivy Clark', 'ivy@company.com', 3, 52000, 5, '2023-01-05', 24, 'Miami');


-- ############################################################################
-- ############################################################################
--                    EASY LEVEL QUESTIONS (1-25)
-- ############################################################################
-- ############################################################################

/*
============================================================================
EASY Q1: Select all columns from employees table
============================================================================
Topic: Basic SELECT
Company: All Companies (Screening Round)
*/

SELECT * FROM employees;


/*
============================================================================
EASY Q2: Select specific columns - name and salary
============================================================================
Topic: Column Selection
Company: TCS, Infosys, Wipro
*/

SELECT emp_name, salary FROM employees;


/*
============================================================================
EASY Q3: Find employees with salary greater than 70000
============================================================================
Topic: WHERE clause
Company: All Companies
*/

SELECT emp_name, salary
FROM employees
WHERE salary > 70000;


/*
============================================================================
EASY Q4: Find employees from 'New York' city
============================================================================
Topic: WHERE with string comparison
Company: Accenture, Cognizant
*/

SELECT emp_name, city
FROM employees
WHERE city = 'New York';


/*
============================================================================
EASY Q5: Sort employees by salary in descending order
============================================================================
Topic: ORDER BY
Company: All Companies
*/

SELECT emp_name, salary
FROM employees
ORDER BY salary DESC;


/*
============================================================================
EASY Q6: Find employees whose name starts with 'J'
============================================================================
Topic: LIKE operator
Company: TCS, Wipro, HCL
*/

SELECT emp_name
FROM employees
WHERE emp_name LIKE 'J%';


/*
============================================================================
EASY Q7: Find employees hired between two dates
============================================================================
Topic: BETWEEN operator
Company: Infosys, Tech Mahindra
*/

SELECT emp_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-12-31';


/*
============================================================================
EASY Q8: Count total number of employees
============================================================================
Topic: COUNT function
Company: All Companies
*/

SELECT COUNT(*) AS total_employees FROM employees;


/*
============================================================================
EASY Q9: Find unique cities from employees table
============================================================================
Topic: DISTINCT
Company: TCS, Infosys
*/

SELECT DISTINCT city FROM employees;


/*
============================================================================
EASY Q10: Find employees in department 1 or 2
============================================================================
Topic: IN operator
Company: Wipro, HCL
*/

SELECT emp_name, department_id
FROM employees
WHERE department_id IN (1, 2);


/*
============================================================================
EASY Q11: Find employees with NULL manager_id (top-level)
============================================================================
Topic: IS NULL
Company: All Companies
*/

SELECT emp_name
FROM employees
WHERE manager_id IS NULL;


/*
============================================================================
EASY Q12: Find average salary of all employees
============================================================================
Topic: AVG function
Company: TCS, Accenture
*/

SELECT AVG(salary) AS average_salary FROM employees;


/*
============================================================================
EASY Q13: Find minimum and maximum salary
============================================================================
Topic: MIN, MAX functions
Company: All Companies
*/

SELECT
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;


/*
============================================================================
EASY Q14: Find total salary expense
============================================================================
Topic: SUM function
Company: Infosys, Wipro
*/

SELECT SUM(salary) AS total_salary_expense FROM employees;


/*
============================================================================
EASY Q15: Limit results to first 5 employees
============================================================================
Topic: LIMIT clause
Company: All Companies
*/

SELECT emp_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;


/*
============================================================================
EASY Q16: Find employees NOT from 'New York'
============================================================================
Topic: NOT operator
Company: TCS, Cognizant
*/

SELECT emp_name, city
FROM employees
WHERE city != 'New York';

-- OR
SELECT emp_name, city
FROM employees
WHERE NOT city = 'New York';


/*
============================================================================
EASY Q17: Concatenate first name with email
============================================================================
Topic: CONCAT function
Company: Accenture, Wipro
*/

SELECT CONCAT(emp_name, ' - ', email) AS employee_info
FROM employees;


/*
============================================================================
EASY Q18: Convert employee name to uppercase
============================================================================
Topic: UPPER function
Company: TCS, Infosys
*/

SELECT UPPER(emp_name) AS name_uppercase FROM employees;


/*
============================================================================
EASY Q19: Find length of employee names
============================================================================
Topic: LENGTH function
Company: All Companies
*/

SELECT emp_name, LENGTH(emp_name) AS name_length
FROM employees;


/*
============================================================================
EASY Q20: Get current date and time
============================================================================
Topic: Date functions
Company: All Companies
*/

SELECT
    CURDATE() AS current_date,
    NOW() AS current_datetime,
    CURRENT_TIMESTAMP AS timestamp_now;


/*
============================================================================
EASY Q21: Find employees aged between 25 and 35
============================================================================
Topic: BETWEEN with numbers
Company: HCL, Tech Mahindra
*/

SELECT emp_name, age
FROM employees
WHERE age BETWEEN 25 AND 35;


/*
============================================================================
EASY Q22: Count employees in each city
============================================================================
Topic: GROUP BY with COUNT
Company: All Companies
*/

SELECT city, COUNT(*) AS employee_count
FROM employees
GROUP BY city;


/*
============================================================================
EASY Q23: Find employees with 'a' anywhere in name (case-insensitive)
============================================================================
Topic: LIKE with wildcards
Company: TCS, Wipro
*/

SELECT emp_name
FROM employees
WHERE LOWER(emp_name) LIKE '%a%';


/*
============================================================================
EASY Q24: Add alias to columns in output
============================================================================
Topic: Column Aliases
Company: All Companies
*/

SELECT
    emp_name AS "Employee Name",
    salary AS "Monthly Salary",
    salary * 12 AS "Annual Salary"
FROM employees;


/*
============================================================================
EASY Q25: Find year of hire for each employee
============================================================================
Topic: YEAR function
Company: Infosys, Accenture
*/

SELECT emp_name, YEAR(hire_date) AS hire_year
FROM employees;


-- ############################################################################
-- ############################################################################
--                    MEDIUM LEVEL QUESTIONS (26-55)
-- ############################################################################
-- ############################################################################

/*
============================================================================
MEDIUM Q26: INNER JOIN - Get employees with department names
============================================================================
Topic: INNER JOIN
Company: All Companies (Very Common!)
*/

SELECT e.emp_name, e.salary, d.dept_name, d.location
FROM employees e
INNER JOIN departments d ON e.department_id = d.dept_id;


/*
============================================================================
MEDIUM Q27: LEFT JOIN - All employees including those without department
============================================================================
Topic: LEFT JOIN
Company: Amazon, Microsoft, All Product Companies
*/

SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.dept_id;


/*
============================================================================
MEDIUM Q28: Find employees without any department assigned
============================================================================
Topic: LEFT JOIN with NULL check
Company: Google, Amazon, Flipkart
*/

SELECT e.emp_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.dept_id
WHERE d.dept_id IS NULL;


/*
============================================================================
MEDIUM Q29: Find departments with no employees
============================================================================
Topic: RIGHT JOIN with NULL check
Company: Microsoft, Adobe
*/

SELECT d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.dept_id
WHERE e.emp_id IS NULL;


/*
============================================================================
MEDIUM Q30: SELF JOIN - Find employees and their managers
============================================================================
Topic: SELF JOIN
Company: Very Common in All Interviews!
*/

SELECT
    e.emp_name AS employee,
    m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;


/*
============================================================================
MEDIUM Q31: Find second highest salary
============================================================================
Topic: Subquery / LIMIT OFFSET
Company: Top Interview Question! (All Companies)
*/

-- Method 1: Using LIMIT OFFSET
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Method 2: Using Subquery
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);


/*
============================================================================
MEDIUM Q32: Find Nth highest salary (N=3)
============================================================================
Topic: Subquery / Window Function
Company: Amazon, Google, Microsoft (Very Popular!)
*/

-- Method 1: LIMIT OFFSET
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;  -- N-1 = 2

-- Method 2: Using DENSE_RANK
SELECT salary FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 3;

-- Method 3: Correlated Subquery
SELECT DISTINCT salary
FROM employees e1
WHERE 3 = (
    SELECT COUNT(DISTINCT salary)
    FROM employees e2
    WHERE e2.salary >= e1.salary
);


/*
============================================================================
MEDIUM Q33: Find duplicate emails in employees table
============================================================================
Topic: GROUP BY with HAVING
Company: Facebook, LinkedIn, All Companies
*/

SELECT email, COUNT(*) AS occurrence
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;


/*
============================================================================
MEDIUM Q34: Delete duplicate records keeping one
============================================================================
Topic: DELETE with JOIN
Company: Amazon, Microsoft
*/

-- Keep the record with lowest emp_id
DELETE e1 FROM employees e1
INNER JOIN employees e2
WHERE e1.emp_id > e2.emp_id
AND e1.email = e2.email;


/*
============================================================================
MEDIUM Q35: Find employees earning more than department average
============================================================================
Topic: Correlated Subquery
Company: Google, Amazon, Goldman Sachs
*/

SELECT e1.emp_name, e1.salary, e1.department_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);


/*
============================================================================
MEDIUM Q36: Count employees in each department (include empty depts)
============================================================================
Topic: LEFT JOIN with GROUP BY
Company: All Companies
*/

SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.department_id
GROUP BY d.dept_id, d.dept_name;


/*
============================================================================
MEDIUM Q37: Find department with highest total salary
============================================================================
Topic: GROUP BY with ORDER BY
Company: Infosys, TCS, Wipro
*/

SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC
LIMIT 1;


/*
============================================================================
MEDIUM Q38: Find employees hired in the last 6 months
============================================================================
Topic: Date arithmetic
Company: All Companies
*/

SELECT emp_name, hire_date
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


/*
============================================================================
MEDIUM Q39: Calculate tenure in years for each employee
============================================================================
Topic: DATEDIFF / TIMESTAMPDIFF
Company: Accenture, Cognizant
*/

SELECT
    emp_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS tenure_years,
    DATEDIFF(CURDATE(), hire_date) AS tenure_days
FROM employees;


/*
============================================================================
MEDIUM Q40: Find employees with same salary
============================================================================
Topic: SELF JOIN
Company: Amazon, Google
*/

SELECT e1.emp_name AS employee1, e2.emp_name AS employee2, e1.salary
FROM employees e1
JOIN employees e2 ON e1.salary = e2.salary AND e1.emp_id < e2.emp_id;


/*
============================================================================
MEDIUM Q41: Use CASE for salary grade classification
============================================================================
Topic: CASE statement
Company: All Companies
*/

SELECT
    emp_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'Grade A'
        WHEN salary >= 60000 THEN 'Grade B'
        WHEN salary >= 40000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS salary_grade
FROM employees;


/*
============================================================================
MEDIUM Q42: Find employees whose salary is above company average
============================================================================
Topic: Subquery in WHERE
Company: All Companies
*/

SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


/*
============================================================================
MEDIUM Q43: UNION - Combine results from two queries
============================================================================
Topic: UNION
Company: TCS, Infosys, Wipro
*/

SELECT emp_name, salary, 'High Earner' AS category
FROM employees WHERE salary > 75000
UNION
SELECT emp_name, salary, 'Low Earner' AS category
FROM employees WHERE salary <= 50000;


/*
============================================================================
MEDIUM Q44: Find top 3 highest paid employees in each department
============================================================================
Topic: Window Functions (DENSE_RANK)
Company: Amazon, Google, Microsoft (VERY IMPORTANT!)
*/

SELECT * FROM (
    SELECT
        emp_name,
        department_id,
        salary,
        DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
    FROM employees
) ranked
WHERE dept_rank <= 3;


/*
============================================================================
MEDIUM Q45: Calculate running total of salaries
============================================================================
Topic: Window Functions (SUM OVER)
Company: Goldman Sachs, Morgan Stanley
*/

SELECT
    emp_name,
    salary,
    SUM(salary) OVER (ORDER BY emp_id) AS running_total
FROM employees;


/*
============================================================================
MEDIUM Q46: Find previous and next salary in the list
============================================================================
Topic: LAG and LEAD functions
Company: Amazon, Uber
*/

SELECT
    emp_name,
    salary,
    LAG(salary, 1) OVER (ORDER BY salary) AS previous_salary,
    LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary
FROM employees;


/*
============================================================================
MEDIUM Q47: ROW_NUMBER vs RANK vs DENSE_RANK
============================================================================
Topic: Window Functions Comparison
Company: All Product Companies
*/

SELECT
    emp_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK() OVER (ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_num
FROM employees;

/*
Difference:
- ROW_NUMBER: 1, 2, 3, 4, 5 (always unique, no gaps)
- RANK:       1, 2, 2, 4, 5 (same rank for ties, gaps after)
- DENSE_RANK: 1, 2, 2, 3, 4 (same rank for ties, no gaps)
*/


/*
============================================================================
MEDIUM Q48: Find department with more than 2 employees
============================================================================
Topic: GROUP BY with HAVING
Company: All Companies
*/

SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;


/*
============================================================================
MEDIUM Q49: Update salary with 10% hike for Engineering dept
============================================================================
Topic: UPDATE with JOIN
Company: Infosys, TCS
*/

UPDATE employees e
JOIN departments d ON e.department_id = d.dept_id
SET e.salary = e.salary * 1.10
WHERE d.dept_name = 'Engineering';


/*
============================================================================
MEDIUM Q50: Create a view for active employees
============================================================================
Topic: CREATE VIEW
Company: All Companies
*/

CREATE VIEW active_high_earners AS
SELECT emp_id, emp_name, salary, department_id
FROM employees
WHERE salary > 60000;

-- Query the view
SELECT * FROM active_high_earners;


/*
============================================================================
MEDIUM Q51: Find employees who earn more than their manager
============================================================================
Topic: SELF JOIN
Company: Google, Amazon, Microsoft (Classic Question!)
*/

SELECT
    e.emp_name AS employee,
    e.salary AS emp_salary,
    m.emp_name AS manager,
    m.salary AS mgr_salary
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;


/*
============================================================================
MEDIUM Q52: Find common employees between two conditions (INTERSECT logic)
============================================================================
Topic: Simulating INTERSECT
Company: Oracle, Microsoft
*/

-- Find employees in Engineering who also earn > 70000
SELECT emp_name FROM employees WHERE department_id = 1
AND emp_name IN (SELECT emp_name FROM employees WHERE salary > 70000);

-- Alternative using JOIN
SELECT DISTINCT e1.emp_name
FROM employees e1
JOIN employees e2 ON e1.emp_id = e2.emp_id
WHERE e1.department_id = 1 AND e2.salary > 70000;


/*
============================================================================
MEDIUM Q53: Pivot - Convert rows to columns
============================================================================
Topic: CASE with GROUP BY (Pivot)
Company: Amazon, Flipkart, Analytics Roles
*/

-- Count employees per city by department
SELECT
    department_id,
    SUM(CASE WHEN city = 'New York' THEN 1 ELSE 0 END) AS new_york,
    SUM(CASE WHEN city = 'Chicago' THEN 1 ELSE 0 END) AS chicago,
    SUM(CASE WHEN city = 'Boston' THEN 1 ELSE 0 END) AS boston,
    SUM(CASE WHEN city = 'Miami' THEN 1 ELSE 0 END) AS miami
FROM employees
GROUP BY department_id;


/*
============================================================================
MEDIUM Q54: Find percentage of employees in each department
============================================================================
Topic: Subquery with aggregation
Company: All Analytics Roles
*/

SELECT
    department_id,
    COUNT(*) AS emp_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS percentage
FROM employees
GROUP BY department_id;


/*
============================================================================
MEDIUM Q55: Using CTE (Common Table Expression)
============================================================================
Topic: CTE / WITH clause
Company: All Modern Interviews
*/

WITH dept_salaries AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary,
        COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
)
SELECT d.dept_name, ds.avg_salary, ds.emp_count
FROM dept_salaries ds
JOIN departments d ON ds.department_id = d.dept_id
WHERE ds.avg_salary > 60000;


-- ############################################################################
-- ############################################################################
--                    ADVANCED LEVEL QUESTIONS (56-75)
-- ############################################################################
-- ############################################################################

/*
============================================================================
ADVANCED Q56: Recursive CTE - Employee Hierarchy
============================================================================
Topic: Recursive CTE
Company: Google, Amazon, Microsoft
*/

WITH RECURSIVE emp_hierarchy AS (
    -- Base case: Top-level managers (no manager)
    SELECT emp_id, emp_name, manager_id, 1 AS level,
           CAST(emp_name AS CHAR(500)) AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: Employees with managers
    SELECT e.emp_id, e.emp_name, e.manager_id, h.level + 1,
           CONCAT(h.path, ' -> ', e.emp_name)
    FROM employees e
    JOIN emp_hierarchy h ON e.manager_id = h.emp_id
)
SELECT * FROM emp_hierarchy ORDER BY level, emp_name;


/*
============================================================================
ADVANCED Q57: Find consecutive login days for users
============================================================================
Topic: Window Functions + Date Logic
Company: Facebook, LinkedIn, Uber
*/

CREATE TABLE user_logins (
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins VALUES
(1, '2024-01-01'), (1, '2024-01-02'), (1, '2024-01-03'),
(1, '2024-01-05'), (1, '2024-01-06'),
(2, '2024-01-01'), (2, '2024-01-03');

-- Find users with 3+ consecutive login days
WITH login_groups AS (
    SELECT
        user_id,
        login_date,
        DATE_SUB(login_date, INTERVAL ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) DAY) AS grp
    FROM user_logins
)
SELECT user_id, MIN(login_date) AS start_date, MAX(login_date) AS end_date,
       COUNT(*) AS consecutive_days
FROM login_groups
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;


/*
============================================================================
ADVANCED Q58: Find gaps in sequential IDs
============================================================================
Topic: Window Functions (LEAD)
Company: Data Engineering Roles
*/

SELECT
    emp_id + 1 AS gap_start,
    next_id - 1 AS gap_end
FROM (
    SELECT emp_id, LEAD(emp_id) OVER (ORDER BY emp_id) AS next_id
    FROM employees
) gaps
WHERE next_id - emp_id > 1;


/*
============================================================================
ADVANCED Q59: Median salary calculation
============================================================================
Topic: Window Functions
Company: Google, Facebook, Data Science Roles
*/

-- Method 1: Using percentile
SELECT AVG(salary) AS median_salary
FROM (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY salary) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM employees
) ranked
WHERE row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));


/*
============================================================================
ADVANCED Q60: Year-over-Year growth calculation
============================================================================
Topic: Window Functions (LAG)
Company: Finance Companies, Analytics Roles
*/

CREATE TABLE monthly_sales (
    year INT,
    month INT,
    revenue DECIMAL(15,2)
);

INSERT INTO monthly_sales VALUES
(2023, 1, 100000), (2023, 2, 120000), (2023, 3, 115000),
(2024, 1, 130000), (2024, 2, 145000), (2024, 3, 140000);

SELECT
    year,
    month,
    revenue,
    LAG(revenue) OVER (PARTITION BY month ORDER BY year) AS prev_year_revenue,
    ROUND((revenue - LAG(revenue) OVER (PARTITION BY month ORDER BY year)) /
          LAG(revenue) OVER (PARTITION BY month ORDER BY year) * 100, 2) AS yoy_growth_pct
FROM monthly_sales;


/*
============================================================================
ADVANCED Q61: Find employees with highest salary in each department
              without using window functions
============================================================================
Topic: Correlated Subquery
Company: Classic Interview Question!
*/

SELECT e.emp_name, e.salary, e.department_id
FROM employees e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);


/*
============================================================================
ADVANCED Q62: Moving average of last 3 entries
============================================================================
Topic: Window Functions with ROWS frame
Company: Analytics, Finance Companies
*/

SELECT
    emp_name,
    salary,
    AVG(salary) OVER (
        ORDER BY emp_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM employees;


/*
============================================================================
ADVANCED Q63: Cumulative distribution (percentile rank)
============================================================================
Topic: PERCENT_RANK, CUME_DIST
Company: Data Science, Analytics Roles
*/

SELECT
    emp_name,
    salary,
    ROUND(PERCENT_RANK() OVER (ORDER BY salary) * 100, 2) AS percentile_rank,
    ROUND(CUME_DIST() OVER (ORDER BY salary) * 100, 2) AS cumulative_dist
FROM employees;


/*
============================================================================
ADVANCED Q64: Find islands and gaps pattern
============================================================================
Topic: Advanced Window Functions
Company: Amazon, Google, Netflix
*/

-- Find continuous ranges of employee IDs
WITH numbered AS (
    SELECT
        emp_id,
        emp_id - ROW_NUMBER() OVER (ORDER BY emp_id) AS grp
    FROM employees
)
SELECT
    MIN(emp_id) AS range_start,
    MAX(emp_id) AS range_end,
    COUNT(*) AS count_in_range
FROM numbered
GROUP BY grp
ORDER BY range_start;


/*
============================================================================
ADVANCED Q65: Implement pagination with total count
============================================================================
Topic: Window Functions for Pagination
Company: All Web Development Roles
*/

-- Page 2 with 5 items per page, including total count
SELECT
    emp_id,
    emp_name,
    salary,
    COUNT(*) OVER () AS total_records,
    CEILING(COUNT(*) OVER () / 5.0) AS total_pages
FROM employees
ORDER BY emp_id
LIMIT 5 OFFSET 5;


/*
============================================================================
ADVANCED Q66: Find the longest streak of increasing salaries
============================================================================
Topic: Complex Window Functions
Company: Quantitative Finance
*/

WITH salary_direction AS (
    SELECT
        emp_id,
        salary,
        CASE
            WHEN salary > LAG(salary) OVER (ORDER BY emp_id) THEN 1
            ELSE 0
        END AS is_increase
    FROM employees
),
streaks AS (
    SELECT
        emp_id,
        salary,
        is_increase,
        SUM(CASE WHEN is_increase = 0 THEN 1 ELSE 0 END) OVER (ORDER BY emp_id) AS streak_group
    FROM salary_direction
)
SELECT streak_group, COUNT(*) AS streak_length
FROM streaks
WHERE is_increase = 1
GROUP BY streak_group
ORDER BY streak_length DESC
LIMIT 1;


/*
============================================================================
ADVANCED Q67: Unpivot - Convert columns to rows
============================================================================
Topic: UNION ALL for Unpivot
Company: Data Engineering Roles
*/

-- Original: columns for Q1, Q2, Q3, Q4 sales
CREATE TABLE quarterly_sales (
    product_id INT,
    q1_sales DECIMAL(10,2),
    q2_sales DECIMAL(10,2),
    q3_sales DECIMAL(10,2),
    q4_sales DECIMAL(10,2)
);

INSERT INTO quarterly_sales VALUES
(1, 1000, 1500, 1200, 1800),
(2, 2000, 2200, 2100, 2500);

-- Unpivot to rows
SELECT product_id, 'Q1' AS quarter, q1_sales AS sales FROM quarterly_sales
UNION ALL
SELECT product_id, 'Q2', q2_sales FROM quarterly_sales
UNION ALL
SELECT product_id, 'Q3', q3_sales FROM quarterly_sales
UNION ALL
SELECT product_id, 'Q4', q4_sales FROM quarterly_sales
ORDER BY product_id, quarter;


/*
============================================================================
ADVANCED Q68: Dynamic query to find column with max value
============================================================================
Topic: GREATEST function
Company: Amazon, Google
*/

SELECT
    product_id,
    GREATEST(q1_sales, q2_sales, q3_sales, q4_sales) AS max_quarterly_sales,
    CASE GREATEST(q1_sales, q2_sales, q3_sales, q4_sales)
        WHEN q1_sales THEN 'Q1'
        WHEN q2_sales THEN 'Q2'
        WHEN q3_sales THEN 'Q3'
        WHEN q4_sales THEN 'Q4'
    END AS best_quarter
FROM quarterly_sales;


/*
============================================================================
ADVANCED Q69: Detect fraud - Same customer, multiple orders in 1 minute
============================================================================
Topic: SELF JOIN with time window
Company: Finance, E-commerce Companies
*/

CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    txn_time DATETIME,
    amount DECIMAL(10,2)
);

SELECT t1.customer_id, t1.txn_id, t2.txn_id,
       t1.txn_time, t2.txn_time
FROM transactions t1
JOIN transactions t2 ON t1.customer_id = t2.customer_id
WHERE t1.txn_id < t2.txn_id
AND TIMESTAMPDIFF(SECOND, t1.txn_time, t2.txn_time) <= 60;


/*
============================================================================
ADVANCED Q70: Find mutual friends
============================================================================
Topic: SELF JOIN for Graph Problems
Company: Facebook, LinkedIn (Classic!)
*/

CREATE TABLE friendships (
    user1_id INT,
    user2_id INT,
    PRIMARY KEY (user1_id, user2_id)
);

-- Find mutual friends between user 1 and user 2
SELECT f1.user2_id AS mutual_friend
FROM friendships f1
JOIN friendships f2 ON f1.user2_id = f2.user2_id
WHERE f1.user1_id = 1 AND f2.user1_id = 2;


/*
============================================================================
ADVANCED Q71: Sessionization - Group events into sessions
============================================================================
Topic: Window Functions for Session Analysis
Company: Google Analytics, Amplitude, Mixpanel
*/

CREATE TABLE user_events (
    user_id INT,
    event_time DATETIME,
    event_name VARCHAR(50)
);

-- Group events into sessions (30 min inactivity = new session)
WITH time_gaps AS (
    SELECT
        user_id,
        event_time,
        event_name,
        TIMESTAMPDIFF(MINUTE,
            LAG(event_time) OVER (PARTITION BY user_id ORDER BY event_time),
            event_time
        ) AS minutes_since_last
    FROM user_events
)
SELECT
    user_id,
    event_time,
    event_name,
    SUM(CASE WHEN minutes_since_last > 30 OR minutes_since_last IS NULL THEN 1 ELSE 0 END)
        OVER (PARTITION BY user_id ORDER BY event_time) AS session_id
FROM time_gaps;


/*
============================================================================
ADVANCED Q72: Stored Procedure with Error Handling
============================================================================
Topic: Stored Procedures, Transactions
Company: Enterprise Companies
*/

DELIMITER //

CREATE PROCEDURE transfer_funds(
    IN from_emp_id INT,
    IN to_emp_id INT,
    IN amount DECIMAL(10,2),
    OUT status_msg VARCHAR(100)
)
BEGIN
    DECLARE from_salary DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET status_msg = 'Error occurred, transaction rolled back';
    END;

    START TRANSACTION;

    SELECT salary INTO from_salary
    FROM employees
    WHERE emp_id = from_emp_id
    FOR UPDATE;

    IF from_salary < amount THEN
        ROLLBACK;
        SET status_msg = 'Insufficient balance';
    ELSE
        UPDATE employees SET salary = salary - amount WHERE emp_id = from_emp_id;
        UPDATE employees SET salary = salary + amount WHERE emp_id = to_emp_id;
        COMMIT;
        SET status_msg = 'Transfer successful';
    END IF;
END //

DELIMITER ;


/*
============================================================================
ADVANCED Q73: Trigger for audit logging
============================================================================
Topic: Triggers
Company: Banking, Finance Companies
*/

CREATE TABLE salary_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(50)
);

DELIMITER //

CREATE TRIGGER salary_change_audit
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit (emp_id, old_salary, new_salary, changed_by)
        VALUES (OLD.emp_id, OLD.salary, NEW.salary, CURRENT_USER());
    END IF;
END //

DELIMITER ;


/*
============================================================================
ADVANCED Q74: Query to find deadlock-prone queries
============================================================================
Topic: Performance Analysis
Company: DBA Roles, Senior Developer Positions
*/

-- Check for long-running queries
SHOW PROCESSLIST;

-- Check table locks
SHOW OPEN TABLES WHERE In_use > 0;

-- Analyze query execution plan
EXPLAIN ANALYZE
SELECT e.*, d.dept_name
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
WHERE e.salary > 50000;


/*
============================================================================
ADVANCED Q75: Complex Reporting Query - Multiple CTEs and Window Functions
============================================================================
Topic: Comprehensive SQL Skills
Company: Senior/Lead Roles at Any Company
*/

WITH
-- Calculate department statistics
dept_stats AS (
    SELECT
        department_id,
        COUNT(*) AS emp_count,
        AVG(salary) AS avg_salary,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
),
-- Rank employees within department
emp_ranked AS (
    SELECT
        e.*,
        d.dept_name,
        DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS dept_salary_rank,
        PERCENT_RANK() OVER (ORDER BY e.salary) AS overall_percentile
    FROM employees e
    JOIN departments d ON e.department_id = d.dept_id
),
-- Calculate salary bands
salary_bands AS (
    SELECT
        emp_id,
        CASE
            WHEN salary >= 80000 THEN 'Executive'
            WHEN salary >= 60000 THEN 'Senior'
            WHEN salary >= 40000 THEN 'Mid-Level'
            ELSE 'Junior'
        END AS salary_band
    FROM employees
)
-- Final comprehensive report
SELECT
    er.emp_name,
    er.dept_name,
    er.salary,
    sb.salary_band,
    er.dept_salary_rank,
    ROUND(er.overall_percentile * 100, 1) AS salary_percentile,
    ds.avg_salary AS dept_avg_salary,
    ROUND(er.salary - ds.avg_salary, 2) AS diff_from_dept_avg,
    ds.emp_count AS dept_size
FROM emp_ranked er
JOIN dept_stats ds ON er.department_id = ds.department_id
JOIN salary_bands sb ON er.emp_id = sb.emp_id
ORDER BY er.department_id, er.dept_salary_rank;


-- ############################################################################
--                     QUICK REFERENCE TABLES
-- ############################################################################

/*
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DIFFICULTY LEVEL BREAKDOWN                                │
├─────────────────────────────────────────────────────────────────────────────┤
│ EASY (Q1-Q25):     Basic SELECT, WHERE, ORDER BY, GROUP BY, Aggregate       │
│ MEDIUM (Q26-Q55):  JOINs, Subqueries, Window Functions basics, CASE         │
│ ADVANCED (Q56-Q75): Recursive CTE, Complex Window Functions, Optimization   │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                    TOP 10 MOST ASKED QUESTIONS                               │
├─────────────────────────────────────────────────────────────────────────────┤
│ 1. Find Nth highest salary (Q32)                                            │
│ 2. Find duplicates (Q33)                                                    │
│ 3. Employee-Manager relationship (Q30, Q51)                                 │
│ 4. Top N per group (Q44)                                                    │
│ 5. Running totals (Q45)                                                     │
│ 6. Employees above average salary (Q35, Q42)                                │
│ 7. ROW_NUMBER vs RANK vs DENSE_RANK (Q47)                                   │
│ 8. Consecutive days problem (Q57)                                           │
│ 9. Year-over-year growth (Q60)                                              │
│ 10. Pivot/Unpivot (Q53, Q67)                                                │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                    COMPANY-WISE FOCUS AREAS                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│ TCS/Infosys/Wipro:    Easy + Medium (Q1-Q55)                                │
│ Accenture/Cognizant:  Medium level with joins and aggregations              │
│ Amazon/Microsoft:     Medium + Advanced (Window functions, CTEs)            │
│ Google/Facebook:      Advanced (Graph problems, Complex analytics)          │
│ Finance (Goldman):    Time-series, Running calculations                     │
│ Data Science Roles:   Statistical queries, Percentiles, Analytics           │
└─────────────────────────────────────────────────────────────────────────────┘
*/

-- End of SQL Interview Questions Guide
