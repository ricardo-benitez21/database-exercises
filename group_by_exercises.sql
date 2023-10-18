-- 1. Create a new file named group_by_exercises.sql

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
from titles;
-- A. 7

-- 3. Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%' -- or 'E%E'
	and last_name LIKE '%E'
GROUP BY last_name;

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%' -- or 'E%E'
	AND last_name LIKE '%E'
GROUP BY first_name, last_name;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- A. The names are Chleq, Lindqvist, and Qiwen
    
-- 6. Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
SELECT last_name, COUNT(*) AS Count
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
    
-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.
SELECT first_name, gender, COUNT(*) AS count
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name ASC;

-- 8. Using your query that generates a username for all employees, generate a count of employees with each unique username. 
SELECT
	lower(concat(
    left(first_name, 1)
    ,left(last_name, 4)
    ,'_'
    ,substr(birth_date, 6, 2)
    ,substr(birth_date, 3, 2)))
	  AS username,
      COUNT(*) as Count
FROM employees
GROUP BY username
HAVING Count > 1
ORDER BY Count DESC;


-- 9. From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there?
-- A: 6 times

-- Bonus: More practice with aggregate functions:

-- 1B. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SELECT emp_no, AVG(salary) -- could add ROUND before AVG to make it cleaner
FROM salaries
GROUP BY emp_no;

-- 2B. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no, COUNT(*) AS Count
FROM dept_emp
WHERE to_date = '9999-01-01'
GROUP BY dept_no;

-- 3B. Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no, COUNT(*) AS Count
FROM salaries
GROUP BY emp_no;

-- 4B. Find the maximum salary for each employee.
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;

-- 5B. Find the minimum salary for each employee.
SELECT emp_no, MIN(salary)
FROM salaries
GROUP BY emp_no;

-- 6B. Find the standard deviation of salaries for each employee.
SELECT emp_no, ROUND (STD(salary), 1) -- STD or STDDEV for standard deviation
FROM salaries
GROUP BY emp_no;


-- 7B. Find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no, MAX(salary) as Max_Sal
FROM salaries
GROUP BY emp_no
HAVING Max_Sal > 150000;

-- 8B. Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, ROUND(AVG(salary), 1) AS Avg_Sal
FROM salaries
GROUP BY emp_no
HAVING Avg_Sal BETWEEN 80000 AND 90000;