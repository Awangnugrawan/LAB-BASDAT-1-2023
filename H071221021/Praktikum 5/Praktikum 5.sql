USE classicmodels;

-- Nomor 1
SELECT c.customerName, p.productName, py.paymentDate, o.status
FROM customers c
JOIN payments py
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN  products p
USING (productCode)
WHERE productName LIKE ('%Ferrari%') AND STATUS = 'Shipped'
LIMIT 3;

-- Nomor 2
-- Bagian A
SELECT c.customerName AS 'Nama Customer', 
		 py.paymentdate AS 'Tanggal Pembayaran',
		 CONCAT (firstName, " ", lastName) AS 'Nama Karyawan',
		 py.amount
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING (customerNumber)
WHERE MONTHNAME (paymentDate) = ("November");

-- Bagian B
SELECT c.customerName AS 'Nama Customer', 
		 py.paymentdate AS 'Tanggal Pembayaran',
		 CONCAT (firstName, " ", lastName) AS 'Nama Karyawan',
		 py.amount
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING (customerNumber)
WHERE MONTHNAME (paymentDate) = ("November")
ORDER BY amount DESC
LIMIT 1;

-- Bagian C
SELECT c.customerName, p.productName
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTHNAME (paymentDate) = ("November")
AND customerName = 'Corporate Gift Ideas Co.'
ORDER BY amount DESC;

-- Bagian D
SELECT c.customerName AS 'Nama Customer', GROUP_CONCAT(p.productName) AS 'Nama Produk'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTHNAME (paymentDate) = ("November")
AND customerName = 'Corporate Gift Ideas Co.'
ORDER BY amount DESC;

-- Nomor 3
SELECT c.customerName AS 'Nama Customer', 
		 o.orderDate AS 'Tanggal Order', 
		 o.shippedDate AS 'Tanggal Pengiriman',
		 DATEDIFF (o.shippedDate, o.orderDate) AS 'Waktu Tunggu'
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE customerName = 'GiftsForHim.com';

-- Nomor 4
USE world	

SELECT * FROM country;

SELECT NAME, CODE, lifeExpectancy FROM country
WHERE CODE LIKE ('C_K') AND lifeExpectancy IS NOT NULL;

-- SOAL TAMBAHAN 4
SELECT c.customername AS 'Nama Pelanggan', o.comments AS Komentar, py.amount AS Pembayaran
FROM customers c
JOIN payments py
USING (customerNumber)
JOIN orders o
USING (customerNumber)
WHERE amount > 80000 AND (comments IS NOT NULL AND LEFT (c.customerName,1) IN ('a', 'i', 'u','e','o'));

-- SOAL TAMBAHAN 5
SELECT * FROM orders;
SELECT p.productName AS 'Nama Produk', o.orderdate AS 'Tanggal Pemesanan', o.shippedDate AS 'Tanggal Pengiriman'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE (productname LIKE '%19%' AND YEAR (orderdate) = 2003) AND shippeddate IS NULL; 