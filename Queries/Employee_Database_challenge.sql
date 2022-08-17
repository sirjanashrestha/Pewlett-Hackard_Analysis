-----DELIVERABLE 1

--Retrieve columns from employees and titles table, and join on primary key
SELECT e.emp_no,e.first_name,
	   e.last_name,t.title,
	   t.from_date,t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
ON e.emp_no=t.emp_no
WHERE e.birth_date BETWEEN'1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no
;

SELECT *
FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
				    rt.first_name,
					rt.last_name,
					rt.title
INTO Unique_titles
FROM retirement_titles as rt
WHERE to_date='9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT *
FROM Unique_titles

--Retrieve number of employees by most recent job title who are about to retire
SELECT COUNT(title)"count",title
INTO retiring_titles
FROM Unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT *
FROM retiring_titles

----DELIVERABLE 2

--Create Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no)
	   e.emp_no,e.first_name,
	   e.last_name,e.birth_date,
	   d.from_date,d.to_date,
	   t.title
INTO Mentorship_Eligibility
FROM employees AS e
JOIN dep_employee AS d
ON (e.emp_no)=(d.emp_no)
JOIN titles AS t
ON (e.emp_no)=(t.emp_no)
WHERE d.to_date='9999-01-01' AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT *
FROM Mentorship_Eligibility


-- Create a depart_info table to retreive retirement ready employee in respective department
SELECT ut.emp_no, ut.first_name, ut.last_name,ut.title, d.dept_name
INTO department_info
FROM unique_titles as ut
INNER JOIN dep_employee as de
ON ut.emp_no=de.emp_no
INNER JOIN departments as d
ON de.dept_no=d.dept_no
ORDER BY ut.emp_no


SELECT *
FROM department_info

-- Retrieve department wise information
SELECT di.dept_name,count(di.emp_no)
FROM department_info as di
GROUP BY di.dept_name
ORDER BY count(di.emp_no);

-- Retrieve qualified retirement ready employee to mentor next generation of PH
SELECT ut.title,count(ut.title)
FROM unique_titles as ut
WHERE ut.title in ('Senior Engineer','Senior Staff','Manager','Technique Leader')
GROUP BY ut.title
ORDER BY ut.title