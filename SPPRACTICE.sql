CREATE DATABASE SPPRACTICE

USE SPPRACTICE

--1. Get Customer Details:
-- Create a stored procedure that takes a CustomerID as input and returns the
--customer's FirstName, LastName, and Email from a Customers table.

CREATE TABLE CUSTOMER
( CID INT IDENTITY(1,1),
FIRSTNAME VARCHAR(20),
LASTNAME VARCHAR(20),
EMAIL VARCHAR(20))

INSERT INTO CUSTOMER VALUES('RIYA' , 'SHARAF' , 'riyasharaf@gmail.com')

CREATE PROCEDURE sp_Custinfo
 @CID INT
 AS
 BEGIN
 SELECT 
 FIRSTNAME,LASTNAME,EMAIL 
 FROM CUSTOMER
 WHERE CID = @CID
 END

 EXEC sp_Custinfo 2
 SELECT * FROM CUSTOMER

 ------2 2. Add a New Product:
-- Create a stored procedure that takes ProductID, ProductName, Description, and
--Price as input and inserts a new product into a Products table.

CREATE TABLE PRODUCTS
(PID INT PRIMARY KEY,
PRODUCTNAME VARCHAR(10),
DESCRIPTION NVARCHAR(20),
PRICE MONEY
)

CREATE PROCEDURE sp_addnewproduct
@pid int,
@productname varchar(10),
@description nvarchar(20),
@price money

as
begin
insert into products(pid,productname,description,price) values(@pid , @productname , @description ,@price)
end

exec sp_addnewproduct 5,'iphone' , 'vgood' ,20000
select * from products


---creating a trigger for this table

create table auditorders(aid int primary key identity(1,1),
info nvarchar(20))

create trigger orderinfoo
on products
for insert
as
begin
declare @pid int
select @pid = pid from inserted

insert into auditorders values(cast(@pId as nvarchar(5)) +  cast(Getdate() as nvarchar(20)))
END


select * from auditorders

--------------------3 3. Update Product Price:
--- Create a stored procedure that takes a ProductID and a NewPrice as input and
---updates the price of the specified product in the Products table.

SELECT * FROM PRODUCTS
CREATE PROCEDURE P_INFO
@PID INT,
@NPRICE MONEY
AS
BEGIN
UPDATE PRODUCTS 
SET PRICE = @NPRICE 
WHERE PID = @PID
END

EXEC P_INFO 4, 80000

SELECT * FROM PRODUCTS


-------4  Get Orders by Date Range:
-- Create a stored procedure that takes StartDate and EndDate as input and returns all
--orders placed within that date range from an Orders table.
SELECT * FROM ORDERS

CREATE PROCEDURE ORDERBYDATERANGE
@STARTDATE DATE,
@ENDDATE DATE
AS
BEGIN
SELECT * FROM ORDERS WHERE ORDERDATE BETWEEN @STARTDATE AND @ENDDATE
END

EXEC ORDERBYDATERANGE '2022-02-02' , '2025-03-09'


---------5. Calculate Order Total:
--Create a stored procedure that takes an OrderID as input and calculates the total
--amount of the order (sum of Quantity * UnitPrice from an OrderDetails table).
--Return the total amount as an output parameter.

ALTER TABLE ORDERS
ADD UNITPRICE INT
SELECT * FROM ORDERS

UPDATE ORDERS SET UNITPRICE = 2000 WHERE ORDERID = 1

CREATE PROCEDURE CalculateOrderTotal
    @OrderID INT,
    @TotalAmount DECIMAL(18,2) OUTPUT
AS
BEGIN
    -- Calculate total amount for the given OrderID
    SELECT @TotalAmount = SUM(Qty * UnitPrice)
    FROM Orders
    WHERE OrderID = @OrderID;
END;
DECLARE @Total DECIMAL(18,2);

EXEC CalculateOrderTotal @OrderID = 4, @TotalAmount = @Total OUTPUT;

PRINT 'Total Order Amount: ' + CAST(@Total AS VARCHAR);

select * from orders



SELECT * FROM ORDERS
 

 









