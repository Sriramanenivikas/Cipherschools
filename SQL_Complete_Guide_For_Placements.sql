-- ============================================================================
-- SQL COMPLETE GUIDE FOR PLACEMENTS - CipherSchools
-- ============================================================================
-- Author: Placement Preparation Guide
-- Topics: DDL, DML, DQL, DCL, TCL, Joins, Subqueries, Transactions & More
-- ============================================================================

-- ############################################################################
--                     SQL COMMAND CATEGORIES OVERVIEW
-- ############################################################################
/*
┌─────────────────────────────────────────────────────────────────────────────┐
│                        SQL COMMAND CLASSIFICATION                            │
├─────────────┬───────────────────────────────────────────────────────────────┤
│ Category    │ Description                                                   │
├─────────────┼───────────────────────────────────────────────────────────────┤
│ DDL         │ Data Definition Language - Structure/Schema operations        │
│ DML         │ Data Manipulation Language - Data operations                  │
│ DQL         │ Data Query Language - Data retrieval                          │
│ DCL         │ Data Control Language - Permissions/Access control            │
│ TCL         │ Transaction Control Language - Transaction management         │
└─────────────┴───────────────────────────────────────────────────────────────┘
*/

-- ############################################################################
--                    1. DDL - DATA DEFINITION LANGUAGE
-- ############################################################################
/*
DDL Commands: CREATE, ALTER, DROP, TRUNCATE, RENAME, COMMENT

Purpose: Define and modify database structure (schema)
Key Point: DDL commands are AUTO-COMMITTED (cannot be rolled back)
*/

-- ============================================================================
-- 1.1 CREATE - Create database objects
-- ============================================================================

-- Create Database
CREATE DATABASE company_db;
USE company_db;

-- Create Table with all constraint types
CREATE TABLE employees (
    emp_id          INT             PRIMARY KEY AUTO_INCREMENT,
    emp_name        VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    UNIQUE,
    department_id   INT,
    salary          DECIMAL(10,2)   DEFAULT 30000.00,
    hire_date       DATE            NOT NULL,
    age             INT             CHECK (age >= 18 AND age <= 65),
    manager_id      INT,
    status          ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key Constraint
    CONSTRAINT fk_department
        FOREIGN KEY (department_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    -- Self-referencing Foreign Key
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Create Table with Composite Primary Key
CREATE TABLE order_items (
    order_id    INT,
    product_id  INT,
    quantity    INT NOT NULL,
    unit_price  DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id)
);

-- Create Index
CREATE INDEX idx_emp_name ON employees(emp_name);
CREATE UNIQUE INDEX idx_email ON employees(email);
CREATE INDEX idx_composite ON employees(department_id, salary);

-- Create View
CREATE VIEW active_employees AS
SELECT emp_id, emp_name, salary, department_id
FROM employees
WHERE status = 'active';

-- Create View with Check Option
CREATE VIEW high_salary_employees AS
SELECT * FROM employees WHERE salary > 50000
WITH CHECK OPTION;

-- ============================================================================
-- 1.2 ALTER - Modify existing database objects
-- ============================================================================

-- Add Column
ALTER TABLE employees ADD COLUMN phone VARCHAR(15);
ALTER TABLE employees ADD COLUMN address VARCHAR(255) AFTER email;

-- Modify Column
ALTER TABLE employees MODIFY COLUMN phone VARCHAR(20) NOT NULL;
ALTER TABLE employees MODIFY COLUMN salary DECIMAL(12,2);

-- Rename Column
ALTER TABLE employees RENAME COLUMN phone TO contact_number;

-- Drop Column
ALTER TABLE employees DROP COLUMN address;

-- Add Constraint
ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);
ALTER TABLE employees ADD CONSTRAINT uk_email UNIQUE (email);

-- Drop Constraint
ALTER TABLE employees DROP CONSTRAINT chk_salary;
ALTER TABLE employees DROP INDEX uk_email;

-- Rename Table
ALTER TABLE employees RENAME TO staff;

-- ============================================================================
-- 1.3 DROP - Delete database objects permanently
-- ============================================================================

DROP TABLE IF EXISTS temp_table;
DROP DATABASE IF EXISTS test_db;
DROP INDEX idx_emp_name ON employees;
DROP VIEW IF EXISTS active_employees;

-- ============================================================================
-- 1.4 TRUNCATE - Remove all records (faster than DELETE)
-- ============================================================================
/*
TRUNCATE vs DELETE:
- TRUNCATE: DDL, faster, resets auto-increment, cannot rollback, no WHERE clause
- DELETE: DML, slower, keeps auto-increment, can rollback, supports WHERE clause
*/

TRUNCATE TABLE temp_logs;

-- ============================================================================
-- 1.5 RENAME - Rename database objects
-- ============================================================================

RENAME TABLE old_table TO new_table;
RENAME TABLE table1 TO table1_backup, table2 TO table2_backup;


-- ############################################################################
--                    2. DML - DATA MANIPULATION LANGUAGE
-- ############################################################################
/*
DML Commands: INSERT, UPDATE, DELETE, MERGE (UPSERT)

Purpose: Manipulate data within tables
Key Point: DML commands can be ROLLED BACK (within a transaction)
*/

-- ============================================================================
-- 2.1 INSERT - Add new records
-- ============================================================================

-- Single Row Insert
INSERT INTO employees (emp_name, email, department_id, salary, hire_date, age)
VALUES ('John Doe', 'john@example.com', 1, 55000.00, '2024-01-15', 28);

-- Multiple Row Insert
INSERT INTO employees (emp_name, email, department_id, salary, hire_date, age)
VALUES
    ('Jane Smith', 'jane@example.com', 2, 62000.00, '2024-02-01', 32),
    ('Bob Wilson', 'bob@example.com', 1, 48000.00, '2024-02-15', 25),
    ('Alice Brown', 'alice@example.com', 3, 71000.00, '2024-03-01', 35);

-- Insert from SELECT
INSERT INTO employee_archive (emp_id, emp_name, salary)
SELECT emp_id, emp_name, salary FROM employees WHERE status = 'inactive';

-- Insert with DEFAULT values
INSERT INTO employees (emp_name, hire_date, age)
VALUES ('New Employee', CURDATE(), 22);

-- Insert IGNORE (skip duplicates)
INSERT IGNORE INTO employees (emp_id, emp_name, hire_date, age)
VALUES (1, 'Duplicate', '2024-01-01', 30);

-- ============================================================================
-- 2.2 UPDATE - Modify existing records
-- ============================================================================

-- Simple Update
UPDATE employees SET salary = 60000.00 WHERE emp_id = 1;

-- Update Multiple Columns
UPDATE employees
SET salary = salary * 1.10,
    status = 'active',
    manager_id = 5
WHERE department_id = 2;

-- Update with JOIN
UPDATE employees e
JOIN departments d ON e.department_id = d.dept_id
SET e.salary = e.salary * 1.15
WHERE d.dept_name = 'Engineering';

-- Update with Subquery
UPDATE employees
SET salary = (SELECT AVG(salary) FROM employees WHERE department_id = 1)
WHERE emp_id = 10;

-- Update with CASE
UPDATE employees
SET salary = CASE
    WHEN age < 25 THEN salary * 1.05
    WHEN age BETWEEN 25 AND 35 THEN salary * 1.10
    ELSE salary * 1.08
END;

-- ============================================================================
-- 2.3 DELETE - Remove records
-- ============================================================================

-- Simple Delete
DELETE FROM employees WHERE emp_id = 5;

-- Delete with Multiple Conditions
DELETE FROM employees
WHERE status = 'inactive' AND hire_date < '2020-01-01';

-- Delete with JOIN
DELETE e FROM employees e
JOIN departments d ON e.department_id = d.dept_id
WHERE d.dept_name = 'Closed Department';

-- Delete with Subquery
DELETE FROM employees
WHERE department_id IN (SELECT dept_id FROM departments WHERE budget < 10000);

-- Delete All (use TRUNCATE for better performance)
DELETE FROM temp_table;

-- ============================================================================
-- 2.4 MERGE / UPSERT - Insert or Update
-- ============================================================================

-- MySQL: INSERT ON DUPLICATE KEY UPDATE
INSERT INTO employees (emp_id, emp_name, salary, hire_date, age)
VALUES (1, 'John Updated', 65000.00, '2024-01-15', 29)
ON DUPLICATE KEY UPDATE
    emp_name = VALUES(emp_name),
    salary = VALUES(salary);

-- MySQL: REPLACE INTO (deletes then inserts)
REPLACE INTO employees (emp_id, emp_name, salary, hire_date, age)
VALUES (1, 'John Replaced', 70000.00, '2024-01-15', 29);

-- SQL Server / Oracle: MERGE Statement
/*
MERGE INTO employees AS target
USING new_employees AS source
ON target.emp_id = source.emp_id
WHEN MATCHED THEN
    UPDATE SET target.salary = source.salary
WHEN NOT MATCHED THEN
    INSERT (emp_id, emp_name, salary)
    VALUES (source.emp_id, source.emp_name, source.salary);
*/


-- ############################################################################
--                    3. DQL - DATA QUERY LANGUAGE
-- ############################################################################
/*
DQL Commands: SELECT

Purpose: Retrieve data from database
Key Point: Most frequently used in interviews!
*/

-- ============================================================================
-- 3.1 SELECT Basics
-- ============================================================================

-- Select All
SELECT * FROM employees;

-- Select Specific Columns
SELECT emp_name, salary, department_id FROM employees;

-- Select with Alias
SELECT
    emp_name AS "Employee Name",
    salary AS "Monthly Salary",
    salary * 12 AS "Annual Salary"
FROM employees;

-- Select DISTINCT
SELECT DISTINCT department_id FROM employees;
SELECT DISTINCT department_id, status FROM employees;

-- ============================================================================
-- 3.2 WHERE Clause - Filtering
-- ============================================================================

-- Comparison Operators
SELECT * FROM employees WHERE salary > 50000;
SELECT * FROM employees WHERE salary >= 50000;
SELECT * FROM employees WHERE salary <> 50000;  -- Not equal
SELECT * FROM employees WHERE salary != 50000;  -- Not equal (alternative)

-- Logical Operators
SELECT * FROM employees WHERE salary > 50000 AND department_id = 1;
SELECT * FROM employees WHERE salary > 70000 OR department_id = 2;
SELECT * FROM employees WHERE NOT status = 'inactive';

-- BETWEEN (inclusive)
SELECT * FROM employees WHERE salary BETWEEN 40000 AND 60000;
SELECT * FROM employees WHERE hire_date BETWEEN '2024-01-01' AND '2024-12-31';

-- IN Operator
SELECT * FROM employees WHERE department_id IN (1, 2, 3);
SELECT * FROM employees WHERE status IN ('active', 'on_leave');

-- LIKE Pattern Matching
SELECT * FROM employees WHERE emp_name LIKE 'J%';      -- Starts with J
SELECT * FROM employees WHERE emp_name LIKE '%son';    -- Ends with son
SELECT * FROM employees WHERE emp_name LIKE '%oh%';    -- Contains oh
SELECT * FROM employees WHERE emp_name LIKE 'J___';    -- J followed by 3 chars
SELECT * FROM employees WHERE email LIKE '%@gmail.com';

-- IS NULL / IS NOT NULL
SELECT * FROM employees WHERE manager_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NOT NULL;

-- ============================================================================
-- 3.3 ORDER BY - Sorting Results
-- ============================================================================

SELECT * FROM employees ORDER BY salary;              -- Ascending (default)
SELECT * FROM employees ORDER BY salary ASC;          -- Ascending
SELECT * FROM employees ORDER BY salary DESC;         -- Descending
SELECT * FROM employees ORDER BY department_id, salary DESC;  -- Multiple columns
SELECT * FROM employees ORDER BY 3;                   -- By column position

-- ============================================================================
-- 3.4 LIMIT / OFFSET - Pagination
-- ============================================================================

SELECT * FROM employees LIMIT 10;                     -- First 10 rows
SELECT * FROM employees LIMIT 10 OFFSET 20;           -- Skip 20, get next 10
SELECT * FROM employees LIMIT 20, 10;                 -- Same as above (MySQL)

-- Top N per group (Interview favorite!)
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;  -- Top 5 salaries

-- ============================================================================
-- 3.5 GROUP BY and Aggregate Functions
-- ============================================================================

-- Aggregate Functions
SELECT
    COUNT(*) AS total_employees,
    COUNT(DISTINCT department_id) AS total_departments,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;

-- GROUP BY
SELECT
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- GROUP BY with Multiple Columns
SELECT
    department_id,
    status,
    COUNT(*) AS emp_count
FROM employees
GROUP BY department_id, status;

-- HAVING Clause (filter after grouping)
SELECT
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5 AND AVG(salary) > 50000;

-- WHERE vs HAVING
/*
WHERE: Filters BEFORE grouping (on individual rows)
HAVING: Filters AFTER grouping (on aggregated results)
*/

SELECT department_id, AVG(salary)
FROM employees
WHERE status = 'active'           -- Filter rows first
GROUP BY department_id
HAVING AVG(salary) > 50000;       -- Then filter groups


-- ############################################################################
--                    4. DCL - DATA CONTROL LANGUAGE
-- ############################################################################
/*
DCL Commands: GRANT, REVOKE

Purpose: Control access and permissions
Key Point: Security and access management
*/

-- ============================================================================
-- 4.1 GRANT - Give permissions
-- ============================================================================

-- Grant specific privileges
GRANT SELECT ON company_db.employees TO 'user1'@'localhost';
GRANT SELECT, INSERT, UPDATE ON company_db.employees TO 'user2'@'localhost';

-- Grant all privileges on a table
GRANT ALL PRIVILEGES ON company_db.employees TO 'admin'@'localhost';

-- Grant all privileges on database
GRANT ALL PRIVILEGES ON company_db.* TO 'admin'@'localhost';

-- Grant with GRANT OPTION (user can grant to others)
GRANT SELECT ON company_db.employees TO 'user1'@'localhost' WITH GRANT OPTION;

-- Create user and grant
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, INSERT ON company_db.* TO 'newuser'@'localhost';

-- ============================================================================
-- 4.2 REVOKE - Remove permissions
-- ============================================================================

REVOKE SELECT ON company_db.employees FROM 'user1'@'localhost';
REVOKE ALL PRIVILEGES ON company_db.* FROM 'user2'@'localhost';
REVOKE GRANT OPTION ON company_db.employees FROM 'user1'@'localhost';

-- ============================================================================
-- 4.3 Privilege Types
-- ============================================================================
/*
┌────────────────┬──────────────────────────────────────────────────────────┐
│ Privilege      │ Description                                              │
├────────────────┼──────────────────────────────────────────────────────────┤
│ SELECT         │ Read data from tables                                    │
│ INSERT         │ Add new records                                          │
│ UPDATE         │ Modify existing records                                  │
│ DELETE         │ Remove records                                           │
│ CREATE         │ Create new tables/databases                              │
│ DROP           │ Delete tables/databases                                  │
│ ALTER          │ Modify table structure                                   │
│ INDEX          │ Create/drop indexes                                      │
│ EXECUTE        │ Run stored procedures                                    │
│ ALL PRIVILEGES │ All available privileges                                 │
└────────────────┴──────────────────────────────────────────────────────────┘
*/


-- ############################################################################
--                    5. TCL - TRANSACTION CONTROL LANGUAGE
-- ############################################################################
/*
TCL Commands: COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION

Purpose: Manage transactions for data integrity
Key Point: ACID Properties - Atomicity, Consistency, Isolation, Durability
*/

-- ============================================================================
-- 5.1 ACID Properties Explained
-- ============================================================================
/*
┌─────────────┬────────────────────────────────────────────────────────────────┐
│ Property    │ Description                                                    │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ ATOMICITY   │ All or nothing - entire transaction succeeds or fails          │
│ CONSISTENCY │ Database remains in valid state before and after transaction   │
│ ISOLATION   │ Concurrent transactions don't interfere with each other        │
│ DURABILITY  │ Committed changes are permanent, even after system failure     │
└─────────────┴────────────────────────────────────────────────────────────────┘
*/

-- ============================================================================
-- 5.2 Basic Transaction Control
-- ============================================================================

-- Start Transaction
START TRANSACTION;
-- OR
BEGIN;
-- OR
BEGIN TRANSACTION;

-- Commit Transaction (save changes permanently)
START TRANSACTION;
UPDATE accounts SET balance = balance - 1000 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 1000 WHERE account_id = 2;
COMMIT;

-- Rollback Transaction (undo all changes)
START TRANSACTION;
DELETE FROM employees WHERE department_id = 5;
-- Oops! Wrong department
ROLLBACK;

-- ============================================================================
-- 5.3 SAVEPOINT - Partial Rollback
-- ============================================================================

START TRANSACTION;

INSERT INTO employees (emp_name, hire_date, age) VALUES ('Emp1', CURDATE(), 25);
SAVEPOINT sp1;

INSERT INTO employees (emp_name, hire_date, age) VALUES ('Emp2', CURDATE(), 30);
SAVEPOINT sp2;

INSERT INTO employees (emp_name, hire_date, age) VALUES ('Emp3', CURDATE(), 28);
-- Something went wrong with Emp3

ROLLBACK TO sp2;  -- Undo Emp3, keep Emp1 and Emp2

COMMIT;  -- Emp1 and Emp2 are saved

-- Release Savepoint
RELEASE SAVEPOINT sp1;

-- ============================================================================
-- 5.4 Transaction Isolation Levels
-- ============================================================================
/*
┌──────────────────┬─────────────┬──────────────────┬───────────────┐
│ Isolation Level  │ Dirty Read  │ Non-Repeatable   │ Phantom Read  │
│                  │             │ Read             │               │
├──────────────────┼─────────────┼──────────────────┼───────────────┤
│ READ UNCOMMITTED │ Possible    │ Possible         │ Possible      │
│ READ COMMITTED   │ Not Possible│ Possible         │ Possible      │
│ REPEATABLE READ  │ Not Possible│ Not Possible     │ Possible      │
│ SERIALIZABLE     │ Not Possible│ Not Possible     │ Not Possible  │
└──────────────────┴─────────────┴──────────────────┴───────────────┘

Dirty Read: Reading uncommitted data from another transaction
Non-Repeatable Read: Same query returns different results within same transaction
Phantom Read: New rows appear in repeated query due to other transaction's insert
*/

-- Set Isolation Level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Check current isolation level
SELECT @@transaction_isolation;

-- ============================================================================
-- 5.5 Auto-commit Mode
-- ============================================================================

-- Check auto-commit status
SELECT @@autocommit;

-- Disable auto-commit (each statement needs explicit COMMIT)
SET autocommit = 0;

-- Enable auto-commit (default)
SET autocommit = 1;

-- ============================================================================
-- 5.6 Practical Transaction Example - Bank Transfer
-- ============================================================================

DELIMITER //

CREATE PROCEDURE transfer_money(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE current_balance DECIMAL(10,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction failed and rolled back' AS status;
    END;

    START TRANSACTION;

    -- Check balance
    SELECT balance INTO current_balance
    FROM accounts WHERE account_id = from_account FOR UPDATE;

    IF current_balance < amount THEN
        ROLLBACK;
        SELECT 'Insufficient funds' AS status;
    ELSE
        -- Debit from source account
        UPDATE accounts SET balance = balance - amount
        WHERE account_id = from_account;

        -- Credit to destination account
        UPDATE accounts SET balance = balance + amount
        WHERE account_id = to_account;

        COMMIT;
        SELECT 'Transfer successful' AS status;
    END IF;
END //

DELIMITER ;


-- ############################################################################
--                           6. SQL JOINS
-- ############################################################################
/*
Joins combine rows from two or more tables based on related columns
MOST IMPORTANT TOPIC FOR PLACEMENTS!
*/

-- Sample Tables for Join Examples
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees_join (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO departments VALUES
(1, 'Engineering', 'Building A'),
(2, 'Marketing', 'Building B'),
(3, 'HR', 'Building C'),
(4, 'Finance', 'Building D');

INSERT INTO employees_join VALUES
(101, 'John', 1, 60000),
(102, 'Jane', 2, 55000),
(103, 'Bob', 1, 70000),
(104, 'Alice', NULL, 50000),
(105, 'Charlie', 3, 45000);

-- ============================================================================
-- 6.1 INNER JOIN - Only matching rows from both tables
-- ============================================================================
/*
     ┌─────────┐     ┌─────────┐
     │    A    │     │    B    │
     │   ┌─────┼─────┼─────┐   │
     │   │█████│█████│█████│   │
     │   └─────┼─────┼─────┘   │
     └─────────┘     └─────────┘
           Only the intersection
*/

SELECT e.emp_id, e.emp_name, e.salary, d.dept_name, d.location
FROM employees_join e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- Using implicit join (older syntax)
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees_join e, departments d
WHERE e.dept_id = d.dept_id;

-- ============================================================================
-- 6.2 LEFT JOIN (LEFT OUTER JOIN) - All from left + matching from right
-- ============================================================================
/*
     ┌─────────┐     ┌─────────┐
     │█████████│     │    B    │
     │███┌─────┼─────┼─────┐   │
     │███│█████│█████│█████│   │
     │███└─────┼─────┼─────┘   │
     └─────────┘     └─────────┘
      All of A + matching B
*/

SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
FROM employees_join e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- Find employees without department
SELECT e.emp_name
FROM employees_join e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- ============================================================================
-- 6.3 RIGHT JOIN (RIGHT OUTER JOIN) - All from right + matching from left
-- ============================================================================
/*
     ┌─────────┐     ┌─────────┐
     │    A    │     │█████████│
     │   ┌─────┼─────┼─────┐███│
     │   │█████│█████│█████│███│
     │   └─────┼─────┼─────┘███│
     └─────────┘     └─────────┘
      Matching A + all of B
*/

SELECT e.emp_name, d.dept_id, d.dept_name
FROM employees_join e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- Find departments without employees
SELECT d.dept_name
FROM employees_join e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- ============================================================================
-- 6.4 FULL OUTER JOIN - All rows from both tables
-- ============================================================================
/*
     ┌─────────┐     ┌─────────┐
     │█████████│     │█████████│
     │███┌─────┼─────┼─────┐███│
     │███│█████│█████│█████│███│
     │███└─────┼─────┼─────┘███│
     └─────────┘     └─────────┘
           All from both
*/

-- MySQL doesn't support FULL OUTER JOIN directly, use UNION
SELECT e.emp_name, d.dept_name
FROM employees_join e
LEFT JOIN departments d ON e.dept_id = d.dept_id

UNION

SELECT e.emp_name, d.dept_name
FROM employees_join e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================================================
-- 6.5 CROSS JOIN - Cartesian Product (all combinations)
-- ============================================================================
/*
Every row from A combined with every row from B
Result rows = rows_A × rows_B
*/

SELECT e.emp_name, d.dept_name
FROM employees_join e
CROSS JOIN departments d;

-- Alternative syntax
SELECT e.emp_name, d.dept_name
FROM employees_join e, departments d;

-- ============================================================================
-- 6.6 SELF JOIN - Table joined with itself
-- ============================================================================

-- Find employees and their managers
CREATE TABLE emp_hierarchy (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO emp_hierarchy VALUES
(1, 'CEO', NULL),
(2, 'CTO', 1),
(3, 'CFO', 1),
(4, 'Developer', 2),
(5, 'Accountant', 3);

SELECT
    e.emp_name AS employee,
    m.emp_name AS manager
FROM emp_hierarchy e
LEFT JOIN emp_hierarchy m ON e.manager_id = m.emp_id;

-- Find employees earning more than their managers
SELECT
    e1.emp_name AS employee,
    e1.salary AS emp_salary,
    e2.emp_name AS manager,
    e2.salary AS mgr_salary
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.emp_id
WHERE e1.salary > e2.salary;

-- ============================================================================
-- 6.7 NATURAL JOIN - Automatic join on common columns
-- ============================================================================

-- Automatically joins on columns with same name
SELECT * FROM employees_join NATURAL JOIN departments;

-- WARNING: Be careful, may join on unintended columns!

-- ============================================================================
-- 6.8 Multiple Table Joins
-- ============================================================================

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    dept_id INT
);

SELECT
    e.emp_name,
    d.dept_name,
    p.project_name
FROM employees_join e
JOIN departments d ON e.dept_id = d.dept_id
JOIN projects p ON d.dept_id = p.dept_id;

-- ============================================================================
-- 6.9 Join Performance Tips
-- ============================================================================
/*
1. Always use indexed columns in JOIN conditions
2. Put the smaller table on the left side of LEFT JOIN
3. Use INNER JOIN when possible (faster than OUTER JOIN)
4. Avoid joining on functions: JOIN ON YEAR(e.date) = YEAR(d.date)
5. Use EXISTS instead of IN for large subqueries
*/


-- ############################################################################
--                        7. SUBQUERIES
-- ############################################################################

-- ============================================================================
-- 7.1 Scalar Subquery (returns single value)
-- ============================================================================

SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ============================================================================
-- 7.2 Row Subquery (returns single row)
-- ============================================================================

SELECT * FROM employees
WHERE (department_id, salary) = (
    SELECT department_id, MAX(salary)
    FROM employees
    GROUP BY department_id
    LIMIT 1
);

-- ============================================================================
-- 7.3 Table Subquery (returns multiple rows/columns)
-- ============================================================================

SELECT * FROM employees
WHERE department_id IN (
    SELECT dept_id FROM departments WHERE location = 'Building A'
);

-- ============================================================================
-- 7.4 Correlated Subquery (references outer query)
-- ============================================================================

-- Find employees earning above their department's average
SELECT e1.emp_name, e1.salary, e1.department_id
FROM employees e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);

-- ============================================================================
-- 7.5 EXISTS / NOT EXISTS
-- ============================================================================

-- Find departments that have employees
SELECT d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.dept_id
);

-- Find departments without employees
SELECT d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.dept_id
);

-- ============================================================================
-- 7.6 Subquery in FROM clause (Derived Table)
-- ============================================================================

SELECT dept_id, avg_salary
FROM (
    SELECT department_id AS dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_averages
WHERE avg_salary > 50000;


-- ############################################################################
--                     8. WINDOW FUNCTIONS
-- ############################################################################
/*
Window functions perform calculations across a set of rows
without collapsing them into a single output row (unlike GROUP BY)
*/

-- ============================================================================
-- 8.1 ROW_NUMBER, RANK, DENSE_RANK
-- ============================================================================

SELECT
    emp_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK() OVER (ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_num
FROM employees;

/*
ROW_NUMBER: 1, 2, 3, 4, 5 (always unique)
RANK:       1, 2, 2, 4, 5 (gaps after ties)
DENSE_RANK: 1, 2, 2, 3, 4 (no gaps after ties)
*/

-- ============================================================================
-- 8.2 PARTITION BY
-- ============================================================================

-- Rank within each department
SELECT
    emp_name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;

-- Get top 3 earners per department (COMMON INTERVIEW QUESTION!)
SELECT * FROM (
    SELECT
        emp_name,
        department_id,
        salary,
        DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk <= 3;

-- ============================================================================
-- 8.3 LAG and LEAD
-- ============================================================================

SELECT
    emp_name,
    salary,
    LAG(salary, 1) OVER (ORDER BY hire_date) AS prev_salary,
    LEAD(salary, 1) OVER (ORDER BY hire_date) AS next_salary,
    salary - LAG(salary, 1) OVER (ORDER BY hire_date) AS salary_diff
FROM employees;

-- ============================================================================
-- 8.4 Running Totals and Moving Averages
-- ============================================================================

SELECT
    emp_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS running_total,
    AVG(salary) OVER (ORDER BY hire_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM employees;

-- ============================================================================
-- 8.5 FIRST_VALUE, LAST_VALUE, NTH_VALUE
-- ============================================================================

SELECT
    emp_name,
    department_id,
    salary,
    FIRST_VALUE(emp_name) OVER (PARTITION BY department_id ORDER BY salary DESC) AS highest_paid,
    LAST_VALUE(emp_name) OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_paid
FROM employees;


-- ############################################################################
--                     9. SET OPERATIONS
-- ############################################################################

-- ============================================================================
-- 9.1 UNION (removes duplicates)
-- ============================================================================

SELECT emp_name, salary FROM employees WHERE department_id = 1
UNION
SELECT emp_name, salary FROM employees WHERE salary > 60000;

-- ============================================================================
-- 9.2 UNION ALL (keeps duplicates - faster)
-- ============================================================================

SELECT emp_name FROM current_employees
UNION ALL
SELECT emp_name FROM former_employees;

-- ============================================================================
-- 9.3 INTERSECT (common rows)
-- ============================================================================

-- MySQL doesn't have INTERSECT, use INNER JOIN or IN
SELECT emp_name FROM employees WHERE department_id = 1
AND emp_name IN (SELECT emp_name FROM employees WHERE salary > 50000);

-- ============================================================================
-- 9.4 EXCEPT/MINUS (rows in first but not in second)
-- ============================================================================

-- MySQL doesn't have EXCEPT, use NOT IN or LEFT JOIN
SELECT emp_name FROM employees WHERE department_id = 1
AND emp_name NOT IN (SELECT emp_name FROM former_employees);


-- ############################################################################
--                    10. COMMON TABLE EXPRESSIONS (CTE)
-- ############################################################################

-- ============================================================================
-- 10.1 Basic CTE
-- ============================================================================

WITH high_earners AS (
    SELECT emp_id, emp_name, salary, department_id
    FROM employees
    WHERE salary > 60000
)
SELECT h.emp_name, h.salary, d.dept_name
FROM high_earners h
JOIN departments d ON h.department_id = d.dept_id;

-- ============================================================================
-- 10.2 Multiple CTEs
-- ============================================================================

WITH
dept_stats AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),
high_paying_depts AS (
    SELECT department_id
    FROM dept_stats
    WHERE avg_salary > 55000
)
SELECT e.*
FROM employees e
WHERE e.department_id IN (SELECT department_id FROM high_paying_depts);

-- ============================================================================
-- 10.3 Recursive CTE (for hierarchical data)
-- ============================================================================

WITH RECURSIVE employee_hierarchy AS (
    -- Base case: CEO (no manager)
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM emp_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: employees with managers
    SELECT e.emp_id, e.emp_name, e.manager_id, h.level + 1
    FROM emp_hierarchy e
    JOIN employee_hierarchy h ON e.manager_id = h.emp_id
)
SELECT * FROM employee_hierarchy;


-- ############################################################################
--                    11. INDEXES
-- ############################################################################

-- ============================================================================
-- 11.1 Index Types and Creation
-- ============================================================================

-- Single Column Index
CREATE INDEX idx_emp_name ON employees(emp_name);

-- Composite Index (order matters!)
CREATE INDEX idx_dept_salary ON employees(department_id, salary);

-- Unique Index
CREATE UNIQUE INDEX idx_email ON employees(email);

-- Full-text Index
CREATE FULLTEXT INDEX idx_description ON products(description);

-- ============================================================================
-- 11.2 When to Use Indexes
-- ============================================================================
/*
USE indexes on:
- Primary keys (auto-indexed)
- Foreign keys
- Columns in WHERE clauses
- Columns in JOIN conditions
- Columns in ORDER BY

AVOID indexes on:
- Small tables
- Columns with low selectivity (gender, status)
- Frequently updated columns
- Columns rarely used in queries
*/

-- ============================================================================
-- 11.3 Index Analysis
-- ============================================================================

SHOW INDEX FROM employees;
EXPLAIN SELECT * FROM employees WHERE emp_name = 'John';
EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 1;


-- ############################################################################
--                    12. STORED PROCEDURES & FUNCTIONS
-- ############################################################################

-- ============================================================================
-- 12.1 Stored Procedure
-- ============================================================================

DELIMITER //

CREATE PROCEDURE get_employees_by_dept(IN dept_id INT)
BEGIN
    SELECT emp_id, emp_name, salary
    FROM employees
    WHERE department_id = dept_id
    ORDER BY salary DESC;
END //

DELIMITER ;

-- Call procedure
CALL get_employees_by_dept(1);

-- ============================================================================
-- 12.2 Stored Function
-- ============================================================================

DELIMITER //

CREATE FUNCTION calculate_bonus(salary DECIMAL(10,2), rating INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);

    IF rating >= 5 THEN
        SET bonus = salary * 0.20;
    ELSEIF rating >= 3 THEN
        SET bonus = salary * 0.10;
    ELSE
        SET bonus = salary * 0.05;
    END IF;

    RETURN bonus;
END //

DELIMITER ;

-- Use function
SELECT emp_name, salary, calculate_bonus(salary, 4) AS bonus FROM employees;


-- ############################################################################
--                    13. TRIGGERS
-- ############################################################################

DELIMITER //

CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.emp_name = UPPER(NEW.emp_name);
END //

CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action, action_date)
    VALUES (OLD.emp_id, 'DELETE', NOW());
END //

DELIMITER ;


-- ############################################################################
--               14. COMMON INTERVIEW QUESTIONS & PATTERNS
-- ############################################################################

-- ============================================================================
-- Q1: Find Nth highest salary
-- ============================================================================

-- Method 1: Using LIMIT OFFSET
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;  -- 3rd highest (N-1)

-- Method 2: Using Subquery
SELECT MAX(salary) AS third_highest
FROM employees
WHERE salary < (
    SELECT MAX(salary) FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);

-- Method 3: Using DENSE_RANK (Most flexible)
SELECT salary FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 3;

-- ============================================================================
-- Q2: Find duplicate records
-- ============================================================================

SELECT email, COUNT(*) AS count
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

-- ============================================================================
-- Q3: Delete duplicate records (keep one)
-- ============================================================================

DELETE e1 FROM employees e1
INNER JOIN employees e2
WHERE e1.emp_id > e2.emp_id AND e1.email = e2.email;

-- ============================================================================
-- Q4: Find employees with same salary
-- ============================================================================

SELECT e1.emp_name, e2.emp_name, e1.salary
FROM employees e1
JOIN employees e2 ON e1.salary = e2.salary AND e1.emp_id < e2.emp_id;

-- ============================================================================
-- Q5: Department with highest average salary
-- ============================================================================

SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY avg_salary DESC
LIMIT 1;

-- ============================================================================
-- Q6: Employees who joined in last 30 days
-- ============================================================================

SELECT * FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- ============================================================================
-- Q7: Running total of salaries
-- ============================================================================

SELECT
    emp_name,
    salary,
    SUM(salary) OVER (ORDER BY emp_id) AS running_total
FROM employees;

-- ============================================================================
-- Q8: Find gaps in sequential IDs
-- ============================================================================

SELECT t1.emp_id + 1 AS gap_start,
       MIN(t2.emp_id) - 1 AS gap_end
FROM employees t1
JOIN employees t2 ON t1.emp_id < t2.emp_id
WHERE t1.emp_id + 1 NOT IN (SELECT emp_id FROM employees)
GROUP BY t1.emp_id;

-- ============================================================================
-- Q9: Pivot table (rows to columns)
-- ============================================================================

SELECT
    emp_name,
    MAX(CASE WHEN month = 'Jan' THEN sales END) AS Jan,
    MAX(CASE WHEN month = 'Feb' THEN sales END) AS Feb,
    MAX(CASE WHEN month = 'Mar' THEN sales END) AS Mar
FROM monthly_sales
GROUP BY emp_name;

-- ============================================================================
-- Q10: Find consecutive dates
-- ============================================================================

SELECT DISTINCT e1.login_date
FROM logins e1
JOIN logins e2 ON e1.user_id = e2.user_id
    AND e2.login_date = DATE_ADD(e1.login_date, INTERVAL 1 DAY)
JOIN logins e3 ON e1.user_id = e3.user_id
    AND e3.login_date = DATE_ADD(e1.login_date, INTERVAL 2 DAY);


-- ############################################################################
--                    15. QUICK REFERENCE CHEAT SHEET
-- ############################################################################
/*
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SQL EXECUTION ORDER                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│  1. FROM       - Tables are joined                                          │
│  2. WHERE      - Rows are filtered                                          │
│  3. GROUP BY   - Rows are grouped                                           │
│  4. HAVING     - Groups are filtered                                        │
│  5. SELECT     - Columns are selected                                       │
│  6. DISTINCT   - Duplicates are removed                                     │
│  7. ORDER BY   - Results are sorted                                         │
│  8. LIMIT      - Results are limited                                        │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         NULL HANDLING                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│  NULL = NULL      → NULL (not TRUE!)                                        │
│  NULL <> NULL     → NULL                                                    │
│  NULL + 5         → NULL                                                    │
│  COALESCE(a,b,c)  → First non-null value                                    │
│  NULLIF(a,b)      → NULL if a=b, else a                                     │
│  IFNULL(a,b)      → b if a is NULL (MySQL)                                  │
│  NVL(a,b)         → b if a is NULL (Oracle)                                 │
│  ISNULL(a,b)      → b if a is NULL (SQL Server)                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         STRING FUNCTIONS                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│  CONCAT(a,b)         → 'ab'                                                 │
│  LENGTH('hello')     → 5                                                    │
│  UPPER/LOWER         → Case conversion                                      │
│  TRIM/LTRIM/RTRIM    → Remove spaces                                        │
│  SUBSTRING(s,1,3)    → First 3 chars                                        │
│  REPLACE(s,'a','b')  → Replace characters                                   │
│  INSTR(s,'x')        → Position of x                                        │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         DATE FUNCTIONS                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│  NOW() / CURRENT_TIMESTAMP  → Current datetime                              │
│  CURDATE()                  → Current date                                  │
│  DATE_ADD(d, INTERVAL 1 DAY)→ Add time                                      │
│  DATEDIFF(d1, d2)           → Days between                                  │
│  YEAR/MONTH/DAY(date)       → Extract parts                                 │
│  DATE_FORMAT(d, '%Y-%m')    → Format date                                   │
└─────────────────────────────────────────────────────────────────────────────┘
*/

-- End of SQL Complete Guide
