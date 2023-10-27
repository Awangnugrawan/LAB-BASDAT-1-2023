USE classicmodels

-- Nomor 1
SELECT 
		CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee',
		GROUP_CONCAT(o.orderNumber SEPARATOR ', ') AS 'Nomor Orderan',
		COUNT(o.orderNumber) AS 'Jumlah pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 20;

-- Nomor 2
SELECT 
		p.productCode,
		p.productName,
		p.quantityInStock,
		MIN(o.orderDate) AS orderDate
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productName
ORDER BY o.orderDate;

-- Nomor 3
SELECT o.addressLine1 AS 'Alamat',
		 CONCAT(SUBSTRING(o.phone,1,6),'* **') AS 'Nomor Telp',
		 COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
		 COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
		 FORMAT(AVG(p.amount), 2) AS 'Rata-rata Penghasilan'
FROM offices o
LEFT JOIN employees e
USING (officeCode)
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p 
USING (customerNumber)
GROUP BY o.addressLine1
ORDER BY o.phone;

-- Nomor 4
SELECT 
		 c.customerName,
		 YEAR(o.orderDate) AS 'tahun order',
		 MONTH(o.orderDate) AS 'bulan order',
		 COUNT(o.orderNumber) AS 'jumlah pesanan',
		 SUM(od.priceEach * od.quantityOrdered) AS 'uang total penjualan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE YEAR (o.orderDate) = 2003
GROUP BY c.customerName, YEAR(o.orderDate), MONTH(o.orderDate);


-- TAMBAHAN
-- Nomor 1
SELECT c.customerName, 
       COUNT(o.orderNumber) AS 'jumlah_orderan', 
       SUM(od.quantityOrdered) AS 'total_orderan'
FROM customers c
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
WHERE c.customerName LIKE 'D%'
GROUP BY c.customerName
HAVING SUM(od.quantityOrdered) > 500
ORDER BY SUM(od.quantityOrdered) DESC;

-- Nomor 2
SELECT p.productName AS 'nama produk', 
       YEAR(o.orderDate) AS 'tahun', 
       MONTH(o.orderDate) AS 'bulan', 
       DAY(o.orderDate) AS 'tanggal', 
       SUM(od.quantityOrdered) AS 'total_pesanan'
FROM products p
JOIN orderdetails od 
USING (productCode)
JOIN orders o
USING (orderNumber)
WHERE (MONTH(o.orderDate) % 2 = 1) 
AND (p.productName LIKE '19%') 
GROUP BY p.productName, YEAR(o.orderDate)
HAVING COUNT(od.quantityOrdered) < 450;










