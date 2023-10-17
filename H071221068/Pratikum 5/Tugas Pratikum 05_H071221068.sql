
-- Nomor 1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
JOIN payments py
ON py.customerNumber = c.customerNumber
WHERE (p.productName LIKE '%Ferrari%' AND o.`status` = 'Shipped') AND c.customerName = 'Signal Gift Stores';

-- Nomor 2

-- A
SELECT DISTINCT c.customerName AS 'Nama Customer', py.paymentDate AS 'Tanggal Pembayaran', CONCAT(ep.firstName, ' ', ep.lastName) AS 'Nama Karyawan', py.amount
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
JOIN payments py
ON py.customerNumber = c.customerNumber
JOIN employees ep
ON ep.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(py.paymentDate) = '11';

-- B
SELECT DISTINCT c.customerName AS 'Nama Customer', py.paymentDate AS 'Tanggal Pembayaran', CONCAT(ep.firstName, ' ', ep.lastName) AS 'Nama Karyawan', py.amount
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
JOIN payments py
ON py.customerNumber = c.customerNumber
JOIN employees ep
ON ep.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(py.paymentDate) = '11'
ORDER BY py.amount DESC
LIMIT 1;

-- C
SELECT c.customerName AS 'Nama Customer', p.productName AS 'Nama Produk'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE c.customerNumber = 321;

-- D
SELECT c.customerName AS 'Nama Customer', GROUP_CONCAT(p.productName) AS 'Nama Produk'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE c.customerNumber = 321;

-- Nomor 3
SELECT DISTINCT c.customerName AS 'Nama Customer', DATE(o.orderDate) AS 'Tanggal Order', DATE(o.shippedDate) AS 'Tanggal Pengirimannya', DATEDIFF(o.shippedDate, o.orderDate) AS 'Waktu Menunggu'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
WHERE c.customerName = 'GiftsForHim.com' AND (o.orderDate IS NOT NULL AND o.shippedDate IS NOT NULL);

-- Nomor 4
SELECT c.Name, ct.Code, ct.Name, ct.LifeExpectancy
FROM city c
JOIN country ct
ON ct.Code = c.CountryCode
WHERE c.CountryCode LIKE 'C%K' AND ct.LifeExpectancy IS NOT NULL;


-- Soal Tambahan
#5
SELECT p.productName AS 'nama produk', o.orderDate AS 'Tanggal Pemesanan', o.shippedDate AS 'Tanggal Pengiriman'
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
JOIN orders o
ON o.orderNumber = od.orderNumber
WHERE p.productName LIKE '19%'AND (YEAR(o.orderDate) = 2003 AND o.shippedDate IS NULL);

#4
SELECT DISTINCT c.customerName AS 'Nama Pelanggan', o.comments AS 'Komentar', py.amount AS 'Pembayaran'
FROM customers c
JOIN orders o
ON o.customerNumber = c.customerNumber
JOIN payments py
ON py.customerNumber = c.customerNumber
WHERE (py.amount > 80000.00 AND 
o.comments IS NOT NULL) AND 
(c.customerName LIKE 'A%' OR c.customerName LIKE 'I%' OR c.customerName LIKE 'U%' OR c.customerName LIKE 'E%' OR c.customerName LIKE 'O%')
ORDER BY py.amount DESC;