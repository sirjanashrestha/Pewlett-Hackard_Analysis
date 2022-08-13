--creating tables for PH-EmployeeDB
CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
PRIMARY KEY (dept_no),
UNIQUE(dept_name)
);
CREATE TABLE employees(
	emp_no INT NOT NULL,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
PRIMARY KEY (emp_no)
);
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no)
);
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE dep_employee(
	emp_no INT NOT NULL,
	dept_no VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
DROP TABLE titles
SELECT * FROM departments;
SELECT * FROM dep_employee;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--Determine Retirement Eligibility
SELECT first_name,last_name
from employees
where birth_date between '1952-01-01'and '1955-12-31';

SELECT first_name,last_name
from employees
where birth_date between '1952-01-01'and '1952-12-31';

SELECT first_name,last_name
from employees
where (birth_date between '1952-01-01'and '1955-12-31') and
 		(hire_date between  '1985-01-01'and '1988-12-31');

--Count number of employess retiring
SELECT count(first_name)
from employees
where (birth_date between '1952-01-01'and '1955-12-31') and
 		(hire_date between  '1985-01-01'and '1988-12-31');
		
--Save retirement info into a table
SELECT first_name,last_name
INTO retirement_info
from employees
where (birth_date between '1952-01-01'and '1955-12-31') and
 		(hire_date between  '1985-01-01'and '1988-12-31');
		
SELECT * from retirement_info

Drop table retirement_info

--Creating new table for retiring employees with employee number
Select emp_no,first_name,last_name
into retirement_info
from employees
where (birth_date between '1952-01-01'and '1955-12-31') and
 		(hire_date between  '1985-01-01'and '1988-12-31');
		
SELECT * from retirement_info

--Join department and dept_manager tables
Select departments.dept_name,dept_manager.emp_no,dept_manager.from_date,
		dept_manager.to_date
from departments
INNER JOIN dept_manager
on departments.dept_no=dept_manager.dept_no;

----Join retirement_info and dept_manager
Select retirement_info.emp_no,retirement_info.first_name,retirement_info.last_name,
		dep_employee.to_date
from retirement_info
Left JOIN dep_employee
ON retirement_info.emp_no=dep_employee.emp_no;

--Using aliases on above code
Select re.emp_no,re.first_name,re.last_name,
		d.to_date
from retirement_info as re
Left JOIN dep_employee as d
ON re.emp_no=d.emp_no;

--Left join for retirement info and dept_emp table
Select re.emp_no,re.first_name,re.last_name,
		d.to_date 
INTO current_emp
from retirement_info as re
Left JOIN dep_employee as d
ON re.emp_no=d.emp_no
where d.to_date=('9999-01-01');

--count employee by department number
Select d.dept_no,count(ce.emp_no)
from current_emp as ce
left join dep_employee as d
on ce.emp_no=d.emp_no
group by d.dept_no
order by d.dept_no;

--LIST 1-Employee Information
--List of employee containing unique employee no, name, gender and salary
select emp_no,first_name,last_name,gender
into emp_info
from employees
where (birth_date between '1952-01-01'and '1955-12-31') and
 		(hire_date between  '1985-01-01'and '1988-12-31');

select e.emp_no,e.first_name,e.last_name,e.gender,s.salary
from emp_info as e
left join salaries as s
on e.emp_no=s.emp_no;

Drop table emp_info

--Joining three tables employee, dep_employee and salary
select e.emp_no,e.first_name,e.last_name,e.gender,s.salary,de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no=s.emp_no)
inner join dep_employee as de
on (e.emp_no=de.emp_no)
where (birth_date between '1952-01-01'and '1955-12-31') and
 		(hire_date between  '1985-01-01'and '1988-12-31') and (de.to_date='9999-01-01');
		
select * from emp_info

--LIST 2-MANAGEMENT(creating manager info table)
select dm.dept_no,d.dept_name,dm.emp_no,ce.first_name,ce.last_name,dm.from_date,dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d
on (dm.dept_no=d.dept_no)
inner join current_emp as ce
on (dm.emp_no=ce.emp_no);
select * from manager_info

--LIST 3 Creating Department retirees table
Select ce.emp_no,ce.first_name,ce.last_name,d.dept_name
into dep_info
from current_emp as ce
inner join dep_employee as de
on (ce.emp_no=de.emp_no)
inner join departments as d
on (de.dept_no=d.dept_no);

select * from dep_info

--tailored list
select *
from dep_info where dept_name in ('Sales','Development')


