-- Nomor 1
SELECT c.customerName AS 'Nama Customer', c.state AS Negara, p.paymentDate AS tanggal
FROM customers c
JOIN payments p
USING (customerNumber)
WHERE paymentDate > '2005-01-01'
ORDER BY paymentDate;

-- Nomor 2
SELECT DISTINCT c.customerName AS 'Nama Customers', p.productName, pl.textDescription
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN productlines pl
USING (productline)
WHERE p.productName = 'The Titanic';

-- Nomor 3
ALTER TABLE products
ADD status VARCHAR (20);

UPDATE products p
SET status = 'BEST SELLING'
WHERE productCode = S12_4675;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
JOIN orderdetails od
USING (productCode)
ORDER BY quantityordered DESC
LIMIT 1;

-- Nomor 4
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (customerNumber)
REFERENCES customers(customerNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE payments
ADD CONSTRAINT payments_ibfk_1
FOREIGN KEY (customerNumber)
REFERENCES customers(customerNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_1
FOREIGN KEY (orderNumber)
REFERENCES orders(orderNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

DELETE c
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE o.`status` = 'Cancelled';

SELECT * FROM customers c
JOIN orders o
USING (customerNumber)
WHERE o.`status` = 'Cancelled';

SELECT DISTINCT o.`status`
FROM orders o;

-- Soal Tambahan NO 4

-- Pada sebuah perusahaan retail, Anda ditugaskan untuk membuat laporan yang menampilkan nama pelanggan, 
-- nama produk, dan jumlah pesanan untuk produk dari Exoto Designs yang dibeli oleh pelanggan di luar negara dengan 
-- julukan negeri Pizza. Laporan ini akan digunakan untuk mengidentifikasi pelanggan potensial dan tren penjualan produk 
-- Exoto Designs di luar negara tersebut.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM products;

SELECT DISTINCT c.customerNumber 'Nama Customer', p.productName AS 'Nama Produk', od.quantityOrdered AS 'Jumlah Pesanan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE p. productVendor = 'Exoto Designs' AND c.country != 'Italy';

-- Soal Tambahan NO 3
SELECT DISTINCT p.productName AS 'Nama Produk'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE c.addressLine1 IS NOT NULL;