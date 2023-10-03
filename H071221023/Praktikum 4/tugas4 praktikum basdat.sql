-- Nomor 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers c
JOIN payments p
USING (customerNumber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate;

-- Nomor 2
SELECT DISTINCT c.customerNumber AS 'Nama Customer', p.productName, p.productDescription AS 'textDescription'
FROM customers c
JOIN orders o  
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE p.productName = 'The Titanic';

-- Nomor 3
SELECT * FROM products 
SELECT * FROM orderdetails
ORDER BY quantityordered DESC

ALTER TABLE products
ADD `status` VARCHAR (20);

UPDATE products
SET `status` = 'best selling'
WHERE productcode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p
JOIN orderdetails od
USING (productCode)
ORDER BY quantityordered DESC
LIMIT 1;


-- Nomor 4 
SELECT * FROM orders
WHERE `status` = 'cancelled';
SELECT * FROM orderdetails

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE FROM orders
WHERE `status` = 'cancelled';

SELECT DISTINCT o.`status`
FROM customers c
JOIN orders o
USING (customerNumber);


-- SOAL TAMBAHAN NO 3
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM orderdetails
SELECT * FROM products  

SELECT DISTINCT p.productName AS 'nama produk'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE addressLine1 != ''; 


-- SOAL TAMBAHAN NO 5
SELECT o.orderDate AS 'tanggal pemesanan',
o.shippedDate AS 'tanggal pengiriman',
p.productName AS 'Nama Produk'
FROM orders o
JOIN orderdetails od 
USING (orderNumber)
JOIN products p 
USING (productCode)
WHERE p.quantityInStock < 100 AND od.quantityOrdered < 50;




 





