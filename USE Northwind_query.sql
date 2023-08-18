USE Northwind;

----------------------------------------------- SELF JOIN

-- FirstName | Ano Nascimento
SELECT A.FirstName, A.HireDate, b.FirstName, b.HireDate
FROM Employees A, Employees B
WHERE DATEPART(YEAR, A.HireDate) = DATEPART(YEAR, B.HireDate)


-- Quais produtos tem o mesmo percentual de desconto:
SELECT * FROM [Order Details];

SELECT A.ProductID, A.[Discount], B.ProductID, B.[Discount]
FROM [Order Details] AS A, [Order Details] AS B
WHERE A.Discount = B.Discount