USE classicmodels;

#no1
(SELECT c.customerName, p.productName, p.buyPrice*(sum(od.quantityOrdered)) modal 
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products p USING(productcode)
GROUP BY c.customerNumber
ORDER BY `modal` DESC 
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, p.buyPrice*(sum(od.quantityOrdered)) modal 
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products p USING(productcode)
GROUP BY c.customerNumber
ORDER BY `modal` 
LIMIT 3);

#no2
SELECT city
FROM (
	SELECT o.city
	FROM employees e
	JOIN offices o USING(officecode)
	WHERE e.firstName LIKE 'L%'
	UNION ALL
	SELECT c.city
	FROM customers c
	WHERE c.customername LIKE 'L%') AS dataCustEmployee
GROUP BY city
ORDER BY COUNT(*) DESC 
LIMIT 1;

#no3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan/Pelanggan', 'karyawan' AS status
FROM employees e
WHERE e.officeCode IN (
  SELECT officeCode
  FROM employees
  GROUP BY officeCode
  HAVING COUNT(*) = (
    SELECT MIN(numEmployees)
    FROM (
      SELECT officeCode, COUNT(*) AS numEmployees
      FROM employees
      GROUP BY officeCode
    ) AS OfficeEmployeeCounts
  )
)
UNION 
SELECT c.customerName AS 'Nama Karyawan/Pelanggan', 'pelanggan' AS status
FROM customers c
WHERE C.salesRepEmployeeNumber IN (
  SELECT employeeNumber
  FROM employees
  WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
      SELECT MIN(numEmployees)
      FROM (
        SELECT officeCode, COUNT(*) AS numEmployees
        FROM employees
        GROUP BY officeCode
      ) AS OfficeEmployeeCounts
    )
  )
)
ORDER BY `Nama Karyawan/Pelanggan`;


#no4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') riwayat
FROM (
	SELECT orderdate AS tanggal, 'memesan barang' AS riwayat
	FROM orders 
	WHERE month(orderdate) = 4 AND YEAR(orderdate) = 2003 
	UNION 
	SELECT paymentdate as tanggal, 'membayar barang' AS riwayat
	FROM payments 
	WHERE month(paymentdate) = 4 AND YEAR(paymentdate) = 2003
	) AS riwayatCust 
GROUP BY `tanggal`;

#soal tambahan
SELECT 
		c.customerName, 
		group_concat(p.productName) AS tahunBuat, 
		p.quantityInStock, 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'durasi pengiriman', 
		'pelanggan inisial vokal yang membeli produk keluaran 1800an dengan total durasi  pengiriman diatas rata-rata totalnya di seluruh bulan' AS 'keterangan'
FROM customers c
JOIN orders o 
USING(customernumber)
join orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
WHERE p.productName LIKE '18%' AND LEFT (c.customerName , 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY p.productName 
HAVING SUM(`durasi pengiriman`) >
								(SELECT AVG(total)
								FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) as total FROM orders o
								ORDER BY o.orderDate
								 ) AS jumlah)		
UNION 
SELECT 
		c.customerName, 
		group_concat(p.productName) AS tahunBuat, 
		p.quantityInStock, 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'durasi pengiriman', 
		'pelanggan inisial vokal yang membeli produk keluaran 1900an dengan total durasi  pengiriman diatas 10x rata-rata totalnya pada orderan di bulan ganjil' AS 'keterangan'
FROM customers c
JOIN orders o 
USING(customernumber)
join orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
WHERE p.productName LIKE '19%' AND LEFT (c.customerName , 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY p.productName 
HAVING SUM(`durasi pengiriman`) >
								(SELECT AVG(total)
								FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) as total FROM orders o
								ORDER BY o.orderDate
								 ) AS jumlah)	
UNION 
SELECT 
		c.customerName, 
		group_concat(p.productName) AS tahunBuat, 
		p.quantityInStock, 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'durasi pengiriman', 
		'pelanggan inisial vokal yang membeli produk keluaran 2000an dengan total durasi  pengiriman diatas 2x rata-rata totalnya pada orderan di bulan genap' AS 'keterangan'
FROM customers c
JOIN orders o 
USING(customernumber)
join orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
WHERE p.productName LIKE '20%' AND LEFT (c.customerName , 1) NOT IN ('a', 'i', 'u', 'e', 'o')
GROUP BY p.productName 
HAVING SUM(`durasi pengiriman`) >
								(SELECT AVG(total)
								FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) as total FROM orders o
								ORDER BY o.orderDate
								 ) AS jumlah);
								 
								 
								 
								 


#soal tambahan
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
ORDER BY `jumlah produk` DESC 
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
LIMIT 11, 1)