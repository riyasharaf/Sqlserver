CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Department NVARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Experience INT NOT NULL,
    LastModified DATETIME DEFAULT GETDATE()
);

INSERT INTO Employees (Name, Department, Salary, Experience)  
VALUES  
('Alice Johnson', 'HR', 55000.00, 5),  
('Bob Smith', 'IT', 75000.00, 8),  
('Charlie Brown', 'Finance', 67000.00, 6),  
('David Wilson', 'Marketing', 62000.00, 4),  
('Emma Davis', 'IT', 80000.00, 10),  
('Frank Thomas', 'Sales', 58000.00, 3),  
('Grace Miller', 'HR', 60000.00, 7),  
('Henry White', 'Finance', 72000.00, 9),  
('Ivy Scott', 'IT', 77000.00, 6),  
('Jack Taylor', 'Sales', 59000.00, 4);  

Select * from employees

--1 Create a Stored Procedure to Retrieve details of All Employees



create procedure spdetails
as
begin
select * from employees
end

exec spdetails
--2 Create a stored procedure that retrieves details of a specific employee by their ID.


Create procedure spRetrievedetails
@employeeid int
as 
begin
select * from employees
where employeeid = @employeeid

end

exec spRetrievedetails 1

---3  Create a procedure to insert a new employee into the Employees table.

Create procedure spinsertdetails
  @Name NVARCHAR(100) ,
    @Department NVARCHAR(50) ,
    @Salary DECIMAL(10,2) ,
    @Experience INT 
as
begin
insert into employees (name,department,salary,experience) values
(@name , @department, @salary , @experience)
end

exec spinsertdetails 'Riya','IT',30000,10

select * from employees

--4 Create a procedure that returns the total number of employees with respect to their department.

Create procedure sptotalempperdeptt

AS
BEGIN
Select department,count(distinct(name)) as tot_emp from employees
group by department
end


exec sptotalempperdeptt

--- 5. Create a procedure to update the Experience of an employee by their ID.

select * from employees

Create procedure spUpdateexperience
@EmployeeId int,
@newExp int
as
begin
Update employees set experience = @newExp where @employeeid = employeeid
end

exec spUpdateexperience 1 ,  20

---6 Create a trigger to log insert operations into a LogTable.
CREATE TABLE LogEmployees (
    EmployeeID int ,
    Name NVARCHAR(100) NOT NULL,
    Department NVARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Experience INT NOT NULL,
    LastModified DATETIME DEFAULT GETDATE()
);



CREATE TRIGGER trg_logInsert 
ON Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO Logemployees (EmployeeID, Name, Department, Salary, Experience, LastModified)
    SELECT EmployeeID, Name, Department, Salary, Experience, GETDATE()
    FROM inserted;
END;



INSERT INTO Employees (Name, Department, Salary, Experience)  
VALUES  
('Riyaaa', 'HR', 55000.00, 5)

select * from logemployees

---7 Create trigger that logs whenever an employee's salary is updated.

Create trigger tr_updatesalary
on employees
for update
as
begin 
 if UPDATE(salary)
 INSERT INTO Logemployees (EmployeeID, Name, Department, Salary, Experience, LastModified)
    SELECT EmployeeID, Name, Department, Salary, Experience, GETDATE()
    FROM inserted;
end
end

update Employees set Salary =60000 where EmployeeID = 2
select * from logemployees

---8 Create a trigger to log when an employee record is deleted

CREATE TRIGGER trg_logDelete 
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO Logemployees (EmployeeID, Name, Department, Salary, Experience, LastModified)
    SELECT EmployeeID, Name, Department, Salary, Experience, GETDATE()
    FROM deleted;
END;

delete from Employees where EmployeeID = 4
select * from logemployees

---9 Create a trigger to prevent inserting a salary below 20,000.

CREATE TRIGGER tr_preventinsert
ON Employees
FOR INSERT, UPDATE
AS
BEGIN
   
    IF EXISTS (SELECT 1 FROM inserted WHERE Salary < 20000)
    BEGIN
        PRINT 'Not allowed to enter';
        ROLLBACK TRANSACTION;
    END
END;

---10 .Create a trigger to automatically update the LastModified field with the current timestamp when a record is updated

CREATE TRIGGER update_last_modified
ON employees
AFTER UPDATE
AS
BEGIN
    UPDATE employees
    SET LastModified = GETDATE()
    FROM employees
    INNER JOIN inserted ON employees.employeeID = inserted.employeeID;
END;
select * from employees
update Employees set Salary = 40000 where EmployeeID = 2

