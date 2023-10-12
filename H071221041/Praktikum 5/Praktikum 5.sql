USE classicmodels;

#no1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers c
JOIN payments py
USING (customernumber)
JOIN orders o
USING (customernumber)
JOIN orderdetails 
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '%ferrari%' AND o.`status` = 'shipped'
LIMIT 3

#no2 
##2a
SELECT c.customerName, py.paymentDate, CONCAT (e.firstName, ' ',e.lastName) AS 'nama karyawan', py.amount
FROM customers c
JOIN payments py 
USING (customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentdate) = 11

##2b
SELECT c.customerName, py.paymentDate, CONCAT (e.firstName, ' ',e.lastName) AS 'nama karyawan', py.amount
FROM customers c
JOIN payments py 
USING (customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentdate) = 11
ORDER BY amount DESC
LIMIT 1

##2c
SELECT c.customerName, p.productName
FROM customers c
JOIN payments py 
USING (customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productCode)
WHERE MONTH (paymentdate) = 11 AND customername = 'Corporate Gift Ideas Co.'
ORDER BY amount DESC

##2d
SELECT c.customerName, GROUP_CONCAT(p.productName) AS 'nama produk'
FROM customers c
JOIN payments py 
USING (customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productCode)
WHERE MONTH (paymentdate) = 11 AND customername = 'Corporate Gift Ideas Co.'
ORDER BY amount DESC

#no3
SELECT c.customerName, o.orderDate, o.shippedDate, o.shippedDate - o.orderDate AS 'waktu tunggu'
FROM customers c
JOIN orders o
USING (customernumber)
WHERE c.customerName = 'giftsforhim.com'

#no 4
##4a
SELECT CODE, NAME, LifeExpectancy
FROM country
WHERE CODE LIKE 'c%k' AND LifeExpectancy IS NOT NULL 
 


