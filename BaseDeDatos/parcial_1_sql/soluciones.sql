-- Ejercicio 1

SELECT c.ContactName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS ingresos
FROM `Customers` AS c 
LEFT JOIN `Orders` AS o ON c.CustomerID = o.CustomerID 
LEFT JOIN `Order Details` AS od ON od.OrderID = o.OrderID 
GROUP BY c.CustomerID 
ORDER BY ingresos DESC
LIMIT 5;

-- Ejercicio 2

SELECT c.CategoryName, p.ProductName , SUM(od.Quantity) AS ventas_totales
FROM `Products` AS p 
LEFT JOIN `Categories`AS c ON c.CategoryID = p.CategoryID 
LEFT JOIN `Order Details` AS od ON p.ProductID = od.ProductID 
GROUP BY c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
ORDER BY c.CategoryName, Ventas_totales  DESC;

-- Ejercicio 3

SELECT c.CategoryName , sum(od.Quantity) AS ventas_totales
FROM `Categories` AS c
INNER JOIN `Products` AS p ON p.CategoryID = c.CategoryID 
INNER JOIN `Order Details` AS od ON od.ProductID = p.ProductID 
GROUP BY c.CategoryID 
ORDER BY ventas_totales DESC;

-- Ejercicio 4


CREATE VIEW best_employee AS
	SELECT CONCAT(e.FirstName, ' ', e.LastName) AS `employee`,
  		YEAR(o.OrderDate),
  		SUM(od.Quantity)
	FROM (
		SELECT CONCAT(e.FirstName, ' ', e.LastName), YEAR(o.OrderDate), SUM(od.Quantity)
		FROM `Employees` AS e 
		INNER JOIN `Orders` AS o ON e.EmployeeID = o.EmployeeID
		INNER JOIN `Order Details` AS od ON od.OrderID = o.OrderID
		GROUP BY e.EmployeeID, YEAR(o.OrderDate) 
		HAVING SUM(od.Quantity) > ALL (
			SELECT SUM(od.Quantity)
			FROM Orders AS o
			INNER JOIN `Order Details` AS od ON od.OrderID = o.OrderID 
			GROUP BY YEAR(o.OrderDate);	
			)) ;

-- Ejercicio 5

DELIMITER $$
CREATE TRIGGER `update_stock`
AFTER INSERT ON `Order Details`
FOR EACH ROW
BEGIN 
	UPDATE `Products`
	SET `UnitsInStock` = `UnitsInStock` - NEW.`Quantity`
	WHERE `ProductID` = NEW.`ProductID`;
END$$
DELIMITER ;


-- Ejericico 6
CREATE ROLE admin;
GRANT INSERT ON `Customers` TO admin;
GRANT UPDATE (Phone) ON `Customers` TO admin;





