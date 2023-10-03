USE classicmodels
SELECT * FROM customers
SELECT * FROM payments
SELECT * FROM products

-- NOMOR 1
SELECT c.customername AS 'Nama Customer', c.country AS 'Negara', p.paymentdate AS 'Tanggal'
FROM customers c
JOIN payments p 
USING (customernumber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY paymentdate


-- NOMOR 2
SELECT DISTINCT c.customername AS 'Nama Customer', p.productname, p2.textdescription
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails o2
USING (ordernumber)
JOIN products p 
USING (productcode)
JOIN productlines p2
USING (productline)
WHERE p.productname = 'The Titanic'


-- NOMOR 3
ALTER TABLE products
ADD `status` VARCHAR (20)

SELECT p.productcode, p.productname, o.quantityOrdered, p.`status`
FROM products p 
JOIN orderdetails o 
USING (productcode)
ORDER BY o.quantityordered DESC 
LIMIT 1

UPDATE products
SET `status` = 'BEST SELLING'
WHERE productcode = 'S12_4675'


-- NOMOR 4
SELECT * FROM orders 
WHERE STATUS = 'cancelled'

SELECT DISTINCT STATUS FROM orders

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY(ordernumber) REFERENCES orders (ordernumber) ON DELETE CASCADE; 

DELETE FROM orders
WHERE STATUS = 'cancelled'


-- NOMOR 5 (SOAL TAMBAHAN)
SELECT DISTINCT c.customername AS 'Nama Pelanggan', p.productname AS 'Nama Produk', o2.quantityordered AS 'Jumlah Orderan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails o2
USING (ordernumber)
JOIN products p 
USING (productcode)
WHERE p.productVendor = 'Exoto Designs' AND  c.country != 'Italy'

