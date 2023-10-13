USE classicmodels

-- No1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS py USING (customerNumber)
JOIN orders AS o USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products AS p USING (productCode)

WHERE c.customerNumber = 112 AND p.productCode = 'S18_3232' AND o.`status` = 'shipped'
ORDER BY py.paymentDate DESC

-- No2
#a.)
	SELECT c.customerName, py.paymentDate, py.amount, CONCAT(e.firstName, ' ',  e.lastName) AS 'employeeName'
	FROM customers AS c
	JOIN payments AS py USING (customerNumber)
	JOIN employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
	
	WHERE MONTH(py.paymentDate) = '11'

#b.)
	SELECT c.customerName, py.paymentDate, py.amount, CONCAT(e.firstName, ' ',  e.lastName) AS 'employeeName'
	FROM customers AS c
	JOIN payments AS py USING (customerNumber)
	JOIN orders USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
	
	WHERE MONTH(py.paymentDate) = '11'
	ORDER BY py.amount DESC 
	LIMIT 1

#c.) 
	SELECT c.customerName, p.productName
	FROM customers AS c
	JOIN orders USING (customerNumber)
	JOIN orderdetails USING (orderNumber)
	JOIN products AS p USING (productCode)
	
	WHERE customerName LIKE '%Corporate Gift%' 
	
#d.) 
	SELECT c.customerName, GROUP_CONCAT(p.productName) AS purchased_products
	FROM customers AS c
	JOIN orders USING (customerNumber)
	JOIN orderdetails USING (orderNumber)
	JOIN products AS p USING (productCode)
	
	WHERE customerName LIKE '%Corporate Gift%'
	
-- No3
 SELECT c.customerName, o.orderDate, o.shippedDate, ABS (DATEDIFF(o.orderDate, o.shippedDate))
 FROM customers AS c
 JOIN orders AS o USING (customerNumber)
 
 WHERE customerName LIKE 'GiftsForHim.com'
 
--  No4
USE world

SELECT `Code`, lifeExpectancy, `Name` FROM country
WHERE `Code` LIKE 'C%K' AND lifeExpectancy IS NOT NULL

-- No5
SELECT p.productName AS 'Nama Produk', o.orderDate AS 'Tanggal Pemesanan', o.shippedDate AS 'Tanggal Pengiriman'
FROM products AS p
RIGHT JOIN orderdetails USING (productCode)
RIGHT JOIN orders AS o USING (orderNumber)
WHERE p.productName LIKE '19%' AND YEAR (o.orderDate) = '2003' AND o.shippedDate IS NULL