show databases;
use employees;
select database();
show tables;

-- 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya');
-- A: 10200, 10397, 10610

/*
2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q1, but use OR instead of IN.
What is the employee number of the top three results? Does it match the previous question? */
select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya';
	-- A: The employee numbers in Q1 and Q2 are the same
    
    /*
   3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
    What is the employee number of the top three results? */
select *
from employees
where gender = 'M'
	AND (
    first_name in ('Irena')
    or first_name = 'Vidya'
    or first_name = 'Maya'
    );
-- A: The employee numbers are 10200, 10397, and 10821

-- 4. Find all unique last names that start with 'E'.
select distinct last_name
from employees
where last_name like 'E%';

-- 5. Find all unique last names that start or end with 'E'.
select distinct last_name
from employees
where last_name like 'E%'
	or last_name like '%E';

    
    
  -- 6. Find all unique last names that end with E, but does not start with E?
select distinct last_name
from employees
where last_name not like 'E%'
	and last_name like '%E';

  -- 7. Find all unique last names that start and end with 'E'.
select distinct last_name
from employees
where last_name like 'E%'
	and last_name like '%E';
   
   use employees;
/*
8. Find all current or previous employees hired in the 90s. 
Enter a comment with the top three employee numbers. */
select hire_date, first_name, last_name, emp_no
from employees
-- where hire_date like '199%'
where hire_date between '1990-01-01' and '1999-12-31';
-- A: Top three employee numbers are 10008, 10011, and 10012

/*
9. Find all current or previous employees born on Christmas. 
Enter a comment with the top three employee numbers. */
select emp_no, first_name, last_name, birth_date
from employees
where birth_date like '%12-25%';
-- A: Top three employee numbers are 10078, 10115, 10261

/*
10. Find all current or previous employees hired in the 90s and born on Christmas. 
Enter a comment with the top three employee numbers. */
select hire_date,birth_date, first_name, last_name, emp_no
from employees
where hire_date between '1990-01-01' and '1999-12-31'
	and birth_date like '%12-25%';
-- A: Top three employee numbers are 10261, 10438, 10681

-- 11. Find all unique last names that have a 'q' in their last name.

select distinct last_name
from employees
where last_name like '%q%';

-- 12. Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'; 
