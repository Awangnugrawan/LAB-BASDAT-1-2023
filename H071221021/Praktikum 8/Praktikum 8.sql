-- Nomor 1
(SELECT c.customerName, p.productName, (p.buyPrice*SUM(od.quantityordered)) AS Modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNUmber)
JOIN products p
USING (productCode)
GROUP BY customerName
ORDER BY p.buyPrice*SUM(od.quantityordered) DESC
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, (p.buyPrice*SUM(od.quantityordered)) AS Modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNUmber)
JOIN products p
USING (productCode)
GROUP BY customerName
ORDER BY p.buyPrice*SUM(od.quantityordered)
LIMIT 3);

-- Nomor 2
SELECT city AS Lokasi
FROM (
		SELECT offices.city
		FROM employees
		JOIN offices
		USING (officeCode)
		WHERE firstName LIKE "L%"
		UNION ALL
		SELECT customers.city
		FROM customers
		WHERE CustomerName LIKE "L%") AS EmployeeCustomersName
GROUP BY Lokasi
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Nomor 3
SELECT CONCAT(firstname, ' ', lastname) AS 'Nama Karyawan/Pelanggan',
		 'Employee' AS status
FROM employees
WHERE employees.officeCode IN (SELECT officeCode
										 FROM employees
										 GROUP BY officeCode
										 HAVING COUNT(*) = (
										 SELECT MIN(NumEmployees)
										 FROM (
										 SELECT officeCode, COUNT(*) AS NumEmployees
										 FROM employees
										 GROUP BY officeCode) AS OfficeEmployeeCount))
UNION 
SELECT customerName AS 'Nama Karyawan/Pelanggan',
		 'Customer' AS status
FROM customers
WHERE customers.salesRepEmployeeNumber IN (SELECT employeeNumber
														 FROM employees
														 WHERE officeCode IN (
														 SELECT officeCode
														 FROM employees
														 GROUP BY officeCode
														 HAVING COUNT(*) = (
														 SELECT MIN(NumEmployees)
										 				 FROM (
										 				 SELECT officeCode, COUNT(*) AS NumEmployees
										 				 FROM employees
										 				 GROUP BY officeCode) AS OfficeCustomerCount)))
ORDER BY `Nama Karyawan/Pelanggan` ASC;

-- Nomor 4
SELECT Tanggal,
		 GROUP_CONCAT(Riwayat SEPARATOR ' dan ') AS Riwayat
FROM (SELECT orderDate AS 'Tanggal', 'Memesan Barang' AS Riwayat
		FROM orders
		WHERE MONTH(orderdate) = 4 AND YEAR(orderdate) = 2003
UNION
SELECT paymentDate AS Tanggal,
		 'Membayar Pesanan' AS Riwayat
FROM payments
WHERE MONTH(paymentdate) = 4 AND YEAR(paymentDate) = 2003) AS datacustomers
GROUP BY Tanggal
ORDER BY Tanggal;

-- Soal Tambahan
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 13) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1800an dengan total durasi Pengiriman di atas rata-rata totalnya di seluruh bulan' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('18%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY pelanggan 
ORDER BY jumlah produk DESC 
LIMIT 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 212) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 10x rata-rata totalnya pada orderan di bulan ganjil' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('19%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY pelanggan
LIMIT 2, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		79 AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 187) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 10x rata-rata totalnya pada orderan di bulan ganjil' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('19%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY pelanggan
LIMIT 12, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 169) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 10x rata-rata totalnya pada orderan di bulan ganjil' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('19%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY pelanggan
LIMIT 15, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 66) AS 'Total durasi pengiriman',
		'Pelanggan inisial non vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 2x rata-rata totalnya pada orderan di bulan genap' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('20%') AND LEFT(customerName, 1) NOT IN ('a', 'i', 'u', 'e', 'o')
GROUP BY pelanggan
LIMIT 11, 1);