CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

INSERT INTO departments (department_id, department_name) VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department_id INT,
    salary INT,
    age INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees (employee_id, name, department_id, salary, age) VALUES
(1, 'Alice', 101, 50000, 25),
(2, 'Bob', 102, 60000, 28),
(3, 'Charlie', 103, 70000, 30),
(4, 'David', 101, 55000, 27),
(5, 'Eve', 102, 65000, 26),
(6, 'Frank', 104, 72000, 35),
(7, 'Grace', 104, 75000, 40);

SELECT * FROM EMPLOYEES
SELECT * FROM DEPARTMENTS

---1 List all employees ordered by salary in descending order.

SELECT EMPLOYEE_ID, NAME, DEPARTMENT_ID, SALARY, AGE FROM EMPLOYEES
ORDER BY 4 DESC

----2ist all employees sorted by age in ascending order.

SELECT * FROM EMPLOYEES
ORDER BY AGE ASC

---3List all employees sorted by department (ascending) and salary (highest first).

SELECT * FROM employees
ORDER BY department_id ASC, salary DESC;


---4 
SELECT TOP 3 * 
FROM employees
ORDER BY salary DESC;

---5  List all employees, sorting first by department (ascending) and then by age (descending).

SELECT * FROM EMPLOYEES
ORDER BY department_id ASC, AGE DESC


----6  Find the total number of employees in each department.
SELECT * FROM EMPLOYEES
SELECT * FROM DEPARTMENTS

SELECT DEPARTMENT_ID,COUNT(*) FROM EMPLOYEES GROUP BY department_id


--Find the average salary of employees in each department.
SELECT * FROM EMPLOYEES

SELECT AVG(SALARY) AS AVG_SAL FROM EMPLOYEES GROUP BY department_id

---- Find the highest salary in each department.

SELECT MAX(SALARY) AS MAX_SAL FROM EMPLOYEES GROUP BY department_id

---- Find the total salary paid in each department

SELECT SUM(SALARY) AS TOT_SAL
 FROM EMPLOYEES GROUP BY department_id

 --Find the number of employees in each age group.

 SELECT COUNT(*) FROM EMPLOYEES GROUP BY AGE

 SELECT age, COUNT(*) AS num_employees
FROM employees
GROUP BY age;

----Find the department with the highest total salary expense.

SELECT * FROM EMPLOYEES



SELECT TOP 1 department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY total_salary DESC;



------------- Find the department with the most employees

SELECT * FROM EMPLOYEES

SELECT TOP 1  DEPARTMENT_ID, COUNT(NAME) AS TOAL_EMP FROM EMPLOYEES GROUP BY department_id ORDER BY TOAL_EMP

--------- Find the youngest employee in each department

SELECT TOP 1 DEPARTMENT_ID , MIN(AGE) AS MIN_AGE FROM EMPLOYEES GROUP BY department_id ORDER BY MIN_AGE ASC

-- Find the highest-paid employee in each department.

SELECT TOP 1 DEPARTMENT_ID , MAX(SALARY) AS MAX_SAL FROM EMPLOYEES GROUP BY department_id ORDER BY MAX_SAL DESC

---------Show each department along with the number of employees and the average salary, sorted by average salary (highest first).
---sql Copy Edit 
 SELECT * FROM EMPLOYEES

 SELECT DEPARTMENT_ID , COUNT(EMPLOYEE_ID) AS NO_OF_EMP , AVG(SALARY) AS AVG_SAL
 FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY AVG_SAL DESC





