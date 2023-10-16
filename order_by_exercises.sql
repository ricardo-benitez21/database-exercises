show databases;
use employees;
select database();
show tables;

/* 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
What is the employee number of the top three results? */
select first_name, emp_no
from employees
where first_name in ('Irena', 'Vidya', 'Maya');
-- A: 10200, 10397, 10610

/*
2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q1, but use OR instead of IN.
What is the employee number of the top three results? Does it match the previous question? */
select first_name, emp_no
from employees
where first_name in ('Irena')
	or first_name = 'Vidya'
    or first_name = 'Maya';
	-- A: The employee numbers in Q1 and Q2 are the same
    
    /*
   3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
    What is the employee number of the top three results? */
select first_name, emp_no, gender
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

-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

/* 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */
select first_name,last_name, emp_no
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name;
/* A: First and last name in the first row is Irena Reutenaur
 First and last name in the last row is Vidya Simmen */

/* 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.
 In your comments, answer: What was the first and last name in the first row of the results?
 What was the first and last name of the last person in the table? */
 select first_name,last_name, emp_no
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name ,last_name;
/* A: First and last name in the first row is Irena Acton 
First and last name in the last row is Vidya Zweizig */

/* 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name.
 In your comments, answer: What was the first and last name in the first row of the results?
 What was the first and last name of the last person in the table? */
select first_name,last_name, emp_no
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by last_name ,first_name;
/* A: First and last name in the first row is Irena Acton
First and last name in in the last row is Maya Zyda

/* 5. Write a query to find all employees whose last name starts and ends with 'E'. 
Sort the results by their employee number.
Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name. */
select first_name, last_name, emp_no
from employees
where last_name like 'E%'
	and last_name like '%E'
order by emp_no;
/* A: 899 employees returned. First employee number is 10021 and their name is Ramzi Erde.
	  The last employee number is 499648 and their name is Tadahiro Erde */

 /* Write a query to find all employees whose last name starts and ends with 'E'. 
 Sort the results by their hire date, so that the newest employees are listed first.
 Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee. */
select first_name, last_name, emp_no, hire_date
from employees
where last_name like 'E%'
	and last_name like '%E'
order by hire_date desc; 
/* A: 899 employees returned. The name of the newest employee is Teiji Eldridge
	  The oldest employee is Sergi Erde

/* Find all employees hired in the 90s and born on Christmas.
 Sort the results so that the oldest employee who was hired last is the first result.
 Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first. */
select hire_date,birth_date, first_name, last_name, emp_no 
from employees
where hire_date between '1990-01-01' and '1999-12-31'
	and birth_date like '%12-25%'
order by birth_date, hire_date desc;
/* 362 employees returned. 
   Khun Berini is the oldest who was hired last 
   Douadi Pettis is the name of the youngest employee who was hired first */
	