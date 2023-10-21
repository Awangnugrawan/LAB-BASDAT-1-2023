USE classicmodels

-- No1
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', 
		 GROUP_CONCAT(orderNumber) AS 'Nomor Orderan', 
		 COUNT(orderNumber) AS 'Jumlah pesanan'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders USING (customerNumber)

GROUP BY e.employeeNumber

-- No2
SELECT p.productCode, 
		 p.productName, 
		 p.quantityInStock, 
		 o.orderDate
FROM products AS p
JOIN orderdetails USING (productCode)
JOIN orders AS o USING (orderNumber)

WHERE p.quantityInStock > 5000
GROUP BY p.productCode
ORDER BY o.orderDate

-- No3
SELECT offi.addressLine1 AS 'Alamat', 
		 concat(LEFT(offi.phone, 6), '* **') AS 'Nomor Telp', 
		 COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan', 
		 COUNT(DISTINCT c.customerNumber) AS 'Jumlah  Pelanggan', 
		 ROUND(AVG(py.amount), 2) AS 'Rata-Rata Penghasilan'
FROM offices AS offi
LEFT JOIN employees AS e USING (officeCode)
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS py USING (customerNumber)

GROUP BY offi.officeCode
ORDER BY offi.phone

-- No4
SELECT c.customerName AS 'customerName', 
		 YEAR(o.orderDate) AS 'tahun order', 
		 MONTHNAME(o.orderDate) AS 'bulan order', 
		 COUNT(od.quantityOrdered) AS 'jumlah pesanan', 
		 SUM(od.quantityOrdered * od.priceEach) AS 'uang total penjualan'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)

WHERE YEAR(o.orderDate) = '2003'
GROUP BY c.customerNumber, month(o.orderDate)
ORDER BY c.customerName

-- No5
# a.)
	SELECT c.customerName AS 'customername',
			 COUNT(od.quantityOrdered) AS 'jumlah_orderan',
			 SUM(od.quantityOrdered) AS 'total_orderan'
	FROM customers AS c
	JOIN orders USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	
	GROUP BY c.customerName
	HAVING c.customerName LIKE 'D%' AND sum(od.quantityOrdered) > 500
			 
# b.)
	SELECT p.productName AS 'nama produk',
			 YEAR(o.orderDate) AS 'tahun',
			 MONTH(o.orderDate) AS 'bulan',
			 DAY(o.orderDate) AS 'tanggal', 
			 sum(od.quantityOrdered) AS 'total pesanan'
	FROM products AS p
	JOIN orderdetails AS od USING (productCode)
	JOIN orders AS o USING (orderNumber)
	
	WHERE MONTH(o.orderDate) % 2 != 0  
	GROUP BY p.productName, YEAR(o.orderDate)
	HAVING p.productName LIKE '19%' AND sum(od.quantityOrdered) < 450
			 
			 
			 