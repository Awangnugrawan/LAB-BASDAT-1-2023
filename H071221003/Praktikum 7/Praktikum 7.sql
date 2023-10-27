USE classicmodelss;

-- nomor 1
SELECT CONCAT_WS('| ', o.addressline1, o.addressLine2, o.city, o.country) AS Alamat,
		 c.customerNumber AS 'Customer Number',
		 COUNT(p.amount) AS 'Jumlah Pembayaran'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o
USING (OfficeCode)
JOIN payments p
USING (customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(p.amount) = (
	SELECT COUNT(pa.amount) FROM payments pa
	GROUP BY customerNumber
	ORDER BY COUNT(pa.amount) ASC
	LIMIT 1);


-- nomor 2
USE classicmodelss;

SELECT CONCAT(firstname, ' ', lastname) AS 'Nama Employee',
		 FORMAT(SUM(p.amount),2) AS 'Pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = (
	SELECT MAX(amounttotal) 
	FROM (
		SELECT SUM(p.amount) AS amounttotal 
		FROM customers c 
		JOIN payments p
		USING (CustomerNumber)
		GROUP BY c.salesRepEmployeeNumber
	) AS MaxPembayaran) 
OR SUM(p.amount) = (
	SELECT MIN(amounttotal) 
	FROM (
		SELECT SUM(p.amount) AS amounttotal
		FROM customers c
		JOIN payments p
		USING (CustomerNumber)
		GROUP BY c.salesRepEmployeeNumber
	) AS MinPembayaran);
	
	
-- nomor 3
USE worldd;

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;

SELECT c.Name AS 'Negara', (c.Population * cl.Percentage) AS 'Pengguna Bahasa'
FROM country AS c
JOIN countrylanguage AS cl ON c.Code = cl.CountryCode
WHERE cl.Language = ( SELECT cl.Language
								FROM countrylanguage AS cl
								JOIN country AS c ON cl.CountryCode = c.Code
								WHERE c.Continent = 'Asia'
								GROUP BY cl.Language
								ORDER BY COUNT(cl.Language) DESC
								LIMIT 1)
ORDER BY `Pengguna Bahasa` DESC ;
								
								
-- nomor 4
USE classicmodelss;

SELECT c.customername,
		 SUM(py.amount) AS 'Total Pembayaran',
		 SUM(od.quantityordered) AS 'Total Barang',
		 GROUP_CONCAT(p.productName) AS 'Produk yang dibeli'
FROM customers c
JOIN payments py
USING (customerNumber)
JOIN orders o
USING (CustomerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
HAVING SUM(py.amount) > (
		SELECT ROUND(AVG(total),1)
		FROM (
			SELECT SUM(py.amount) AS total 
			FROM payments py
			GROUP BY customerNumber
			) AS totalpembayaran)
ORDER BY SUM(py.amount) DESC;


-- nomor 5
USE classicmodelss;

-- 1.)
SELECT 
	c.customerName,
	COUNT(od.quantityOrdered) AS 'jumlah pesanan',
	p.productName,
	SUM(py.amount) AS 'Total Pembayaran'
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
								(SELECT ROUND(AVG(total))
								FROM (SELECT SUM(amount) as total FROM payments
								GROUP BY customernumber) AS jumlah);
								

-- 2.)
SELECT DISTINCT productName AS "Nama Produk", 
		 LEFT(productName,4) AS 'Tahun Pembuatan',
		 LENGTH(productName) AS 'Panjang Karakter' FROM products
WHERE LENGTH(productName) > (SELECT MIN(LENGTH(productName))*3 FROM products) AND 
(LEFT(productname,4) LIKE "19%" or LEFT(productname,4) LIKE "20%");