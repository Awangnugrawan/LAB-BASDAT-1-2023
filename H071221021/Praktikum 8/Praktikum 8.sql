-- Nomor 1
(SELECT c.customerName, p.productName, (p.buyPrice*SUM(od.quantityordered)) AS Modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNUmber)
JOIN products p
USING (productCode)
GROUP BY customerName
ORDER BY p.buyPrice*SUM(od.quantityordered) DESC
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, (p.buyPrice*SUM(od.quantityordered)) AS Modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNUmber)
JOIN products p
USING (productCode)
GROUP BY customerName
ORDER BY p.buyPrice*SUM(od.quantityordered)
LIMIT 3);

-- Nomor 2
SELECT city AS Lokasi
FROM (
		SELECT offices.city
		FROM employees
		JOIN offices
		USING (officeCode)
		WHERE firstName LIKE "L%"
		UNION ALL
		SELECT customers.city
		FROM customers
		WHERE CustomerName LIKE "L%") AS EmployeeCustomersName
GROUP BY Lokasi
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Nomor 3
SELECT CONCAT(firstname, ' ', lastname) AS 'Nama Karyawan/Pelanggan',
		 'Employee' AS status
FROM employees
WHERE employees.officeCode IN (SELECT officeCode
										 FROM employees
										 GROUP BY officeCode
										 HAVING COUNT(*) = (
										 SELECT MIN(NumEmployees)
										 FROM (
										 SELECT officeCode, COUNT(*) AS NumEmployees
										 FROM employees
										 GROUP BY officeCode) AS OfficeEmployeeCount))
UNION 
SELECT customerName AS 'Nama Karyawan/Pelanggan',
		 'Customer' AS status
FROM customers
WHERE customers.salesRepEmployeeNumber IN (SELECT employeeNumber
														 FROM employees
														 WHERE officeCode IN (
														 SELECT officeCode
														 FROM employees
														 GROUP BY officeCode
														 HAVING COUNT(*) = (
														 SELECT MIN(NumEmployees)
										 				 FROM (
										 				 SELECT officeCode, COUNT(*) AS NumEmployees
										 				 FROM employees
										 				 GROUP BY officeCode) AS OfficeCustomerCount)))
ORDER BY 'Nama Karyawan/Pelanggan' ASC;

-- Nomor 4
SELECT Tanggal,
		 GROUP_CONCAT(Riwayat SEPARATOR ' dan ') AS Riwayat
FROM (SELECT orderDate AS 'Tanggal', 'Memesan Barang' AS Riwayat
		FROM orders
		WHERE MONTH(orderdate) = 4 AND YEAR(orderdate) = 2003
UNION
SELECT paymentDate AS Tanggal,
		 'Membayar Pesanan' AS Riwayat
FROM payments
WHERE MONTH(paymentdate) = 4 AND YEAR(paymentDate) = 2003) AS datacustomers
GROUP BY Tanggal
ORDER BY Tanggal;