-- no 1--

SELECT YEAR(od.orderDate) tahun, COUNT(od.orderNumber) jumlah_pesanan
		, CASE 
				WHEN COUNT(od.orderNumber) > 150 THEN 'banyak'
				WHEN COUNT(od.orderNumber) < 75 THEN 'sedikit'
				ELSE 'sedang'
		  END kategori_pesanan
	FROM classicmodels.orders od
GROUP BY YEAR(od.orderDate)
ORDER BY COUNT(od.orderNumber) DESC
;

-- 2 --
SELECT CONCAT(e.firstName,' ',e.lastName) nama_pegawai, SUM(m.amount) gaji,
		CASE 
				WHEN SUM(m.amount) > (SELECT AVG(gaji)
				FROM (
				SELECT CONCAT(e.firstName,' ',e.lastName) nama_pegawai, SUM(m.amount) gaji
					FROM classicmodels.employees e
						  JOIN classicmodels.customers c ON e.employeeNumber=c.salesRepEmployeeNumber
						  JOIN classicmodels.payments m ON c.customerNumber=m.customerNumber
				   GROUP BY e.employeeNumber
				) sub_query) THEN 'di atas rata-rata total gaji karyawan'
				ELSE 'di bawah rata-rata total gaji karyawan'
		  END kategori_gaji
	FROM classicmodels.employees e
		  JOIN classicmodels.customers c ON e.employeeNumber=c.salesRepEmployeeNumber
		  JOIN classicmodels.payments m ON c.customerNumber=m.customerNumber
   GROUP BY e.employeeNumber
	ORDER BY gaji DESC

;
-- no 3 --

(SELECT c.customerName AS 'Nama Pelanggan', 
	GROUP_CONCAT(LEFT(p.productName, 4)) AS 'Tahun Pembuatan', 
	COUNT(p.productCode) AS 'Jumlah Produk', 
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
	CASE 
	WHEN MONTH(o.orderDate) % 2 = 1 AND 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (
																	SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total
																	FROM orders GROUP BY customerNumber) AS a) THEN 'Target 1'
	WHEN MONTH(o.orderDate) % 2 = 0 AND 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (
																	SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total 
																	FROM orders GROUP BY customerNumber) AS a) THEN 'Target 2'
	END 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '18%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL ORDER BY c.customerName ASC) 
	
UNION

(SELECT c.customerName,
	GROUP_CONCAT(LEFT(p.productName, 4)), 
	COUNT(p.productCode),
	SUM(DATEDIFF(o.shippedDate, o.orderDate)),
	CASE 
	WHEN MONTH(o.orderDate) % 2 = 1 AND 
		COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	
										SELECT COUNT(productCode) AS total 
										FROM products GROUP BY productCode) AS a) THEN 'Target 3'
	WHEN MONTH(o.orderDate) % 2 = 0 AND 
		COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	
										SELECT COUNT(productCode) AS total 
										FROM products GROUP BY productCode) AS a) THEN 'Target 4'
	END 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '19%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
	
UNION

(SELECT c.customerName,
		GROUP_CONCAT(LEFT(p.productName, 4)), 
		COUNT(p.productCode),
		SUM(DATEDIFF(o.shippedDate, o.orderDate)),
		CASE 
		WHEN MONTH(o.orderDate) % 2 = 1 AND 
			COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (
											SELECT COUNT(productCode) AS total 
											FROM products GROUP BY productCode) AS a) THEN 'Target 5'
		WHEN MONTH(o.orderDate) % 2 = 0 AND 
			COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (
											SELECT COUNT(productCode) AS total 
											FROM products GROUP BY productCode) AS a) THEN 'Target 6'
	END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
;
