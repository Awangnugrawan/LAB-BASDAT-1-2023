#no1
SELECT 
	CONCAT(o.addressLine1, '|', o.addressLine2, '|', o.city, '|', o.country) AS alamat,
	c.customerNumber,
	count(p.amount)
FROM offices o
JOIN employees e
USING(officecode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customernumber)
GROUP BY c.customerNumber
HAVING count(p.amount) = 
	(
	SELECT COUNT(p.amount)
	FROM customers c
	JOIN payments p
	USING(customernumber)
	GROUP BY p.amount
	LIMIT 1
	);

#no2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', sum(p.amount) AS pendapatan
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = 
	(SELECT SUM(p.amount)
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING(customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) desc
	LIMIT 1) OR
SUM(p.amount) = 
	(SELECT SUM(p.amount)
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING(customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) asc
	LIMIT 1);

#no3
SELECT c.Name AS 'negara', c.Population* cl.Percentage AS 'pengguna bahasa'	
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.`Language` = 
							(SELECT cl.`Language`
							FROM countrylanguage cl
							JOIN country c
							ON cl.CountryCode = c.Code
							WHERE c.Continent = 'asia'
							GROUP BY cl.`Language`
							ORDER BY COUNT(cl.`Language`) DESC
							LIMIT 1)
ORDER BY `pengguna bahasa` DESC;

#no4
SELECT 
	c.customerName,
	SUM(py.amount) AS 'total pembayaran',
	SUM(od.quantityOrdered) AS 'total barang',
	GROUP_CONCAT(p.productName) AS 'produk yang dibeli'
FROM customers c
JOIN payments py
USING(customernumber)
JOIN orders o
USING(customernumber)
JOIN orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
GROUP BY c.customerNumber
HAVING SUM(py.amount) > 
								(SELECT round(AVG(total),2)
								FROM (SELECT SUM(amount) as total FROM payments
								GROUP BY customernumber) AS jumlah)
ORDER BY `total pembayaran` DESC;

#soal tambahan
##no1
SELECT 
	c.customerName,
	COUNT(od.quantityOrdered) AS 'jumlah pesanan',
	p.productName,
	SUM(py.amount)
FROM customers c
JOIN payments py
USING(customernumber)
JOIN orders o
USING(customernumber)
JOIN orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
GROUP BY c.customerNumber				
HAVING SUM(py.amount) < 
								(SELECT AVG(total)
								FROM (SELECT SUM(amount) as total FROM payments
								GROUP BY customernumber) AS jumlah);
##no2
SELECT DISTINCT productName AS "Nama Produk", 
		 LEFT(productName,4) AS 'Tahun Pembuatan',
		 LENGTH(productName) AS 'Panjang Karakter' 
		 FROM products
WHERE LENGTH(productName) > (SELECT MIN(LENGTH(productName))*3 FROM products) AND (LEFT(productname,4) LIKE "19%" OR LEFT(productname,4) LIKE "20%");
	


	


