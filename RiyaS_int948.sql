Create database RiyaSharafINT948
Use RiyaSharafINT948




Create table Products(
ProductID Int IDENTITY(1,1),
ProductName Varchar(20),
Price MONEY,
StockQuantity Int)

insert into Products 
values('Laptop', 30000,2),
('Mobile', 40000,5),
('Washing Machine', 90000,7)
--1. Create a stored procedure that takes a ProductID as input and returns the Price of the product.

Create Procedure sp_priceperid
@id int
as
begin
select ProductID , Price from Products
where ProductID = @id
end

exec sp_priceperid  1

--2. Create a stored procedure that takes a ProductID and a Quantity as input and updates the StockQuantity of the product.

Create Procedure sp_updateStock
@id int,
@newquantity int
as
begin
update Products
set StockQuantity = @newquantity
where ProductID = @id
end

exec sp_updateStock 1 ,5
select * from products


--3. Create a stored procedure that takes ProductName, Price, and StockQuantity as input and inserts a new product into the Products table.
Create procedure sp_addnewproduct
@pname varchar(20),
@price money,
@StockQuantity int
as
begin
insert into Products(ProductName, Price,Stockquantity)
values (@pname,@price,@StockQuantity)
end

exec sp_addnewproduct 'Fridge' , 20000 , 8
select * from products

--4. Create a stored procedure to find minimum and maximum price of the product.

Create procedure sp_findprice
as
begin 
select MAX(price) as max_price , MIN(price) as min_price from Products
end


 exec sp_findprice

--5. Create a stored procedure that takes a Price as input and returns all products with a price less than the given value.
Create procedure sp_returnproduct
@price int
as
begin
select * from Products where Price < @price
end

exec sp_returnproduct 40000
--6. Create a trigger that fires after an UPDATE on the Products table. If the Price is
--changed, insert a record into the ProductLogs table with the ProductID, OldPrice,
--NewPrice, and current LogDate.

select * from Products
Create table ProductLogs(
ProductID Int ,
OldPrice MONEY,
NewPrice Money,
Changedon  DATETIME DEFAULT GETDATE())

Create trigger tr_updatelog
on Products
after update
as
begin
declare @newprice money
select @newprice = Price from inserted

declare @oldprice money
select @oldprice = Price from deleted

declare @id int
select @id = productid from products
if update(price)
begin 
insert into Productlogs(ProductId , Oldprice , NewPrice) values (@id , @oldprice , @newprice)
end
end

update Products set Price = 30000 where ProductID = 2
select * from ProductLogs





--7. Create a trigger that fires before an UPDATE on the Products table. If the StockQuantity is being updated to a negative value, prevent the update and display a
--message.
Select * from Products

Create trigger tr_preventupdate
on products
for update
as
begin
if Exists( select 1 from products where StockQuantity < 0)
begin
Raiserror ('StockQuantity cant be negative' , 16,1)
end
end


update Products set StockQuantity = -5 where ProductID = 1

--8. Create a trigger that fires before an INSERT on the Products table. If the StockQuantity is not provided, set its default valueto 0.
Create trigger tr_defaultquantity
on products
for insert
as
begin
update Products
set StockQuantity = 0
where StockQuantity is Null
end

insert into Products (ProductName , Price)
values('Laptop', 30000)


--9. Create a trigger that fires after an UPDATE on the Products table. If the ProductName
 --is changed, print a message stating that the product name was altered.

 Create trigger tr_checkupdatename
 on products
 after update
 as
 begin 
 if UPDATE(ProductName)
 begin
 Print ('Product Name was altered')
 end
 end

 update Products set ProductName = 'Car' where ProductID = 1
 select * from Products

--10.Create a trigger that fires before an UPDATE on the Products table. If the Price is being
--increased by more than 50%, prevent the update and display a message.

Create trigger tr_preventupdateontablee
on products
instead of update
as
begin 
declare @oldprice money
select  @oldprice = price from inserted
declare @newprice money
set @newprice = @oldprice * 50/100
if exists (select 1 from Products where Price > @newprice)
begin
raiserror ('Cant update' , 16,1)
end
end
