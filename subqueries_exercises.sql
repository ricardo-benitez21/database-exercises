-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT *
FROM employees
JOIN dept_emp
	USING (emp_no)
WHERE hire_date = 
	(
	SELECT hire_date
	FROM employees
	WHERE emp_no = '101010'
    )
    AND to_date > NOW()
;


-- 2. Find all the titles ever held by all current employees with the first name Aamod.

  SELECT emp_no -- can throw inside my WHERE clause cause its a single column
  FROM employees
  WHERE first_name = 'Aamod'
  ;
			
SELECT DISTINCT title
FROM titles
WHERE emp_no IN
		(
        SELECT emp_no 
  FROM employees
  WHERE first_name = 'Aamod'
  )
AND to_date > NOW()
  ;
        
-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT emp_no
		FROM dept_emp
		WHERE to_date > NOW()
;
        
SELECT COUNT(*) as Count
FROM employees
WHERE emp_no NOT IN 
		(
        SELECT emp_no
		FROM dept_emp
		WHERE to_date > NOW()
        )
;
-- A. 59,900
        
-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT emp_no
FROM dept_manager
WHERE to_date > NOW()
;

SELECT CONCAT(first_name, ' ', last_name) AS female_current_manager
FROM employees 
WHERE gender ='F'
	AND emp_no IN
		(
        SELECT emp_no
	FROM dept_manager
	WHERE to_date > NOW()
    )
;

-- 5. Find all the employees who currently have a higher salary than the companie's overall, historical average salary.

SELECT ROUND(AVG(salary),2)
FROM salaries
;

SELECT COUNT(*)
FROM salaries
WHERE to_date > NOW() -- dont have duplicate employees since I filtered to current
	AND salary >
		(
        SELECT AVG(salary)
		FROM salaries
        )
;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built-in function to calculate the standard deviation.) 
-- What percentage of all salaries is this?

SELECT std(salary)
FROM salaries
WHERE to_date > NOW()
; -- 1 standard deviation

SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW()
; -- current highest salary

SELECT (MAX(salary) - STD(salary)) AS Cutoff
FROM salaries
WHERE to_date > NOW()
;

SELECT COUNT(*)
FROM salaries
WHERE salary >=
	(
    SELECT (MAX(salary) - STD(salary)) AS Cutoff
FROM salaries
WHERE to_date > NOW()
	)
AND to_date > NOW()
;
-- A. 83 current salaries

SELECT COUNT(*)
FROM salaries
WHERE to_date > NOW()
; -- 240,124 current salaries (all)

SELECT 
	(
    SELECT COUNT(*)
	FROM salaries
	WHERE salary >=
	(
    SELECT (MAX(salary) - STD(salary)) AS Cutoff
	FROM salaries
	WHERE to_date > NOW()
	)
	AND to_date > NOW()
)

/ 

(
SELECT count(*)
FROM salaries
WHERE to_date > NOW()
)
* 100
;

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

-- BONUS

-- 1.Find all the department names that currently have female managers.

-- 2.Find the first and last name of the employee with the highest salary.

-- 3.Find the department name that the employee with the highest salary works in.

-- 4. Who is the highest paid employee within each department.