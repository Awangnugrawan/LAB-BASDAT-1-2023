USE classicmodels

-- No1
(SELECT c.customerName, 
		 p.productName, 
		 (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM products AS p
JOIN orderdetails AS od USING (productCode)
JOIN orders USING (orderNumber)
JOIN customers AS c USING (customerNumber)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION
(SELECT c.customerName, 
		 p.productName, 
		 (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM products AS p
JOIN orderdetails AS od USING (productCode)
JOIN orders USING (orderNumber)
JOIN customers AS c USING (customerNumber)
GROUP BY c.customerName
ORDER BY modal ASC
LIMIT 3)

-- No2
SELECT `Kota`
FROM (SELECT CONCAT(firstName, ' ', lastName) AS 'nama karyawan/nama pelanggan', city AS 'Kota'
		FROM employees
		JOIN offices USING (officeCode)
		WHERE firstName LIKE 'L%'
		
		UNION 
		
		SELECT customerName AS 'nama karyawan/nama pelanggan', city AS 'Kota'
		FROM customers
		WHERE customerName LIKE 'L%') AS halo
GROUP BY `Kota`
ORDER BY COUNT(`Kota`) DESC
LIMIT 1

-- No3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan/Pelanggan', 'Karyawan' AS 'status'
FROM employees AS e
WHERE officeCode IN (SELECT officeCode FROM employees GROUP BY officeCode HAVING COUNT(officeCode) = 
						(SELECT COUNT(*) FROM employees GROUP BY officeCode ORDER BY count(*) ASC LIMIT 1))

UNION

SELECT c.customerName AS 'Nama Karyawan/Pelanggan', 'Pelanggan' AS 'status'
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE officeCode IN (SELECT officeCode FROM employees GROUP BY officeCode HAVING COUNT(officeCode) = 
						(SELECT COUNT(*) FROM employees GROUP BY officeCode ORDER BY count(*) ASC LIMIT 1))

-- No4
SELECT tanggal, GROUP_CONCAT(riwayat ORDER BY riwayat SEPARATOR ' dan ') AS riwayat
FROM (
		SELECT orderDate AS tanggal, 'memesan barang' AS 'riwayat'
		FROM orders
		WHERE YEAR(orderDate) = 2003 AND MONTH(orderDate) = 04
		
		UNION
		
		SELECT paymentDate AS tanggal, 'membayar pesanan' AS 'riwayat'
		FROM payments
		WHERE YEAR(paymentDate) = 2003 AND MONTH(paymentDate) = 04
) AS riwayat

GROUP BY tanggal 

-- No5
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