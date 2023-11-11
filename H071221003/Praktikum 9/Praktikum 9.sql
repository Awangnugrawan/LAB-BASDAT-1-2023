USE classicmodels;

-- nomor 1
SELECT YEAR(orderdate) AS 'Tahun', COUNT(ordernumber) AS 'Jumlah Pesanan',
case
when COUNT(ordernumber) > 150 then 'Banyak'
when COUNT(ordernumber) < 75 then 'Sedikit'
ELSE 'Sedang'
END AS 'Kategori Pesanan'
FROM orders
GROUP BY YEAR(orderdate)
ORDER BY `Jumlah Pesanan` DESC 

-- nomor 2
SELECT CONCAT(e.firstname,' ', e.lastname) AS 'Nama Pegawai', SUM(p.amount) AS 'Gaji',
case 
when SUM(p.amount) > (SELECT AVG(total) FROM
							(SELECT SUM(amount) AS 'total'
							FROM customers 
							JOIN payments USING (customernumber)
							JOIN employees ON employeenumber = salesrepemployeenumber
							GROUP BY employeenumber)rata)
	then 'di atas rata-rata total gaji karyawan'
	ELSE 'di bawah rata-rata total gaji karyawan'
	END AS 'Kategori Gaji'
FROM employees e 
JOIN customers c ON c.salesRepEmployeeNumber = e.employeenumber
JOIN payments p USING (customernumber)
GROUP BY e.employeenumber
ORDER BY `gaji` DESC 

-- nomor 3
(SELECT c.customerName AS 'Pelanggan', 
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ',') AS 'Tahun Pembuatan', 
			 COUNT(p.productCode) AS 'Jumlah Produk', 
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 1'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 2'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '18%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL) 
UNION 	 
(SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 3'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 4'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '19%'	
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
UNION 	
(SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 5'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 6'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
ORDER BY `keterangan`;							