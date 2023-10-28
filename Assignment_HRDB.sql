USE HR;

-- PAGE 29-- 
-- Q1. Display all information in the tables EMP and DEPT. --

SELECT * FROM employees, departments;

-- Q2. Display only the hire date and employee name for each employee. --

SELECT hire_date, first_name
FROM employees;

-- Q3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title --

SELECT concat (first_name, ', ', job_id)
AS employee_and_title
FROM employees;

-- Q4. Display the hire date, name and department number for all clerks. --

SELECT hire_date, first_name, department_id
FROM employees
WHERE job_id = 'SH_CLERK';

-- Q5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT -- 

SELECT concat(employee_id, ',',
 first_name, ',',
 last_name, ',',
 email, ',',
 phone_number, ',',
 hire_date, ',',
 job_id, ',',
 salary, ',',
 commission_pct, ',',
 manager_id, ',',
 department_id)
AS THE_OUTPUT FROM employees;

-- Q6. Display the names and salaries of all employees with a salary greater than 2000. --

SELECT first_name, salary
FROM employees
WHERE salary > 2000;

-- Q7. Display the names and dates of employees with the column headers "Name" and "Start Date" --

SELECT first_name AS Name,
hire_date AS Start_Date
FROM employees;

-- 8. Display the names and hire dates of all employees in the order they were hired. --

SELECT first_name, hire_date
FROM employees
ORDER BY hire_date;

-- Q9. Display the names and salaries of all employees in reverse salary order. -- 

SELECT first_name, salary
FROM employees
ORDER BY salary DESC;

-- Q10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. --

SELECT first_name, department_id, salary
FROM employees
WHERE commission_pct  is not null
ORDER BY salary DESC;

--  Q11. Display the last name and job title of all employees who do not have a manager. -- 

SELECT e.last_name, j.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE manager_id IS NULL;

-- Q12. Display the last name, job, and salary for all employees whose job is sales representative
--  or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000

SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP' OR job_id = 'PU_CLERK'
AND salary NOT IN ('2500.00', '3500.00', '5000.00');

-- PAGE 30 --

-- 1) Display the maximum, minimum and average salary and commission earned. --

SELECT
max(salary) AS maximum_salary,
min(salary) AS minimum_salary,
avg(salary) AS average_alary,
max(commission_pct) AS maximum_commission,
min(commission_pct) AS minimum_commission,
avg(commission_pct) AS average_commission
FROM employees;

-- 2) Display the department number, total salary payout and total commission payout for each department. --

SELECT department_id,
sum(salary) AS total_salary,
sum(commission_pct) AS total_comission
FROM employees
GROUP BY department_id;

-- 3) Display the department number and number of employees in each department. --

SELECT department_id,
count(*) AS No_of_emp
FROM employees
GROUP BY department_id;

-- 4) Display the department number and total salary of employees in each department. --

SELECT department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name. --

SELECT first_name
FROM employees
WHERE commission_pct IS NULL OR commission_pct = 0
order by 1;

-- 6) Display the employees name, department id and commission. If an Employee doesn't
-- earn the commission, then display as 'No commission'. Name the columns appropriately

SELECT first_name,
department_id,
commission_pct,
CASE
	WHEN commission_pct IS NULL OR commission_pct = 0 THEN 'no_commission'
    ELSE 'commission'
    END AS commission_earned
    FROM employees;
    
-- 7) Display the employee's name, salary and commission multiplied by 2. If an Employee
-- doesn't earn the commission, then display as 'No commission. Name the columns appropriately

SELECT first_name,
salary,
commission_pct,
CASE
	WHEN commission_pct IS NULL OR commission_pct = 0 THEN 'no_commission'
    ELSE commission_pct*2
    END AS double_commission
    FROM employees;

-- 8) Display the employee's name, department id who have the first name same as another employee in the same department --

SELECT first_name,
department_id
FROM employees
WHERE (first_name, department_id)
IN (SELECT first_name, department_id
	FROM employees
    GROUP BY first_name, department_id
    HAVING count(*)>1);
    
-- 9) Display the sum of salaries of the employees working under each Manager. --

SELECT manager_id,
sum(salary) AS total_salary
FROM employees
GROUP BY manager_id;

-- 10) Select the Managers name, the count of employees working under and the department ID of the manager --

SELECT manager_id,
count(employee_id) AS total_emp,
department_id
FROM employees
GROUP BY manager_id, department_id;

-- 11) Select the employee name, department id, and the salary. Group the result with the
-- manager name and the employee last name should have second letter 'a!

SELECT concat (first_name, ' ', last_name) AS employee_name,
department_id,
salary,
manager_id
FROM employees
WHERE last_name LIKE '_a%';

-- 12) Display the average of sum of the salaries and group the result with the department id. Order the result with the department id. -- 

SELECT avg(A.salary)
FROM employees A
WHERE A.salary IN(SELECT sum(B.salary) FROM employees B GROUP BY B.department_id);

-- 13) Select the maximum salary of each department along with the department id  --

SELECT department_id,
max(salary) AS maximum_salary
FROM employees
GROUP BY department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1 --

SELECT
CASE
	WHEN commission_pct IS NOT NULL THEN salary*0.10
    ELSE 1
    END AS comission
FROM employees;


-- PAGE 31

-- 1. Write a query that displays the employee's last names only from the string's 2-5th
-- position with the first letter capitalized and all other letters lowercase, Give each column an
-- appropriate label.  

SELECT CONCAT(UPPER(SUBSTRING(last_name,1,1)),
			LOWER(SUBSTRING(last_name,2,4))) AS proper_name
FROM employees;

-- 2. Write a query that displays the employee's first name and last name along with a " in
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the
-- month on which the employee has joined.

SELECT CONCAT(first_name,'-', last_name) as Full_Name,
MONTHNAME(hire_date) AS Joining_Month
FROM employees;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than
-- ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of
-- 1500 each. Provide each column an appropriate label. 

SELECT last_name,
CASE
	WHEN salary *.5 >10000
    THEN salary * 1.1 + 1500
    ELSE salary * 1.115 + 1500
END AS increased_pay 
FROM employees;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end,
-- department id, salary and the manager name all in Upper case, if the Manager name
-- consists of 'z' replace it with '$! 

SELECT CONCAT(SUBSTRING(employee_id,1,2), '00',
			SUBSTRING(employee_id,3),'E') AS New_ID,
            UPPER(department_id) AS DEPT,
            salary,
            REPLACE(UPPER(manager_id), 'Z', '$!') AS Manager_name
            FROM employees;
            
-- 5. Write a query that displays the employee's last names with the first letter capitalized and
-- all other letters lowercase, and the length of the names, for all employees whose name
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the
-- employees' last names 

SELECT CONCAT(UPPER(SUBSTRING(last_name,1,1)), 
		SUBSTRING(last_name,2)) AS Name,
        LENGTH(last_name) AS Name_Length
FROM employees
WHERE last_name LIKE 'J%' OR last_name LIKE 'A%' OR last_name LIKE 'M%'
ORDER BY last_name;

-- 6. Create a query to display the last name and salary for all employees. Format the salary to
-- be 15 characters long, left-padded with $. Label the column SALARY

SELECT last_name,
	LPAD(salary,15,'$') AS SALARY
FROM employees;

-- 7. Display the employee's name if it is a palindrome 

SELECT first_name
FROM employees
WHERE first_name = REVERSE(first_name);

-- 8. Display First names of all employees with initcaps.

SELECT CONCAT(UPPER(LEFT(first_name,1)),
		SUBSTRING(first_name,2)) as initcaps_Name
FROM employees;

-- 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.

SELECT 
    SUBSTRING_INDEX(SUBSTRING_INDEX(street_address, ' ', 2), ' ', -1) AS middleWord
FROM locations;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add
-- "@systechusa.com" at the end. Name the column as e-mail address. All characters should
-- be in lower case. Display this along with their First Name.

SELECT first_name,
	CONCAT(LOWER(SUBSTRING(first_name,1,1)), LOWER(last_name), '@systechusa.com') AS e_mail
FROM employees;

-- 11. Display the names and job titles of all employees with the same job as Trenna.

SELECT e.first_name, j.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.job_id = (SELECT job_id FROM employees WHERE first_name = 'Trenna');

-- Display the names and department name of all employees working in the same city as Trenna.
SELECT e.first_name,
	   d.department_name,
       l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city =
(SELECT l.city FROM employees em
 JOIN departments dt ON em.department_id = dt.department_id
 Join locations l ON dt.location_id = l.location_id
 WHERE em.first_name = 'Trenna');

-- 13. Display the name of the employee whose salary is the lowest. 

SELECT first_name
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- 14. Display the names of all employees except the lowest paid.

SELECT first_name
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees);

-- PAGE 32

-- 1. Write a query to display the last name, department number, department name for all employees.

SELECT e.last_name,
	   e.department_id,
       d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 2. Create a unique list of all jobs that are in department 4. Include the location of the
-- department in the output.

SELECT DISTINCT E.job_id, D.location_id
FROM employees E
JOIN departments D ON E.department_id = D.department_id
WHERE D.department_id = 40;

-- 3. Write a query to display the employee last name,department name,location id and city of
-- all employees who earn commission.

SELECT e.last_name,
       d.department_name,
       d.location_id,
       l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;

-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name 

SELECT e.last_name,
       d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.last_name LIKE '%a%';

-- 5. Write a query to display the last name,job,department number and department name for
-- all employees who work in Toronto.

SELECT e.last_name,
	   e.job_id,
       e.department_id,
       d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.location_id = (SELECT location_id FROM locations WHERE city = 'Toronto');

-- 6. Display the employee last name and employee number along with their manager's last name and manager number

SELECT last_name,
	   employee_id,
       manager_id
FROM employees;

-- 7. Display the employee last name and employee number along with their manager's last
-- name and manager number (including the employees who have no manager).

SELECT last_name,
	   employee_id,
       manager_id
FROM employees;


-- 8. Create a query that displays employees last name,department number,and all the
-- employees who work in the same department as a given employee. 

SELECT last_name,
department_id
FROM employees
ORDER BY department_id;

-- 9. Create a query that displays the name,job,department name,salary,grade for all
-- employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 

SELECT e.first_name,
	   e.job_id,
       e.salary,
       d.department_name,
CASE 
	WHEN salary >=50000 THEN 'A'
    WHEN salary >=30000 THEN 'B'
    WHEN salary <30000 THEN 'C'
END AS Grade
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 10. Display the names and hire date for all employees who were hired before their
-- managers along withe their manager names and hire date. Label the columns as Employee
-- name, emp_hire_date,manager name,man_hire_date



-- PAGE 34 --

-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES.  

SELECT e.last_name,
	   e.hire_date
       FROM employees e
WHERE e.department_id =(SELECT department_id FROM departments
WHERE department_name = 'Sales');

-- 2. Create a query to display the employee numbers and last names of all employees who
-- earn more than the average salary. Sort the results in ascending order of salary.

SELECT employee_id,
	   last_name,
       salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary ASC;

-- 3. Write a query that displays the employee numbers and last names of all employees who
-- work in a department with any employee whose last name contains a' u 

SELECT E.employee_id,
       E.last_name,
	   E.department_id
FROM employees E
WHERE E.department_id IN (SELECT E2.department_id
FROM employees E2
WHERE E.last_name LIKE '%u%');

-- 4. Display the last name, department number, and job ID of all employees whose department location is Southlake. 

SELECT last_name,
	   department_id,
       job_id
FROM employees 
WHERE department_id = 
(SELECT department_id FROM departments 
WHERE location_id = 
(SELECT location_id FROM locations 
WHERE city = 'Southlake'));

-- 5. Display the last name and salary of every employee who reports to 101
SELECT last_name,
salary
FROM employees
WHERE manager_id = '101';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department. 

SELECT e.department_id,
e.last_name,
e.job_id
FROM employees e
WHERE e.department_id = (SELECT department_id FROM departments WHERE department_name = 'Operations');


-- 7. Modify the above query to display the employee numbers, last names, and salaries of all
-- employees who earn more than the average salary and who work in a department with any
-- employee with a 'u'in their name.

SELECT A.employee_id,
A.last_name,
A.salary
FROM employees A
WHERE A.salary > (SELECT AVG(B.salary)FROM employees B) 
AND 
A.department_id IN (SELECT C.department_id FROM employees C WHERE A.last_name like '%u%');

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept. 

SELECT e.first_name, J.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.department_id = (SELECT department_id FROM departments WHERE department_name = 'Sales');

-- 9. Write a compound query to produce a list of employees showing raise percentages,
-- employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise,
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are
-- given a 15% raise, and employees in department 6 are not given a raise.

SELECT * FROM employees;
SELECT first_name, salary,
CASE
	WHEN department_id = 10 or department_id =30
    THEN salary*1.05
    WHEN department_id = 20
    THEN  salary*1.10
    WHEN department_id = 40 or department_id =50
    THEN salary*1.15
    WHEN department_id = 60
    THEN 'No Raise'
END AS raise
FROM employees;


-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.

SELECT last_name, salary
FROM employees
ORDER BY salary desc limit 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees
-- with a null commission should have O in the commission column

SELECT first_name,salary,
IFNULL(commission_pct,0) AS commission
FROM employees;


-- 12. Display the employees (name) with top three salaries along with their salaries and department name.

SELECT e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY salary DESC LIMIT 3;

-- PAGE 35 -- 
-- Date Function-- 

-- 1) Find the date difference between the hire date and resignation_date for all the
-- employees. Display in no. of days, months and year(1 year 3 months 5 days).
-- Emp_ID Hire Date Resignation_Date

SELECT e.employee_id, jh.start_date, jh.end_date,
CONCAT(
    DATEDIFF(jh.end_date, jh.start_date) DIV 365, ' Years ',
    (DATEDIFF(jh.end_date, jh.start_date) MOD 365) DIV 30, ' Months ',
    (DATEDIFF(jh.end_date, jh.start_date) MOD 365) MOD 30, ' Days'
) AS DateDifference
FROM employees e
JOIN job_history jh ON e.hire_date = jh.start_date;


-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd,
-- yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)

SELECT DATE_FORMAT(start_date, '%m/%d/%Y') AS hire_date,
IFNULL(DATE_FORMAT(end_date, '%b %D, %Y'), 'Dec 01st, 1900') as resignation_date
FROM job_history;

-- 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3months)

SELECT CONCAT(DATEDIFF(end_date,start_date) DIV 365, ' year', ' ',
		(DATEDIFF(end_date,start_date) MOD 365) DIV 30, ' months') AS experience
FROM job_history;

-- 4) Display the count of days in the previous quarter 

SELECT
    DATEDIFF(
        MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE()) QUARTER - INTERVAL 1 DAY,
        MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE()) QUARTER - INTERVAL 1 QUARTER
        )AS Previous_quarter_days;
	
-- 5) Fetch the previous Quarter's second week's first day's date 
        
SELECT
    DATE_ADD(
        DATE_ADD(
            MAKEDATE(YEAR(CURDATE()), 1),
            INTERVAL (QUARTER(CURDATE()) - 2) QUARTER),
			INTERVAL 7 DAY
			) AS previous_quarter_second_week_first_day;
            
-- 6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY) 

SELECT DATE_FORMAT(DATE_ADD(MAKEDATE(YEAR(CURDATE()),1),
INTERVAL 15 WEEK),
'%m %d %Y') AS 15th_week_date;


    


