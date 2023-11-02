USE classicmodelss;

-- nomor 1
(SELECT c.customername, p.productname, (od.priceeach * SUM(od.quantityordered)) AS "modal"
FROM customers c JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
GROUP BY c.customername
ORDER BY modal DESC 
LIMIT 3)
UNION 
(SELECT c.customername, p.productname, (od.priceeach * SUM(od.quantityordered)) AS "modal"
FROM customers c JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
GROUP BY c.customername
ORDER BY modal 
LIMIT 3)

-- nomor 2
SELECT city FROM (
	(SELECT city, COUNT(*) AS total
	FROM customers 
	WHERE customername LIKE "L%"
	GROUP BY city
	ORDER BY total DESC
	LIMIT 1)
	UNION
	(SELECT o.city, COUNT(*) AS total
	FROM employees e JOIN offices o USING (officecode)
	WHERE e.firstname LIKE "L%"
	GROUP BY o.city
	ORDER BY total
	LIMIT 1)) AS total
GROUP BY city;


-- nomor 3
SELECT customerName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(employee)
            FROM (
                SELECT COUNT(*) AS employee
                FROM employees
                GROUP BY officeCode
            ) AS office
        )
    )
)
UNION
SELECT firstName AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee)
        FROM (
            SELECT COUNT(*) AS employee
            FROM employees
            GROUP BY officeCode
        ) AS office
    )
)
ORDER BY `nama karyawan/pelanggan` 


-- nomor 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS combined_data
GROUP BY tanggal


-- soal tambahan
USE classicmodelss;

(SELECT
		c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName, 4)) AS tahunpembuatan, 
		COUNT(p.quantityInStock) AS jumlahproduk, 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS totalpengiriman,
		'Pelanggan Inisial Vokal yang membeli produk keluaran 1800an dengan total durasi pengiriman diatas rata rata totalnya diseluruh bulan' AS 'keterangan'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE (c.customerName LIKE 'a%' OR c.customerName LIKE 'i%' OR c.customerName LIKE 'u%' OR c.customerName LIKE 'e%' OR c.customerName LIKE 'o%') 
AND (p.productName LIKE '18%')
GROUP BY c.customerName
ORDER BY totalpengiriman DESC
LIMIT 1)

UNION

(SELECT
		c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName, 4)) , 
		COUNT(p.quantityInStock), 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS totalpengiriman,
		'Pelanggan Inisial Vokal yang membeli produk keluaran 1800an dengan total durasi pengiriman diatas rata rata totalnya diseluruh bulan' AS 'keterangan'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE (c.customerName LIKE 'a%' OR c.customerName LIKE 'i%' OR c.customerName LIKE 'u%' OR c.customerName LIKE 'e%' OR c.customerName LIKE 'o%') 
AND (p.productName LIKE '19%') AND c.customerName LIKE 'Anna%'
GROUP BY c.customerName)

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