USE classicmodels

-- Nomor 1
SELECT CONCAT(e.firstname,' ', e.lastname) AS "Nama Employee", 
		 GROUP_CONCAT(o.orderdate) AS "Nomor Orderan", 
		 COUNT(o.ordernumber) AS "Jumlah Pesanan"
FROM employees e JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o USING (customernumber)
GROUP BY e.employeenumber;


-- Nomor 2
SELECT p.productcode, p.productname, p.quantityinstock, o.orderdate
FROM products p JOIN orderdetails od USING (productcode)
JOIN orders o USING (ordernumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productcode
ORDER BY o.orderdate;

-- Nomor 3
SELECT oc.addressLine1 AS "Alamat Pertama", 
		CONCAT(LEFT(oc.phone,6), '* **') AS NoTelp, 
		COUNT(DISTINCT e.employeeNumber) AS JumlahKaryawan,
		COUNT(DISTINCT c.customerNumber) AS JumlahPelanggan, 
		ROUND(AVG(p.amount),2) AS RataRataPenghasilan
FROM offices oc LEFT JOIN employees e USING (officecode)
LEFT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p USING (customernumber)
GROUP BY oc.officeCode
ORDER BY oc.phone;

-- Nomor 4
SELECT c.customername, YEAR(o.orderdate) AS TahunOrder, 
		MONTH(o.orderdate) AS BulanOrder, COUNT(o.orderNumber) AS JumlahPesanan,
		SUM(od.priceEach * od.quantityOrdered) AS UangTotalPenjualan
FROM customers c JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
WHERE YEAR(o.orderdate) = 2003 
GROUP BY customername, BulanOrder;


-- Soal Tambahan

SELECT c.customername, COUNT(DISTINCT od.quantityordered) AS JumlahOrderan, SUM(od.quantityordered) AS TotalOrderan
FROM customers c JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
GROUP BY c.customernumber
HAVING SUM(od.quantityOrdered) > 500 AND customername LIKE "D%"


SELECT p.productname, YEAR(o.orderdate) AS TahunOrder, MONTH(o.orderdate) AS BulanOrder,DAY(o.orderDate) AS TanggalOrder, SUM(od.quantityOrdered) AS TotalPesanan
FROM products p JOIN orderdetails od USING (productcode)
JOIN orders o USING (ordernumber)
WHERE MONTH(o.orderdate) IN ('1','3','5','7','9','11') AND p.productname LIKE "19%" 
GROUP BY p.productname, YEAR(o.orderdate)
HAVING SUM(od.quantityOrdered) < 450
