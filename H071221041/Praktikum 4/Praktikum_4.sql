USE classicmodels;

-- no 1
SELECT c.customerName AS 'Nama customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal'
FROM customers c
INNER JOIN payments p
USING (customernumber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate;

-- no 2
SELECT DISTINCT c.customerName, p.productName, pl.textDescription
FROM customers c
INNER JOIN orders o
USING (customernumber)
INNER JOIN orderdetails od
USING(ordernumber)
INNER JOIN products p
USING (productcode)
INNER JOIN productlines pl
USING (productline)
WHERE p.productName = 'The Titanic';

-- no 3
ALTER TABLE products
ADD STATUS VARCHAR (20);
SELECT * FROM products;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
INNER JOIN orderdetails od
USING (productcode)
WHERE STATUS = 'best selling'
ORDER BY od.quantityOrdered desc
LIMIT 1;

UPDATE products
SET STATUS = 'best selling'
WHERE productcode = 'S12_4675'

-- no 4 
SELECT * FROM orders 
WHERE STATUS = 'cancelled'

SELECT DISTINCT STATUS FROM orders

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY(ordernumber) REFERENCES orders (ordernumber) ON DELETE CASCADE; 

DELETE FROM orders
WHERE STATUS = 'cancelled'

-- no 5 soal tambahan

#no 2
SELECT e.firstName AS 'nama depan karyawan', o.territory AS 'teritorial', c.city, c.customerName AS 'nama pelanggan', p.amount AS 'jumlah pembayaran'
FROM employees e
JOIN offices o
USING (officecode)
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
USING (customernumber)
WHERE o.territory = 'japan' AND c.city != 'singapore'
ORDER BY p.amount DESC
LIMIT 3

#no4
SELECT DISTINCT c.customername AS 'Nama Pelanggan', p.productname AS 'Nama Produk', od.quantityordered AS 'Jumlah Orderan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p 
USING (productcode)
WHERE p.productVendor = 'exoto designs' AND  c.country != 'italy'