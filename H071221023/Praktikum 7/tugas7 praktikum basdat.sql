-- Nomor 1
USE classicmodels

SELECT o.addressLine1,
       o.addressLine2,
       o.city AS 'kota',
       o.country AS 'negara',
       c.customerNumber,
       COUNT(p.amount) AS 'jumlah pembayaran'
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o 
USING (officeCode)
JOIN payments p 
ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM payments
        GROUP BY customerNumber
        ORDER BY COUNT(*)
        LIMIT 1 )

-- Nomor 2
USE classicmodels

SELECT CONCAT(e.lastName, ' ', e.firstName) AS 'nama employee',
		 SUM(p.amount) AS 'pendapatan' 
FROM employees e 
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) =
		 (SELECT SUM(p.amount) FROM payments p
		 JOIN customers c
		 USING (customerNumber)
		 JOIN employees e
		 ON e.employeeNumber = c.salesRepEmployeeNumber
		 GROUP BY e.employeeNumber
		 ORDER BY SUM(p.amount) DESC 
		 LIMIT 1)
OR SUM(p.amount) =
		 (SELECT SUM(p.amount) FROM payments p
		 JOIN customers c
		 USING (customerNumber)
		 JOIN employees e
		 ON e.employeeNumber = c.salesRepEmployeeNumber
		 GROUP BY e.employeeNumber
		 ORDER BY SUM(p.amount)
		 LIMIT 1);

-- Nomor 3
USE world

SELECT c.`Name` AS 'Negara',
		 (c.Population * cl.Percentage) AS 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.`Code` = cl.CountryCode
WHERE cl.`Language` =
		(SELECT countrylanguage.`Language` 
		FROM countrylanguage
		JOIN country
		ON country.`Code` = countrylanguage.CountryCode
		WHERE country.Continent = 'Asia'
		GROUP BY countrylanguage.`Language`
		ORDER BY COUNT(countrylanguage.`Language`) DESC
		LIMIT 1)
ORDER BY (c.Population * cl.Percentage) DESC;	

-- Nomor 4
USE classicmodels 

SELECT c.customerName,
		 SUM(p.amount) AS 'Total pembayaran',
		 SUM(od.quantityOrdered) AS 'banyak barang',
		 GROUP_CONCAT(pr.productName SEPARATOR '; ') AS 'produk yang dibeli'
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY customerNumber
HAVING SUM(p.amount) >
		 (SELECT AVG(jumlah)
		 FROM (
		 		SELECT SUM(amount) AS 'jumlah'
		 		FROM payments 
		 		GROUP BY customerNumber) AS a)
ORDER BY SUM(p.amount) DESC;

-- Tambahan
-- Nomor 1
SELECT c.customerName, 
		 COUNT(od.quantityOrdered) AS jumlah_pesanan, 
		 pr.productName, 
		 SUM(p.amount) AS Total_pembayaran
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(p.amount) < (SELECT ROUND(AVG(total)) 
								FROM (SELECT SUM(amount) AS total
								FROM payments p
								GROUP BY p.customerNumber
								ORDER BY SUM(amount)) AS a);

 
-- Nomor 2
SELECT DISTINCT productName AS 'Nama Produk', 
       LEFT(productName, 4) AS 'Tahun Pembuatan', 
       LENGTH(productName) AS 'Panjang Karakter'
FROM products
WHERE LENGTH(productName) > 
      (SELECT MIN(LENGTH(productName)) * 3
       FROM products)
AND (LEFT(productName, 4) LIKE '19%' OR LEFT(productName, 4) LIKE '20%');


	
		 		
	


			
			

			

			
			
			
			