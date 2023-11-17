use classicmodels;
#no 1
SELECT YEAR(o.orderDate) tahun, COUNT(o.orderNumber) jumlahPesanan, 
case 
when COUNT(o.orderDate) > 150 then 'banyak'
when COUNT(o.orderDate) < 75 then 'sedikit'
ELSE 'sedang'
END AS kategoriPesanan
FROM orders o 
GROUP BY tahun
ORDER BY jumlahPesanan DESC;

#no2
SELECT CONCAT(e.firstName, ' ', e.lastName) namaKaryawan, SUM(p.amount) gaji,
case 
when SUM(p.amount) > (SELECT AVG(totalGaji)
								FROM
								(SELECT SUM(p.amount)totalGaji 
								FROM employees e
								JOIN customers c
								ON e.employeeNumber = c.salesRepEmployeeNumber
								JOIN payments p
								USING(customernumber)
								GROUP BY employeenumber)AS tg) then 'diatas rata-rata'
when SUM(p.amount) < (SELECT AVG(totalGaji)
								FROM
								(SELECT SUM(p.amount)totalGaji 
								FROM employees e
								JOIN customers c
								ON e.employeeNumber = c.salesRepEmployeeNumber
								JOIN payments p
								USING(customernumber)
								GROUP BY employeenumber)AS tg) then 'dibawah rata-rata'
END AS 'kategori gaji'					
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customernumber)
GROUP BY e.employeeNumber
ORDER BY `gaji` DESC;

#no3
(SELECT c.customerName, 
GROUP_CONCAT(LEFT(p.productName,4))tahunPembuatan, 
COUNT(p.productCode) jumlahProduk, 
SUM(DATEDIFF(o.shippedDate, o.orderDate))totalDurasiPengiriman, 
case
when SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(totalDurasi)
																	FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) totalDurasi
																	FROM orders o
																	GROUP BY o.customerNumber) AS td) AND MONTH(o.orderDate)%2 = 1 then 'target 1'
when SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(totalDurasi)
																	FROM (SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) totalDurasi
																	FROM orders o
																	GROUP BY o.customerNumber) AS td) AND MONTH(o.orderDate)%2 = 0 then 'target 2'
END AS 'kategori gaji'
FROM customers c
JOIN orders o
USING(customernumber)
JOIN orderdetails od 
USING(ordernumber)
JOIN products p
USING(productcode)
WHERE p.productName LIKE '18%'
GROUP BY c.customerNumber
HAVING `kategori gaji`IS NOT NULL)

UNION 

(SELECT c.customerName, 
GROUP_CONCAT(LEFT(p.productName,4))tahunPembuatan, 
COUNT(p.productCode) jumlahProduk, 
SUM(DATEDIFF(o.shippedDate, o.orderDate))totalDurasiPengiriman, 
case
when COUNT(p.productCode)*10 > (SELECT AVG(jumlahProduk)
																	FROM (SELECT COUNT(p.productCode)jumlahProduk
																	FROM products p
																	GROUP BY p.productCode) AS jp) AND MONTH(o.orderDate)%2 = 1 then 'target 3'
when COUNT(p.productCode)*10 > (SELECT AVG(jumlahProduk)
																	FROM (SELECT COUNT(p.productCode)jumlahProduk
																	FROM products p
																	GROUP BY p.productCode) AS jp) AND MONTH(o.orderDate)%2 = 0 then 'target 4'
END AS 'kategori gaji'
FROM customers c
JOIN orders o
USING(customernumber)
JOIN orderdetails od 
USING(ordernumber)
JOIN products p
USING(productcode)
WHERE p.productName LIKE '19%'
GROUP BY p.productCode)

UNION 

(SELECT c.customerName, 
GROUP_CONCAT(LEFT(p.productName,4))tahunPembuatan, 
COUNT(p.productCode) jumlahProduk, 
SUM(DATEDIFF(o.shippedDate, o.orderDate))totalDurasiPengiriman, 
case
when COUNT(p.productCode)*3 > (SELECT min(jumlahProduk)
																	FROM (SELECT COUNT(p.productCode)jumlahProduk
																	FROM products p
																	GROUP BY p.productCode) AS jp) AND MONTH(o.orderDate)%2 = 1 then 'target 5'
when COUNT(p.productCode)*3 > (SELECT min(jumlahProduk)
																	FROM (SELECT COUNT(p.productCode)jumlahProduk
																	FROM products p
																	GROUP BY p.productCode) AS jp) AND MONTH(o.orderDate)%2 = 0 then 'target 6'
END AS 'kategori gaji'
FROM customers c
JOIN orders o
USING(customernumber)
JOIN orderdetails od 
USING(ordernumber)
JOIN products p
USING(productcode)
WHERE p.productName LIKE '20%'
GROUP BY p.productCode)
ORDER BY `kategori gaji`;



