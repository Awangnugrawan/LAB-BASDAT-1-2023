-- Nomor 1
SELECT CONCAT(firstname, ' ', lastname) AS 'Nama Employee',
		 GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan',
		 COUNT(o.ordernumber) AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
USING (customerNumber)
GROUP BY e.employeeNumber;

-- Nomor 2
SELECT p.productCode, p.productName, p.quantityInStock, MIN(o.orderDate) AS 'OrderDate'
FROM orders o
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productcode)
WHERE quantityinstock > 5000
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY MIN(o.orderDate);

-- Nomor 3
SELECT o.addressline1 AS 'Alamat',
		 CONCAT(LEFT(o.phone,6),'* ***') AS 'Nomor Telp',
		 COUNT(DISTINCT(e.employeeNumber)) AS 'Jumlah Karyawan',
		 COUNT(DISTINCT(c.customerNumber)) AS 'Jumlah Pelanggan',
		 FORMAT((AVG(p.amount)),2) AS 'Rata-rata Penghasilan'
FROM offices o
LEFT JOIN employees e
USING (officeCode)
LEFT JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p
USING (customerNumber)
GROUP BY o.officeCode
ORDER BY CONCAT(LEFT(o.phone,6),'* ***');

-- Nomor 4
SELECT c.customername,
		 YEAR(orderdate) AS 'Tahun Order',
		 MONTH(orderdate) AS 'Bulan Order',
		 COUNT(orderNumber) AS 'Jumlah Pesanan',
		 SUM(od.priceEach * od.quantityOrdered) AS 'Uang total Penjualan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE YEAR (orderdate) = 2003
GROUP BY c.customerName, MONTH(orderDate);

-- Soal Tambahan
SELECT c.customerName,
		 COUNT(od.quantityordered) AS 'Jumlah_orderan',
		 SUM(od.quantityOrdered) AS 'Total_orderan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE c.customerName LIKE 'd%'
GROUP BY c.customerName
HAVING SUM(od.quantityOrdered) > 500
ORDER BY od.quantityOrdered;

SELECT p.productname AS 'Nama Produk',
		 YEAR(orderdate) AS 'Tahun Order',
		 MONTH(orderdate) AS 'Bulan Order',
		 DAY(orderdate) AS 'Tanggal Order',
		 COUNT(od.quantityordered) AS 'total_Pesanan'
FROM orders o
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTHNAME(orderdate) IN ('January', 'March', 'May', 'July', 'September','November') AND p.productname LIKE '19%'
GROUP BY p.productName, YEAR(orderdate)
HAVING COUNT(od.quantityordered) < 450;