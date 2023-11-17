-- Nomor 1
SELECT YEAR(orderdate) AS Tahun,
		 COUNT(orderNumber) AS 'Jumlah Pesanan',
		 CASE
			WHEN COUNT(orderNumber) > 150 THEN 'Banyak'
			WHEN COUNT(orderNumber) < 75 THEN 'Sedikit'
			ELSE 'Sedang'
		 END AS 'Kategori Pesanan'
FROM orders
GROUP BY Tahun
ORDER BY COUNT(orderNumber) DESC;

-- Nomor 2
SELECT CONCAT(firstname, "  ", lastName) AS 'Nama Pegawai',
		 SUM(amount) AS Gaji,
		 CASE 
		 	WHEN SUM(amount) > AVG(SUM(amount)) OVER() THEN 'Diatas Rata-Rata'
			WHEN SUM(amount) < AVG(SUM(amount)) OVER() THEN 'Dibawah Rata-Rata'
			ELSE 'Rata-Rata'
		 END AS 'Kategori Gaji'
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments
USING (customerNumber)
GROUP BY employeeNumber, 'Nama Pegawai'
ORDER BY Gaji DESC; 

-- Nomor 3
(SELECT c.customerName AS 'Pelanggan',
		  GROUP_CONCAT(LEFT((p.productname),4)) AS 'Tahun_Pembuatan',
		  COUNT(p.productCode) AS 'Jumlah Produk',
		  SUM(DATEDIFF(o.shippeddate, o.orderdate)) AS 'Total Durasi Pengiriman',
		  CASE 
			 WHEN MONTH(o.orderDate) % 2 = 1 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					THEN 'Target 1'
			 WHEN MONTH(o.orderDate) % 2 = 0 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					THEN 'Target 2'
			END 'keterangan'
	FROM customers c
	JOIN orders o
	USING (customerNumber)
	JOIN orderdetails od
	USING (orderNumber)
	JOIN products p
	USING (productCode)
	WHERE p.productName LIKE "18%"
	GROUP BY c.customerNumber
	HAVING keterangan IS NOT NULL)
UNION 
(SELECT c.customerName AS 'Pelanggan',
		  GROUP_CONCAT(LEFT((p.productname),4)) AS 'Tahun_Pembuatan',
		  COUNT(p.productCode) AS 'Jumlah Produk',
		  SUM(DATEDIFF(o.shippeddate, o.orderdate)) AS 'Total Durasi Pengiriman',
		  CASE 
			 WHEN MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					THEN 'Target 3'
			 WHEN MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					THEN 'Target 4'
			END 'keterangan'
	FROM customers c
	JOIN orders o
	USING (customerNumber)
	JOIN orderdetails od
	USING (orderNumber)
	JOIN products p
	USING (productCode)
	WHERE p.productName LIKE "19%"
	GROUP BY c.customerNumber
	HAVING keterangan IS NOT NULL)
UNION 
(SELECT c.customerName AS 'Pelanggan',
		  GROUP_CONCAT(LEFT((p.productname),4)) AS 'Tahun_Pembuatan',
		  COUNT(p.productCode) AS 'Jumlah Produk',
		  SUM(DATEDIFF(o.shippeddate, o.orderdate)) AS 'Total Durasi Pengiriman',
		  CASE 
			 WHEN MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					THEN 'Target 5'
			 WHEN MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					THEN 'Target 6'
			END 'keterangan'
	FROM customers c
	JOIN orders o
	USING (customerNumber)
	JOIN orderdetails od
	USING (orderNumber)
	JOIN products p
	USING (productCode)
	WHERE p.productName LIKE "20%"
	GROUP BY c.customerNumber
	HAVING keterangan IS NOT NULL)
ORDER BY keterangan;