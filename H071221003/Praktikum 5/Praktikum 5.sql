USE classicmodels;
SELECT DISTINCT STATUS  FROM orders
-- NOMOR 1
SELECT c.customername, p.productname, p2.paymentdate, o.status
FROM customers c
JOIN orders o USING (customernumber)
JOIN payments p2 USING (customernumber) 
JOIN orderdetails o2 USING (orderNumber) 
JOIN products p USING (productcode)
WHERE customername LIKE  "%Signal%" AND productname LIKE "%Ferrari%" AND STATUS = 'Shipped'

-- NOMOR 2
-- A.
SELECT c.customername, MONTHNAME (p.paymentdate) AS "Bulan", CONCAT (e.firstname," ", e.lastname) AS "Nama Karyawan"
FROM customers c JOIN payments p USING (customernumber)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE MONTHNAME (p.paymentdate) IN ("November")

-- B
SELECT c.customername, MONTHNAME (p.paymentdate) AS "Bulan",p.amount, CONCAT (e.firstname," ", e.lastname)  AS "Nama Karyawan"
FROM customers c JOIN payments p USING (customernumber)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE MONTHNAME (p.paymentdate) IN ("November")
ORDER BY p.amount DESC 
LIMIT 1

-- C
SELECT c.customername,p.productname
FROM customers c 
JOIN orders o USING (customernumber)
JOIN payments p2 USING (customernumber) 
JOIN orderdetails o2 USING (orderNumber) 
JOIN products p USING (productcode)
WHERE MONTHNAME (p2.paymentdate) IN ("November") AND c.customerName LIKE "Corporate%"

-- D
SELECT c.customerName, GROUP_CONCAT(p.productName) AS 'Nama Produk'
FROM payments p2
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails o2
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTHNAME (p2.paymentDate) IN ("November") AND customerName LIKE ('Corporate%')

-- NOMOR 3
SELECT c.customername, o.orderdate, o.shippeddate, DATEDIFF (o.shippedDate, o.orderDate) AS 'Lama Hari'
FROM customers c 
JOIN orders o USING (customernumber)
WHERE c.customername LIKE "%GiftsForHim.com%" AND o.orderDate <> 'NULL' AND o.shippedDate <> 'NULL'

-- NOMOR 4
USE world

SELECT * FROM country

SELECT `code`, `name`, lifeExpectancy
FROM country
WHERE `code` LIKE ('C%K') AND lifeExpectancy <> 'NULL';


-- Soal Tambahan (4 dan 5)
SELECT DISTINCT c.customername AS "Nama Pelanggan", o.comments AS "Komentar", p.amount AS "Pembayaran"
FROM customers c
JOIN orders o USING (customernumber)
JOIN payments p USING (customernumber)
WHERE p.amount > 80000 AND o.comments IS NOT NULL AND  LEFT (c.customername,1) IN ('a','i','u','e','o')

SELECT p.productname, o.orderdate, o.shippedDate
FROM orders o
JOIN orderdetails o2 USING (orderNumber) 
JOIN products p USING (productcode)
WHERE (productname LIKE "%19%" AND YEAR (orderdate) = 2003) AND shippeddate IS NULL 