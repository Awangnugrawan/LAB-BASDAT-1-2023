USE classicmodels

-- No1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS c 
JOIN payments AS p USING (customerNumber)
-- ON c.customerNumber = p.customerNumber
WHERE paymentDate >= '2005-01-01'
ORDER BY paymentDate;

-- No2
SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM products AS p 
JOIN productlines AS pl USING (productLine)
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
JOIN customers AS c USING (customerNumber)
WHERE p.productName = 'The Titanic';

-- No3
ALTER TABLE products
ADD status VARCHAR(20);

SELECT productCode
FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products
-- JOIN orderdetails AS USING (productCode)
SET status = 'best selling'
WHERE productCode = 's12_4675'

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products AS p
JOIN orderdetails AS od USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;

-- No4
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;     
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;     
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;     
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;


DELETE customers
FROM customers
JOIN orders AS o USING (customerNumber)
WHERE o.STATUS = 'Cancelled'

SELECT DISTINCT status FROM orders

-- No5
SELECT DISTINCT o.orderDate AS 'tanggal pemesanan', o.shippedDate AS 'tanggal pengiriman', p.productName AS 'Nama Produk' 
FROM orders AS o
JOIN orderdetails USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE quantityInStock < 100 AND quantityOrdered < 50
ORDER BY orderDate