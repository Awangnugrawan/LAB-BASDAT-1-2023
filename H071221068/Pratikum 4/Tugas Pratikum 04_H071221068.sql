-- NOMOR 01

SELECT * FROM orders;
SELECT c.customerName AS "Nama Customer", c.country AS "Negara", p.paymentDate AS "tanggal"
FROM customers c
JOIN payments p
USING (customerNumber)
WHERE p.paymentDate > "2004-12-31"
ORDER BY p.paymentDate ASC;

-- NOMOR 02
SELECT DISTINCT c.customerName AS "Nama Customer", p.productName, pl.textDescription
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN productlines pl
USING (productLine)
WHERE p.productName = "The Titanic";

-- NOMOR 03
ALTER TABLE products
ADD status VARCHAR(20);

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p
JOIN orderdetails od
USING (productCode)
ORDER BY od.quantityOrdered DESC
LIMIT 1;

UPDATE products p
SET status = "BEST SELLING"
WHERE p.productCode = "S12_4675";


-- NOMOR 4
ALTER TABLE orders
	DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE `orders`
	ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE orderdetails
	DROP FOREIGN KEY orderdetails_ibfk_1,
	DROP FOREIGN KEY orderdetails_ibfk_2;
	
ALTER TABLE `orderdetails`
	ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`) ON UPDATE CASCADE ON DELETE CASCADE,
	ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`) ON UPDATE CASCADE ON DELETE CASCADE;
	
SELECT * FROM orders
WHERE status = "Cancelled";

DELETE FROM orders
WHERE status = "Cancelled";

SELECT DISTINCT status FROM orders;

-- SOAL TAMBAHAN
-- USE classicmodels;
-- NOMOR 2
SELECT city FROM Customers
WHERE country = "Singapura";

Select * FROM employees
SELECT * FROM orders
SELECT * FROM orderdetails
SELECT territory FROM offices


SELECT DISTINCT e.firstName AS 'Nama Depan Karyawan', o.territory AS 'Teritorial', c.city, c.customerName AS 'Nama Pelanggan', p.amount AS 'Jumlah Pembayaran' 
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN offices o
ON o.officeCode = e.officeCode
WHERE o.country = 'Japan' AND c.city != 'Singapore'
ORDER BY p.amount DESC
LIMIT 3;

-- NOMOR 4
SELECT countr FROM customers

SELECT DISTINCT c.customerName AS 'Nama Pelanggan', p.productName AS 'Nama Produk', od.quantityOrdered AS 'Jumlah Orderan'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE p.productVendor = "Exoto Designs" AND c.country != 'Italy'


-- NOMOR 03
SELECT DISTINCT p.productName AS 'Nama Produk'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE addressLine1 != '' AND addressLine2 != '';

-- NOMOR 01
SELECT * FROM productlines
SELECT c.customerName AS 'Nama Pelanggan', p.productLine AS 'Jenis Produk', o.orderDate AS 'Tanggal Pemesanan', od.quantityOrdered AS 'Jumlah Pemesanan'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
JOIN productlines pl
ON pl.productLine = p.productLine
WHERE pl.productLine = 'Planes' AND od.quantityOrdered > 50
ORDER BY o.orderDate ASC


-- NOMOR 05
SELECT o.orderDate AS 'tanggal pemesanan', o.shippedDate AS 'tanggal pengiriman', p.productName AS 'Nama Produk'
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
JOIN orders o
ON o.orderNumber = od.orderNumber
JOIN customers c
ON c.customerNumber = o.customerNumber
WHERE p.quantityInStock < 100 AND od.quantityOrdered < 50;

