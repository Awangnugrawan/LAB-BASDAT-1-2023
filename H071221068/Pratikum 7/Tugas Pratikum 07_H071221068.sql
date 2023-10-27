# Nomor 1
SELECT c.customerNumber,o.addressLine1, o.addressLine2, o.city, o.country, COUNT(p.amount)
FROM offices o
JOIN employees e
USING (officecode)
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
ON p.customerNumber = c.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(p.amount) =
	(SELECT COUNT(p.amount)
	FROM payments p
	GROUP BY p.customerNumber
	ORDER BY COUNT(p.amount) ASC
	LIMIT 1);

# Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', p.amount 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
WHERE p.amount = 
(SELECT MAX(amount) FROM payments) 
OR p.amount = 
(SELECT MIN(amount) FROM payments);

SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', SUM(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) =
	(SELECT SUM(p.amount) 'pendapatan'
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING (customernumber)
	GROUP BY e.employeeNumber
	ORDER BY pendapatan DESC
	LIMIT 1)
OR SUM(p.amount) =
	(SELECT SUM(p.amount) 'pendapatan'
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING (customernumber)
	GROUP BY e.employeeNumber
	ORDER BY pendapatan ASC
	LIMIT 1) 
	
# Nomor 3
SELECT
    c.Name 'Negara',
    c.Population 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.language = 
(SELECT countrylanguage.language
FROM countrylanguage
JOIN country
ON country.Code = countrylanguage.CountryCode
WHERE country.Continent = 'Asia'
GROUP BY countrylanguage.language
ORDER BY COUNT(countrylanguage.language) DESC
LIMIT 1) 
ORDER BY c.Population DESC;

# Nomor 4
SELECT
    c.customerName AS customerName,
    SUM(p.amount) AS Total_Pembayaran,
    SUM(od.quantityOrdered) AS Banyak_Barang,
    GROUP_CONCAT(pr.productName) AS Produk_Yang_Dibeli
FROM
    customers c
JOIN
    orders o ON c.customerNumber = o.customerNumber
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
JOIN
    products pr ON od.productCode = pr.productCode
JOIN
    payments p ON o.customerNumber = p.customerNumber
GROUP BY
    c.customerNumber
HAVING
    Total_Pembayaran >
    (SELECT AVG(subTotal)
     FROM (SELECT SUM(amount) AS subTotal
           FROM payments p JOIN customers c ON c.customerNumber = p.customerNumber
           GROUP BY c.customerNumber) AS avgTotal)
ORDER BY Total_Pembayaran DESC;

#Soal Tambahan
#1
SELECT c.customerName, COUNT(od.quantityOrdered), p.productName, SUM(py.amount) AS Total_Pembayaran
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
JOIN payments py
ON py.customerNumber = c.customerNumber
GROUP BY c.customerNumber
HAVING SUM(py.amount) <
(SELECT AVG(p.amount) 'pendapatan'
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING (customernumber)
	GROUP BY c.customerNumber
	ORDER BY pendapatan DESC
	LIMIT 1);

#2
SELECT DISTINCT productName AS 'Nama Produk', 
       LEFT(productName, 4) AS 'Tahun Pembuatan', 
       LENGTH(productName) AS 'Panjang Karakter'
FROM products
WHERE LENGTH(productName) > 
      (SELECT MIN(LENGTH(productName)) * 3
       FROM products)
AND (LEFT(productName, 4) LIKE '19%' OR LEFT(productName, 4) LIKE '20%');