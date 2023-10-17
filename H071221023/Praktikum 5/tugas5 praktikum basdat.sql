-- Nomor 1
SELECT c.customerName, p.productName, od.paymentDate, o.`status`
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails 
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN payments od
USING (customerNumber)
WHERE c.customerName = 'Signal Gift Stores' AND p.productName LIKE '%Ferrari%'

--  Nomor 2
-- a
SELECT c.customerName, p.paymentDate, e.lastName, e.firstName
FROM customers c
JOIN payments p
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (p.paymentDate) = 11

-- b
SELECT c.customerName, p.customerNumber, p.paymentDate, p.amount
FROM payments p 
JOIN customers c
USING (customerNumber)
WHERE MONTH (p.paymentDate) = 11
ORDER BY p.amount DESC 
LIMIT 1

-- c
SELECT c.customerName, p.productName 
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN payments py
USING (customerNumber)
WHERE MONTH (py.paymentDate) = 11 AND c.customerName = 'Corporate Gift Ideas Co.'

-- d 
SELECT (c.customerName), GROUP_CONCAT(p.productName) AS productName 
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN payments py
USING (customerNumber)
WHERE MONTH (py.paymentDate) = 11 AND customerName = 'Corporate Gift Ideas Co.'

-- Nomor 3
SELECT c.customerName, o.orderDate, o.shippedDate, o.shippedDate - o.orderDate AS Menunggu
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com'

-- Nomor 4
-- a 
SELECT p.code, p.Name
FROM country AS p
WHERE p.code LIKE 'C%K'
-- b
SELECT p.code, p.Name, p.LifeExpectancy
FROM country AS p
WHERE p.LifeExpectancy IS NOT NULL 

-- jadi jawabannya adalah 
SELECT p.code, p.Name, p.LifeExpectancy
FROM country AS p
WHERE p.code LIKE 'C%K' AND p.LifeExpectancy


-- TAMBAHAN 
SELECT c.customerName AS 'Nama Pelanggan', c.addressLine2 AS 'Alamat Kedua Pelanggan', 
CONCAT(e.firstName, '', e.lastName) AS 'Nama Lengkap Karyawan', 
od.addressLine2 AS 'Alamat Kedua Karyawan'
FROM customers c
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices od
USING (officeCode)
WHERE c.addressLine2 IS NULL AND od.addressLine2 IS NULL;