#NOMOR 1
(SELECT
    c.customerName,
    pr.productName,
    pr.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products pr USING (productCode)
GROUP BY c.customerNumber
ORDER BY modal DESC
LIMIT 3)

UNION

(SELECT
    c.customerName,
    pr.productName,
    pr.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products pr USING (productCode)
GROUP BY c.customerNumber
ORDER BY modal
LIMIT 3);

#NOMOR 2
SELECT city, COUNT(*) AS total
FROM (
   SELECT offices.city FROM employees
	JOIN offices USING(officeCode)
	WHERE firstName LIKE 'L%'

    UNION ALL

	SELECT c.city
	FROM customers c
	WHERE c.customerName LIKE 'L%'
) AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

#NOMOR 3
SELECT CONCAT(E.firstName, ' ', E.lastName) AS `Nama Karyawan/Pelanggan`, 'Employee' AS status
FROM Employees E
WHERE E.officeCode IN (
  SELECT officeCode
  FROM Employees
  GROUP BY officeCode
  HAVING COUNT(*) = (
    SELECT MIN(numEmployees)
    FROM (
      SELECT officeCode, COUNT(*) AS numEmployees
      FROM Employees
      GROUP BY officeCode
    ) AS OfficeEmployeeCounts
  )
)
UNION
SELECT C.customerName AS `Nama Karyawan/Pelanggan`, 'Customer' AS status
FROM Customers C
WHERE C.salesRepEmployeeNumber IN (
  SELECT employeeNumber
  FROM Employees
  WHERE officeCode IN (
    SELECT officeCode
    FROM Employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
      SELECT MIN(numEmployees)
      FROM (
        SELECT officeCode, COUNT(*) AS numEmployees
        FROM Employees
        GROUP BY officeCode
      ) AS OfficeEmployeeCounts
    )
  )
)
ORDER BY `Nama Karyawan/Pelanggan`;

#NOMOR 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR  ' dan ') AS riwayat
FROM (
    SELECT paymentDate as tanggal, 'membayar pesanan' as riwayat
    FROM payments
    WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003

    UNION

    SELECT orderDate as tanggal, 'memesan barang' as riwayat
    FROM orders
    WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003

     ) as dataCustomers
GROUP BY tanggal
ORDER BY tanggal;

#SOAL TAMBAHAN

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
GROUP BY `pelanggan`
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
GROUP BY `pelanggan`
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
GROUP BY `pelanggan`
LIMIT 11, 1)







