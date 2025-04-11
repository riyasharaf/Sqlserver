create database joinsprac

use joinsprac

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT
);

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO Employee (emp_id, emp_name, dept_id) VALUES
(1, 'Aakash', 101),
(2, 'Rohan', 102),
(3, 'Neha', NULL),
(4, 'Sameer', 101);

INSERT INTO Department (dept_id, dept_name) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance');




select emp_id , emp_name from employee e inner join department d on e.dept_id = d.dept_id


select dept_name , emp_name from employee e left join department d on e.dept_id = d.dept_id
SELECT * FROM Employee;
SELECT * FROM Department;


select dept_name , emp_name from employee e right join department d on e.dept_id = d.dept_id
SELECT * FROM Employee;
SELECT * FROM Department;


select dept_name , emp_name from employee e full join department d on e.dept_id = d.dept_id
SELECT * FROM Employee;
SELECT * FROM Department;

select dept_name , emp_name from employee e cross join department d 
SELECT * FROM Employee;
SELECT * FROM Department;


--Har department me kitne employees hain, ye count nikalna hai.

select  DEPT_NAME ,count(emp_id) as tot_emp from  department d left join employee e
ON e.dept_id = d.dept_id GROUP BY D.DEPT_NAME


----- Jo employees kisi department me assigned nahi hain, unko dikhana hai.

SELECT * FROM Employee;
SELECT * FROM Department;

SELECT EMP_NAME 
FROM Employee
WHERE dept_id IS NULL;


-------------------✅ Aise departments dikhane hain jisme koi employee nahi hai.
 SELECT DEPT_NAME FROM DEPARTMENT  D  LEFT JOIN EMPLOYEE E  ON D.dept_id = E.dept_id WHERE
 E.DEPT_ID IS NULL
 S













