# Employee Database Analysis

## Overview of the Analysis
A large number of baby boomers in Pewlett-Hackard have begun to retire at a rapid rate. So, the purposes of this analysis are;
- to generate a list of retiring employee in Pewlett-Hackard in near future,
- to decide which position need to filled due to upcoming retirement and
- to identify employees who are eligible to participate in mentorship program.

Pewlett-Hackard has been using excel and VBA to maintain employee database, so the first task we will perform is use SQL to upgrade the employee database.

***Source of file***
- departments.csv
- dept_emp.csv
- dept_manager.csv
- employees.csv
- titles.csv
- salaries.csv

The tools used in this analysis are;
- QDBD(Quick Database Diagram): To determine conceptual, logical and physical relation between the dataset and create an Entity Relationship Diagram.
- PostGres SQL Version 11: To store database consisting of tables and predefined relationships.
- PgAdmin: To write and execute queries and view results.

## Results
**Entity Relationship Diagram**

An entity relationship diagram defines the type of data in a dataset (conceptual), primary key and foreign key within the dataset (logical) and defines the relationship  between various dataset (physical).

![image](https://user-images.githubusercontent.com/107566776/184661159-c4743b03-f01e-4957-974d-eace6663794e.png)

### ***DELIVERABLE 1*** The number of retiring employees by title

**A. Retirement ready employee**

First, we have selected emp_no, first_name and last_name columns from employees table and title, from_date and to_date columns from titles table. Then, we have joined two tables on primary key 'emp_no' and retreived only those employee whose birth_date is between 1952 and 1955. Finally, we have sorted our data by emp_no.

![image](https://user-images.githubusercontent.com/107566776/184655046-7ef2f8ec-5571-4e09-be58-102fb57c8ae1.png)

Output 1
- The query returns 133,776 rows to display list of employee who were born between January 1, 1952 ad December 31, 1955. 
- Some employee appear more than once due to change of title in their career at Pewlett_Hackard.
          ![image](https://user-images.githubusercontent.com/107566776/184500086-733eb0ca-02e2-4efd-bf7b-88f8a1759132.png)
- Table: retirement_titles.csv

**B. Retirement ready current employee with unique title**

We have used DISTINCT ON to retrieve only those employee with recent title and filter those employees that have already left the company to keep only current employee by filtering on 'to_date' to '9999-01-01'.

![image](https://user-images.githubusercontent.com/107566776/184655193-f0fb7185-c4d9-422c-9303-5068970971da.png)

Output 2
- The query returns 72,458 rows to display list of current employees holding recent titles who are about to retire soon.
          ![image](https://user-images.githubusercontent.com/107566776/184500281-5d073cab-8818-4a20-9547-76f666d7b8bf.png)
- Table: Unique_titles.csv

**C. Retiring titles**

We have used count on 'title' to count the number of retiring titles.

![image](https://user-images.githubusercontent.com/107566776/184655347-b4257ec9-a7a2-4b9b-8d51-988a96473ad3.png)

Output 3
- There are 7 titles that will have retiring employees in the near future. 25,916 senior Engineer, 24926 Senior Staff, 9285 Engineer, 7636 Staff, 3603 Technique Leader, 1090 Assistant Engineer and 2 Managers are retiring soon.

![image](https://user-images.githubusercontent.com/107566776/184500171-167d9abf-a2d1-46f1-b9fa-3a6e30dfc4b5.png)
            
- Table: retiring_titles.csv

### ***DELIVERABLE 2*** 
**Creating Mentorship eligibility table**

We have joined three tables employees, titles and dep_employee to retreive the list of all current employee eligible for mentorship program who were born in 1965.

![image](https://user-images.githubusercontent.com/107566776/184655578-9d445ad6-a9f4-461f-89e8-e5ecb4d9d5c8.png)

Output 4
- The number of employee eligible for mentorship program is 1549.
          ![image](https://user-images.githubusercontent.com/107566776/184500235-af5ec57c-3a1b-4d8a-87d3-731c929866a7.png)
          
 - Table: mentorship_eligibility.csv

## Summary
The upcoming "silver tsunami" will have impact on overall organizational structure and performance of Pewlett_Hackard. A pre analysis and action plan is required to identify the upcoming vacuum in human resources that Pewlett_Hackard is going to face in near future and fill the vacuum with new employee in time. 

**How many roles will need to be filled?**

As the silver tsunami approaches, the total number of roles that need to filled counts to 72,458.
The following table shows the breakdown of employee departmentwise and it shows that Development, Production and Sales department are going to have most vacancies in coming years.

![image](https://user-images.githubusercontent.com/107566776/184548895-3ddf1083-d8b8-4b27-bac5-0541d1b1def4.png)

**Are there enough qualified, retirement-ready employees in the department to mentor next generation of PH?**

To find the qualified retirement ready employees in the department, I ran the query to retrieve employee with 'Senior Engineer', 'Senior Staff', 'Manager', and 'Technique Leader' titel, assuming that they have the competency to mentor next generation of PH. 

 ![image](https://user-images.githubusercontent.com/107566776/184653256-f9bbddbe-ff35-490f-b190-c7d3f31bc3de.png)

The table below shows that PH has enough qualified, retirement-ready employees to mentor next generation of employee in PH.

![image](https://user-images.githubusercontent.com/107566776/184549670-7e09b3c6-4cd8-4212-ab88-2727c79e5ed1.png)




