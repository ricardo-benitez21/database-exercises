## Join Example Database

-- Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

SELECT * 
FROM users;

SELECT *
FROM roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson.
-- Before you run each query, guess the expected number of results.

SELECT *
FROM roles r
JOIN users u
	ON r.id=u.role_id;

SELECT *
FROM roles r
LEFT JOIN users u
	ON r.id=u.role_id;

SELECT *
FROM roles r
RIGHT JOIN users u
	ON r.id=u.role_id;
    
-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries.
-- Use count and the appropriate join type to get a list of roles along with the number of users that have the role.
-- Hint: You will also need to use group by in the query.

select 	
	count(u.id), -- to explicitly count users,
    r.name
from roles r
left join users u 
	on r.id=u.role_id
group by r.name;


## Employees Database

-- 1. Use the employees database.

USE employees;

-- 2.Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT 
	d.dept_name AS 'Department Name',
    CONCAT(e.first_name, ' ',e.last_name) as 'Department Manager'
FROM departments d
JOIN dept_manager dm
	ON d.dept_no=dm.dept_no
JOIN employees e
	ON e.emp_no=dm.emp_no
WHERE dm.to_date > NOW()
ORDER BY dept_name;
  
--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang

-- 3. Find the name of all departments currently managed by women.

SELECT 
	d.dept_name AS 'Department Name',
    CONCAT(e.first_name, ' ',e.last_name) as 'Manager Name'
FROM departments d
JOIN dept_manager dm
	ON d.dept_no=dm.dept_no
JOIN employees e
	ON e.emp_no=dm.emp_no
WHERE e.gender = 'F'
ORDER BY dept_name;

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT
	t.title as Title,
    COUNT(de.emp_no) AS Count
FROM titles t
JOIN dept_emp de
	ON t.emp_no=de.emp_no AND
    t.to_date > NOW() AND
    de.to_date > NOW()
JOIN departments d
	ON d.dept_no=de.dept_no
WHERE d.dept_name = 'Customer Service'
GROUP BY t.title
ORDER BY t.title;

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

-- 5. Find the current salary of all current managers.

SELECT
	d.dept_name AS 'Department Name',
    CONCAT(e.first_name, ' ',e.last_name) as 'Name',
    s.salary AS Salary
FROM salaries s
JOIN dept_manager dm
	ON s.emp_no=dm_emp_no AND
    dm.to_date > NOW() AND
    s.to_date > NOW()
JOIN employees e
	ON e.emp_no=dm.emp_no
JOIN departments d
	ON d.dept_no=de.dept_no
ORDER BY d.dept_name;
    

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

-- 6. Find the number of current employees in each department.

SELECT
	d.dept_no,
    d.dept_name,
    COUNT(de.dept_no) AS num_employees
FROM departments d
JOIN dept_emp de
	ON d.dept_no=de.dept_no AND
    de.to_date > NOW()
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no;

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT
	d.dept_name,
    ROUND(AVG(s.salary),2) AS average_salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no=de.dept_no AND
    de.to_date > NOW()
JOIN salaries s
	ON s.emp_no=de.emp_no AND
		s.to_date > NOW()
	GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

-- 8. Who is the highest paid employee in the Marketing department?

select
	e.first_name,
    e.last_name
from employees e 
join salaries s
	on e.emp_no=s.emp_no
join dept_emp de
	on de.emp_no=e.emp_no 
join departments d 
	on d.dept_no=de.dept_no
where 
	d.dept_name = 'Marketing'
order by s.salary DESC
limit 1;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- 9. Which current department manager has the highest salary?

SELECT
	e.first_name,
    e.last_name,
    s.salary,
    d.dept_name
FROM employees e
JOIN salaries s
	ON e.emp_no=s.emp_no 
JOIN dept_mananger dm
	ON de.emp_no=e.emp_no
JOIN departments d
	ON d.dept_no=dm.dept_no
ORDER BY s.salary DESC
LIMIT 1;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT
	d.dept_name,
    ROUND(AVG(s.salary),0) average_salary
FROM salaries s
JOIN dept_emp de
	ON s.emp_no=de.emp_no
JOIN departments d
	ON d.dept_no=de.dept_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;


-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.

select 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
    d.dept_name AS 'Department Name',
    CONCAT(managers.first_name, ' ', managers.last_name) AS 'Manager_name'
from employees e
join dept_emp de
	on e.emp_no=de.emp_no
join departments d
	on d.dept_no=de.dept_no
join dept_manager dm
	on dm.dept_no=de.dept_no and
    dm.to_date > NOW()
-- Join employees again as managers to get manager names.
JOIN employees AS managers 
	ON managers.emp_no = dm.emp_no
WHERE de.to_date > CURDATE()
ORDER BY d.dept_name;

-- 240,124 Rows
-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman
