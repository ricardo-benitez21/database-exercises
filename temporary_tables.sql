USE ursula_2338;
use employees;
-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that 
-- contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely 
-- sure to create this table on your own database. If you see "Access denied for user ...", it means that the 
-- query was attempting to write a new table to a database that you can only read.
drop table employees_with_departments;
create temporary table if not exists employees_with_departments as
select 
	e.first_name,
    e.last_name,
    d.dept_name
from employees.employees as e
join employees.dept_emp as de
	on e.emp_no=de.emp_no
join employees.departments as d
	on de.dept_no=d.dept_no;





-- 1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of 
-- the first name and last name columns.
alter table employees_with_departments add column full_name varchar(100);





-- 1b. Update the table so that the full_name column contains the correct data.
update employees_with_departments set full_name = concat(first_name,last_name);
select * from employees_with_departments;



-- 1c. Remove the first_name and last_name columns from the table.
alter table employees_with_departments drop column first_name, drop column last_name;
select * from employees_with_departments;



-- 1d. What is another way you could have ended up with this same table?
-- could have gotten this same answer with a select statement



-- 2. Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an 
-- integer representing the number of cents of the payment. For example, 1.99 should become 199.
drop table if exists sk_payments;

-- one way
-- step1
describe sakila.payment;
create temporary table sk_payments as
select 
		 payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,payment_date
        -- ,CAST(amount *100 as int)
        ,amount
from sakila.payment;

select * from sk_payments;

-- second way
-- step1
describe sakila.payment;
drop table sk_payments2;
create temporary table sk_payments2 as
select 
		 payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,payment_date
        ,amount*100 as amt_in_pennies
        ,amount
from sakila.payment;

select * from sk_payments2;
-- step 2
alter table sk_payments2 modify amt_in_pennies int;

select * from sk_payments2;


-- third way
-- step 1
drop table sk_payments3;
create temporary table sk_payments3 as
select 
		 payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,payment_date
        ,amount
from sakila.payment;



-- step 2
-- Alter the column
alter table sk_payments3
modify amount dec(10, 2);

-- step 3
-- Update the column
update sk_payments3
set amount = amount * 100;

-- As Int
ALTER TABLE sk_payments3 MODIFY amount int NOT NULL;


select * from sk_payments3;


-- 3. Go back to the employees database. Find out how the current average pay in each department
-- compares to the overall current pay for everyone at the company. For this comparison, you will 
-- calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? 
-- The worst?


-- Overall current salary stats
select 
	avg(salary), 
    std(salary)
from employees.salaries 
where to_date > now();

-- 72,012 overall average salary
-- 17,310 overall standard deviation



use employees;

drop table overall_aggregates;
-- get overall std 
create temporary table overall_aggregates as (
    select 
		avg(salary) as avg_salary,
        std(salary) as overall_std
    from employees.salaries  where to_date > now()
);

select * from overall_aggregates;


-- Let's check out our current average salaries for each department
-- If you see "for each" in the English for a query to build..
-- Then, you're probably going to use a group by..
-- want to compare each departments average salary to the overall std and overall avg salary

drop table current_info;
-- get current average salaries for each department
create temporary table current_info as (
    select 
		dept_name, 
        avg(salary) as department_current_average
    from employees.salaries s
    join employees.dept_emp de
		on s.emp_no=de.emp_no and 
        de.to_date > NOW() and 
        s.to_date > NOW()
    join employees.departments d
		on d.dept_no=de.dept_no
    group by dept_name
);

select * from current_info;


-- add on all the columns we'll end up needing:
alter table current_info add overall_avg float(10,2);
alter table current_info add overall_std float(10,2);
alter table current_info add zscore float(10,2);

-- set the avg and std
update current_info set overall_avg = (select avg_salary from overall_aggregates);
update current_info set overall_std = (select overall_std from overall_aggregates);


-- update the zscore column to hold the calculated zscores
update current_info 
set zscore = (department_current_average - overall_avg) / overall_std;


select * from current_info;

select 
	max(zscore) as max_score
from current_info 
where max(zscore) = .97
;