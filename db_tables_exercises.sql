-- List all the databases
SHOW databases; 
-- Write the SQL code necessary to use the albums_db database
USE albums_db;
-- Show the currently selected database

SELECT database();
-- List all tables in the database
SHOW tables;
-- Write the SQL code to switch to the employees database
USE employees;
-- Show the currently selected database
SELECT database ();
-- List all tables in the database
SHOW tables;
DESCRIBE employees;

-- Explore the employees table. What different data types are present in this table? - int, date, varchar(14), varchar(16), enum('M','F')

-- "What table(s) do you think contain a numeric type column?" 
-- All tables, except departments, contain a numeric type column

-- "What table(s) do you think contain a string type column?" 
-- All tables , except salaries, contain a string type column

-- "What table(s) do you think contain a date type column?" 
-- All tables, except departments, contain a date type column

-- "What is the relationship between the employees and the departments tables? 
-- Employees should be linked to a department somehow

-- SQL code for dept_manager is below

-- CREATE TABLE `dept_manager` (
-- `emp_no` int NOT NULL,
-- `dept_no` char(4) NOT NULL,
-- `from_date` date NOT NULL,
-- `to_date` date NOT NULL,
-- PRIMARY KEY (`emp_no`,`dept_no`),
--  KEY `dept_no` (`dept_no`),
-- CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
-- CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1