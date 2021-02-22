--Cамый продаваемый продукт (и сколько продали)
SELECT Top 1 Production.Product.Name, SUM(Sales.SalesOrderDetail.OrderQty) as order_count from Sales.SalesOrderDetail
inner join Production.Product on Product.ProductID = SalesOrderDetail.ProductID
group by Name order by order_count desc

--Клиента, который больше всех купил товаров (и сколько купил)
with t(ID,Count) as (SELECT top 1 header.CustomerID, SUM(OrderQty) as res from Sales.SalesOrderHeader as header
    inner join Sales.SalesOrderDetail as detail on header.SalesOrderID = detail.SalesOrderID
    group by header.CustomerID order by res desc )
SELECT Person.FirstName, Person.LastName,Count from t
inner join Sales.Customer on CustomerID = ID
inner join Person.Person on Person.BusinessEntityID = Sales.Customer.PersonID

--Продавца, который продал больше всех товаров (и сколько продал)
with t(ID,Count) as (SELECT top 1 header.SalesPersonID, SUM(OrderQty) as res from Sales.SalesOrderHeader as header
    inner join Sales.SalesOrderDetail as detail on header.SalesOrderID = detail.SalesOrderID
    where SalesPersonID is not null
    group by header.SalesPersonID order by res desc )
SELECT Person.FirstName, Person.LastName, Count from t
inner join Sales.SalesPerson on BusinessEntityID = ID
inner join Person.Person on Person.BusinessEntityID = Sales.SalesPerson.BusinessEntityID

--Клиента, который потратил больше всего денег (и сколько потратил)

with t(ID,Count) as (SELECT top 1 header.CustomerID, SUM(TotalDue) as res from Sales.SalesOrderHeader as header
    inner join Sales.SalesOrderDetail as detail on header.SalesOrderID = detail.SalesOrderID
    group by header.CustomerID order by res desc )
SELECT Person.FirstName, Person.LastName,Count from t
inner join Sales.Customer on CustomerID = ID
inner join Person.Person on Person.BusinessEntityID = Sales.Customer.PersonID

/*
 Для каждого из вышеуказанных запросов создать запросы,
которые укажут все продукты, пользователей, продавцов и
соответствующие количественные значения
   */

SELECT Top Production.Product.Name, SUM(Sales.SalesOrderDetail.OrderQty) as order_count from Sales.SalesOrderDetail
inner join Production.Product on Product.ProductID = SalesOrderDetail.ProductID
group by Name order by order_count desc


with t(ID,Count) as (SELECT header.CustomerID, SUM(OrderQty) as res from Sales.SalesOrderHeader as header
    inner join Sales.SalesOrderDetail as detail on header.SalesOrderID = detail.SalesOrderID
    group by header.CustomerID )
SELECT Person.FirstName, Person.LastName,Count from t
inner join Sales.Customer on CustomerID = ID
inner join Person.Person on Person.BusinessEntityID = Sales.Customer.PersonID

--Продавца, который продал больше всех товаров (и сколько продал)
with t(ID,Count) as (SELECT header.SalesPersonID, SUM(OrderQty) as res from Sales.SalesOrderHeader as header
    inner join Sales.SalesOrderDetail as detail on header.SalesOrderID = detail.SalesOrderID
    where SalesPersonID is not null
    group by header.SalesPersonID)
SELECT Person.FirstName, Person.LastName, Count from t
inner join Sales.SalesPerson on BusinessEntityID = ID
inner join Person.Person on Person.BusinessEntityID = Sales.SalesPerson.BusinessEntityID

--Клиента, который потратил больше всего денег (и сколько потратил)

with t(ID,Count) as (SELECT header.CustomerID, SUM(TotalDue) as res from Sales.SalesOrderHeader as header
    inner join Sales.SalesOrderDetail as detail on header.SalesOrderID = detail.SalesOrderID
    group by header.CustomerID )
SELECT Person.FirstName, Person.LastName,Count from t
inner join Sales.Customer on CustomerID = ID
inner join Person.Person on Person.BusinessEntityID = Sales.Customer.PersonID
