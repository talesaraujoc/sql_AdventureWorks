use AdventureWorks2017;

-- Filtrando produtos que pesam mais de 500 sem ultrapassar o limite de 700
SELECT Name, Weight 
FROM Production.Product
where Weight >= '500' and Weight < '700';


-- Filtrando employees casados e assalariados
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus='M' and SalariedFlag = '1' ;


-- Localizando endere�o de e-mail do employee Peter Krebs
SELECT * FROM Person.Person
WHERE FirstName='Peter' and LastName='Krebs';


SELECT * FROM Person.EmailAddress
WHERE BusinessEntityID='26';
-- Outra forma de responder a pergunta acima (usando group by)
SELECT Person.EmailAddress.BusinessEntityID, Person.EmailAddress.EmailAddress, Person.EmailAddress.rowguid, Person.Person.FirstName, Person.Person.LastName, Person.Person.rowguid
FROM Person.EmailAddress JOIN Person.Person
on Person.Person.BusinessEntityID = Person.EmailAddress.BusinessEntityID
WHERE FirstName = 'Peter' and LastName = 'Krebs';


-- Quantos produtos est�o cadastrados na base de dados?
SELECT count(DISTINCT ProductNumber) FROM Production.Product;


-- Quantos tamanhos de produtos est�o cadastrados na base de dados?
SELECT count(DISTINCT Size) FROM Production.Product;

SELECT Size, count(Size) from Production.Product
GROUP BY Size
order by count(Size);


-- 10 produtos mais caros (ordenados de forma descendente):
SELECT TOP 10 ProductID, Name, ListPrice 
FROM Production.Product
ORDER BY ListPrice desc;


-- Obter o nome e n�mero dos produtos os quais possuem ProductID entre 1~4
SELECT ProductID, Name 
FROM Production.Product
WHERE ProductID BETWEEN '1' and '4';


-- Quantos produtos >= 1500:
SELECT COUNT(ListPrice) 
FROM Production.Product
WHERE ListPrice >= 1500;


-- Quantas pessoas tem nome o qual inicia com a letra 'P':
SELECT COUNT(FirstName) 
FROM Person.Person
WHERE FirstName LIKE ('P%');


-- Em quantas cidades �nicas os clientes est�o cadastrados:
SELECT COUNT(DISTINCT City) 
FROM Person.Address;


-- Quais as cidades �nicas que temos cadastradas no sistema:
SELECT DISTINCT City 
FROM Person.Address
ORDER BY City asc;


-- Quantos produtos vermelhos possuem pre�o entre 500~1000:
SELECT COUNT(DISTINCT ProductID) 
FROM Production.Product
WHERE Color = 'Red' and ListPrice BETWEEN '500' and '1000';


-- Quantos produtos cadastrados tem a palavra 'road' no nome deles:
SELECT COUNT(*) 
FROM Production.Product
WHERE Name LIKE ('%road%')


-- Quantas unidades de cada produta foi vendida:
SELECT ProductID, SUM(OrderQty) AS Qtde_vendida
FROM Sales.SalesOrderDetail
GROUP BY ProductID
order by Qtde_vendida desc;


-- M�dia de pre�o para produtos prata
SELECT Color, AVG(ListPrice) 
FROM Production.Product
WHERE Color = 'Silver' and ListPrice > 0
GROUP BY Color;


-- Quantas pessoas tem o mesmo MiddleName (agrupar):
SELECT MiddleName, COUNT(FirstName) AS Count_MiddleName 
FROM Person.Person
GROUP BY MiddleName
order by Count_MiddleName


-- Em m�dia, qual � a quantidade que cada produto � vendido:
SELECT ProductID, AVG(OrderQty)   
FROM Sales.SalesOrderDetail
GROUP BY ProductID


-- top 10 vendas agregado por produto
SELECT TOP 10 Sales.SalesOrderDetail.ProductID, SUM(Sales.SalesOrderDetail.LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY SALES.SalesOrderDetail.ProductID
ORDER BY SUM(LineTotal) DESC;


-- Quantos produtos e qual a quantidade m�dia de produtos temos cadastrados na nossa base de dados?
SELECT ProductID, AVG(OrderQty) AS "Avg_Qty"  
FROM Production.WorkOrder
GROUP BY ProductID
ORDER BY Avg_Qty desc;


-- Nomes mais comuns no sistema com pelo menos n=10:
SELECT FirstName, COUNT(FirstName) AS "Result"
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) >= 5
ORDER BY Result


-- Produtos com total de vendas entre 162k ~ 500k:
SELECT Sales.SalesOrderDetail.ProductID, SUM(Sales.SalesOrderDetail.LineTotal) AS 'Result'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(Sales.SalesOrderDetail.LineTotal) >=162000 and SUM(Sales.SalesOrderDetail.LineTotal) <=500000
ORDER BY Result DESC;


-- Prov�ncias com o maior n�mero de cadastros:
SELECT *
FROM Person.StateProvince

SELECT *
FROM Person.Address

SELECT Person.Address.StateProvinceID, COUNT(Person.Address.StateProvinceID) AS "Result"
FROM Person.Address
GROUP BY Person.Address.StateProvinceID
HAVING COUNT(Person.Address.StateProvinceID) >= 1000
ORDER BY Result desc;
--#SELECT Person.Address.StateProvinceID,Person.Address.rowguid, Person.StateProvince.Name, Person.StateProvince.rowguid
--#FROM Person.Address JOIN Person.StateProvince
--#ON Person.StateProvince.StateProvinceID = Person.Address.StateProvinceID


-- Produtos com pelo menos 1mi em vendas
SELECT Sales.SalesOrderDetail.ProductID, SUM(Sales.SalesOrderDetail.LineTotal) AS "Result"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(Sales.SalesOrderDetail.LineTotal) <'1000000'
ORDER BY Result DESC;


-- FirstName e LastName traduzidos:
SELECT FirstName AS "Primeiro_nome", LastName AS "Ultimo_nome"
FROM Person.Person;
--ProductNumber -> Numero_produto:
SELECT ProductNumber as "Codigo_produto"
FROM Production.Product;
--UnitPrice -> Preco_unit
SELECT Sales.SalesOrderDetail.UnitPrice as "Preco_unit"
FROM Sales.SalesOrderDetail



-- BusinessEntityId, FirstName, LastName, EmailAddress
SELECT *
FROM Person.Person

SELECT *
FROM Person.EmailAddress;

SELECT Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.LastName, Person.EmailAddress.EmailAddress
FROM Person.Person
INNER JOIN Person.EmailAddress ON Person.Person.BusinessEntityID = Person.EmailAddress.BusinessEntityID
ORDER BY Person.Person.BusinessEntityID;


-- ListPrice, ProductName, SubcategoryName
SELECT *
FROM Production.Product

SELECT *
FROM Production.ProductSubcategory;

SELECT Production.Product.ListPrice, Production.Product.Name, Production.ProductSubcategory.Name AS "Subcategory_name"
FROM Production.Product
INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID;

--BusinessEntityId, Name, PhoneNumberTypeId, PhoneNumber
SELECT * FROM Person.PersonPhone

SELECT * FROM Person.PhoneNumberType;

SELECT Person.PersonPhone.BusinessEntityID, Person.PersonPhone.PhoneNumberTypeID, Person.PersonPhone.PhoneNumber, Person.PhoneNumberType.Name
FROM Person.PersonPhone 
JOIN Person.PhoneNumberType ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID 

-- AddressId, City, StateProvinceID, Name(state)
SELECT * FROM Person.Address

SELECT * FROM Person.StateProvince;

SELECT Person.Address.AddressID, Person.Address.City, Person.StateProvince.StateProvinceID, Person.StateProvince.Name
FROM Person.Address
INNER JOIN Person.StateProvince ON Person.StateProvince.StateProvinceID = Person.Address.StateProvinceID

-- Quais pessoas possuem cartão de crédito registrado:
SELECT * FROM Person.Person

SELECT * FROM Sales.PersonCreditCard;

SELECT *
FROM Person.Person
LEFT JOIN Sales.PersonCreditCard ON Person.Person.BusinessEntityID = Sales.PersonCreditCard.BusinessEntityID;
-- 19.972 ROWS

SELECT * 
FROM Person.Person
INNER JOIN Sales.PersonCreditCard ON Person.Person.BusinessEntityID = Sales.PersonCreditCard.BusinessEntityID;
-- 19.118 ROWS (retorna só a intersecção)

