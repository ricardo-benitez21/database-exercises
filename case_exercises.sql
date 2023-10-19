-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee'
-- that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

SELECT emp_no, first_name, last_name, dept_no, from_date, to_date,
	IF(to_date > NOW(), True, False) AS is_current_employee
FROM employees
	JOIN dept_emp
		USING (emp_no)
;


-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group'
-- that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
    last_name,
    CASE
        WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
    END AS alpha_group
FROM employees
;


-- 3. How many employees (current or previous) were born in each decade?

SELECT
	CASE
		WHEN birth_date >= '1950-01-01' AND birth_date <= '1959-12-31' THEN '50s'
        WHEN birth_date >= '1960-01-01' AND birth_date <= '1969-12-31' THEN '60s'
        END AS Decade_Born_In,
        COUNT(*) as cnt
FROM employees
GROUP BY Decade_Born_In
;

-- What is the current average salary for each of the following department groups:
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT 
    CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('finance', 'human resources') THEN 'Finance & HR'
       ELSE 'Customer Service'
   END AS dept_group
   , ROUND(AVG(salary),2) AS avg_salary
FROM departments AS d
	JOIN dept_emp AS de
		USING (dept_no)
	JOIN salaries AS s
		USING (emp_no)
WHERE s.to_date > NOW()
	AND de.to_date > NOW()
GROUP BY dept_group
;

    



-- BONUS

-- Remove duplicate employees from exercise 1.

select 
	e.emp_no
	, concat(e.first_name, ' ', e.last_name) as full_name
    , de.dept_no
    , de.from_date
    , de.to_date
    , IF(de.to_date > now(), True, False) as 'is_current_employee'
from employees as e
	join dept_emp as de
		using (emp_no)
	join 
		( 
        select emp_no, max(to_date) as to_date
        from dept_emp
        group by emp_no
        ) as md
        on e.emp_no = md.emp_no
			and de.to_date = md.to_date
;
        