-- Nomor 1
USE classicmodels

(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
GROUP BY c.customerName
ORDER BY modal ASC
LIMIT 3)

-- Nomor 2
SELECT city
FROM (
(SELECT city, COUNT(*) AS total
FROM customers
WHERE customerName LIKE 'L%'
GROUP BY city
ORDER BY total DESC
LIMIT 1)
UNION
(SELECT o.city, COUNT(*) AS total
FROM employees e
JOIN offices o USING (officeCode)
WHERE e.firstName LIKE 'L%'
GROUP BY o.city
ORDER BY total DESC
LIMIT 1)
) AS total_result
ORDER BY total DESC
LIMIT 1;

-- Nomor 3
(SELECT c.customerName AS 'Nama Karyawan/Pelanggan', 'Pelanggan' AS 'status'
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode IN (SELECT officeCode FROM employees
GROUP BY officeCode 
HAVING COUNT(employeeNumber) = ( SELECT COUNT(employeeNumber) FROM employees
GROUP BY (officeCode) 
ORDER BY COUNT(employeeNumber) 
LIMIT 1)))
UNION 
(SELECT CONCAT(firstName, ' ', lastName), 'Karyawan'
FROM employees AS e
WHERE e.officeCode IN (SELECT officeCode FROM employees
GROUP BY officeCode 
HAVING COUNT(employeeNumber) = ( SELECT COUNT(employeeNumber) FROM employees
GROUP BY (officeCode) 
ORDER BY COUNT(employeeNumber) 
LIMIT 1)))
ORDER BY `Nama Karyawan/Pelanggan` 

-- Nomor 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
    FROM orders
    WHERE YEAR(orderDate) = 2003 AND MONTH(orderDate) = 4
    UNION
    SELECT paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat
    FROM payments
    WHERE YEAR(paymentDate) = 2003 AND MONTH(paymentDate) = 4
) AS kombinasi
GROUP BY tanggal
ORDER BY tanggal;


-- Nomor Tambahan
USE classicmodels

(SELECT c.customerName AS 'pelanggan', 
		 GROUP_CONCAT(LEFT(p.productName, 4)) AS 'Tahun_Pembuatan', 
		 COUNT(p.productName) AS 'jumlah produk', 
		 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
		 'pelanggan inisial vokal yang membeli produk keluaran 1800an dengan Total durasi pengiriman diatas rata-rata totalnya di seluruh bulan' AS 'keterangan'
FROM customers AS c 
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE p.productName LIKE '18%'
AND LEFT(c.customerName, 1) IN ('A', 'I', 'U', 'E', 'O')  
GROUP BY c.customerName
HAVING SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS total
																					  				 FROM orders AS o
																									 JOIN customers USING (customerNumber)
																									 GROUP BY customerName)AS average)
)

UNION 

(SELECT c.customerName AS 'pelanggan', 
		 GROUP_CONCAT(LEFT(p.productName, 4)) AS 'Tahun_Pembuatan', 
		 COUNT(p.productName) AS 'jumlah produk', 
		 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
		 'pelanggan inisial vokal yang membeli produk keluaran 1900an dengan Total durasi pengiriman diatas 10x rata-rata totalnya pada orderan di bulan ganjil' AS 'keterangan'
FROM customers AS c 
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE p.productName LIKE '19%'
AND LEFT(c.customerName, 1) IN ('A', 'I', 'U', 'E', 'O')
AND MONTH(o.orderDate) % 2 <> 0
GROUP BY c.customerName
HAVING SUM(DATEDIFF(o.shippedDate, o.orderDate)) > 10*(SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS total
																					  				    FROM orders AS o
																									    JOIN customers USING (customerNumber)
																									    GROUP BY customerName)AS average)
)

UNION

(SELECT c.customerName AS 'pelanggan', 
		 GROUP_CONCAT(LEFT(p.productName, 4)) AS 'Tahun_Pembuatan', 
		 COUNT(p.productName) AS 'jumlah produk', 
		 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
		 'pelanggan inisial Non vokal yang membeli produk keluaran 2000an dengan Total durasi pengiriman diatas 2x rata-rata totalnya pada orderan di bulan genap' AS 'keterangan'
FROM customers AS c 
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE p.productName LIKE '20%'
AND LEFT(c.customerName, 1) NOT IN ('A', 'I', 'U', 'E', 'O')
AND MONTH(o.orderDate) % 2 = 0
GROUP BY c.customerName
HAVING SUM(DATEDIFF(o.shippedDate, o.orderDate)) > 2*(SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS total
																					  				   FROM orders AS o
																									   JOIN customers USING (customerNumber)
																									   GROUP BY customerName)AS average)
)