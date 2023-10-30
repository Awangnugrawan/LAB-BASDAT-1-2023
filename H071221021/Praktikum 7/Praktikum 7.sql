USE world;
USE classicmodels;

-- Nomor 1
SELECT CONCAT_WS(' ', offices.addressline1, offices.addressLine2, 'Kota', offices.city, offices.country) AS Alamat,
		 customers.customerNumber AS 'Customer Number',
		 COUNT(payments.amount) AS 'Jumlah Pembayaran'
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices
USING (OfficeCode)
JOIN payments
USING (customerNumber)
GROUP BY customerNumber
-- ORDER BY COUNT(payments.amount)
HAVING COUNT(payments.amount) = (
	SELECT COUNT(payments.amount) FROM payments
	GROUP BY customerNumber
	ORDER BY COUNT(payments.amount) ASC
	LIMIT 1);
	
-- Nomor 2
SELECT CONCAT(firstname, ' ', lastname) AS 'Nama Employee',
		 FORMAT(SUM(py.amount),2) AS 'Pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(py.amount) = (
	SELECT MAX(amounttotal) 
	FROM (
		SELECT SUM(py.amount) AS amounttotal 
		FROM customers c 
		JOIN payments py
		USING (CustomerNumber)
		GROUP BY c.salesRepEmployeeNumber
	) AS MaxPembayaran) 
OR SUM(py.amount) = (
	SELECT MIN(amounttotal) 
	FROM (
		SELECT SUM(py.amount) AS amounttotal
		FROM customers c
		JOIN payments py
		USING (CustomerNumber)
		GROUP BY c.salesRepEmployeeNumber
	) AS MinPembayaran);

-- Nomor 3
SELECT c.name AS 'Negara', c.population*cl.percentage AS 'Penggunaan Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.`Language` = (SELECT cl.`Language` FROM countrylanguage cl
														  JOIN country c
														  ON c.code = cl.CountryCode
														  WHERE c.Continent = 'Asia'
														  GROUP BY cl.`Language`
														  ORDER BY COUNT(cl.`Language`) DESC 
														  LIMIT 1)
GROUP BY `Penggunaan Bahasa` DESC;											

-- Nomor 4
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
		SELECT AVG(total) 
		FROM (
			SELECT SUM(py.amount) AS total 
			FROM payments py
			GROUP BY customerNumber
			) AS totalpembayaran)
ORDER BY SUM(py.amount) DESC;
 
-- Soal Tambahan
SELECT c.customername,
		 SUM(py.amount) AS 'Total Pembayaran',
		 COUNT(od.quantityordered) AS 'Total Barang',
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
HAVING SUM(py.amount) < (
		SELECT AVG(total) 
		FROM (
			SELECT SUM(py.amount) AS total 
			FROM payments py
			GROUP BY customerNumber
			) AS totalpembayaran)
ORDER BY SUM(py.amount) DESC;

SELECT DISTINCT productName AS "Nama Produk", 
		 LEFT(productName,4) AS 'Tahun Pembuatan',
		 LENGTH(productName) AS 'Panjang Karakter' FROM products
WHERE LENGTH(productName) > (SELECT MIN(LENGTH(productName))*3 FROM products) AND LEFT(productname,4) LIKE "1%";
