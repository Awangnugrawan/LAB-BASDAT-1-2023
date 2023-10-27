
## Nomor 1
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS NamaKaryawan,
    GROUP_CONCAT(o.orderNumber) AS NomorOrderan,
    COUNT(o.orderNumber) AS JumlahOrderan
FROM
    employees e
JOIN
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN
    orders o ON c.customerNumber = o.customerNumber
GROUP BY
    e.employeeNumber
    
## Nomor 2
SELECT p.productCode, p.productName, p.quantityInStock, MIN(o.orderDate) AS tgl_pesanan
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
JOIN orders o
ON o.orderNumber = od.orderNumber
WHERE p.quantityInStock > 5000
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY tgl_pesanan ASC;

## Nomor 3
SELECT oc.addressLine1 AS 'Alamat',
		CONCAT(SUBSTRING(oc.phone,1,6),'* **') AS 'Nomor Telp', 
		COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
		COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
		AVG(py.amount) AS 'Rata-rata Penghasilan'
FROM offices oc
LEFT JOIN employees e USING(officeCode)
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py USING(customerNumber)
GROUP BY oc.addressLine1
ORDER BY oc.phone

## Nomor 4
SELECT c.customerName, YEAR(o.orderDate) AS 'tahun order', MONTH(o.orderDate) AS 'Bulan Order', COUNT(DISTINCT od.quantityOrdered) AS 'Jumlah Pesanan', SUM(od.quantityOrdered * od.priceEach)
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, YEAR(o.orderDate), MONTH(o.orderDate)
ORDER BY c.customerName ASC;

## SOAL TAMBAHAN
# Nomor 1
#Sebuah perusahaan distribusi suku cadang otomotif ingin mengevaluasi performa pelanggan mereka berdasarkan jumlah dan total pesanan yang mereka tempuh. Mereka mau melihat nama pelanggan, jumlah pesanan dan total pesanannya.  Perusahaan ini tertarik untuk mengidentifikasi pelanggan yang memiliki total pesanan lebih dari 500 unit dan nama pelanggan mereka diawali dengan huruf 'D'.kemudian akan diurutkan hasilnya berdasarkan total pesanan secara menurun. Dengan informasi ini, perusahaan dapat mengidentifikasi dan memberikan perhatian khusus kepada pelanggan-pelanggan yang memiliki kontribusi pesanan yang signifikan dan memenuhi kriteria yang ditetapkan. 
SELECT
    customerName,
    COUNT(orderNumber) AS jumlahPesanan,
    SUM(quantityOrdered) AS totalPesanan
FROM
    customers
JOIN
    orders USING (customerNumber)
JOIN
    orderdetails USING (orderNumber)
WHERE
    customerName LIKE 'D%'
GROUP BY
    customerNumber, customerName
HAVING
    totalPesanan > 500
ORDER BY
    totalPesanan DESC;
    
# Nomor 2
#Sebuah perusahaan suku cadang mobil memiliki data yang mencatat setiap pesanan produk mereka, termasuk nama produk, tanggal pesanan, dan jumlah yang dipesan. Perusahaan ini tertarik untuk mengevaluasi performa produk tertentu selama bulan-bulan dengan angka ganjil dan hanya melibatkan produk yang memiliki nama awalan 1900an pada setiap tahunnya .kemudian akan menyaring hanya produk-produk yang memiliki total pesanan kurang dari 450 unit. Dengan hasil ini, perusahaan dapat dengan cepat mengidentifikasi produk-produk yang mungkin memerlukan peninjauan lebih lanjut atau strategi pemasaran yang berbeda untuk meningkatkan kinerjanya
SELECT
    productName,
    YEAR(orderDate) AS orderYear,
    MONTH(orderDate) AS orderMonth,
    DATE(orderdate) AS tanggalorder,
    SUM(quantityOrdered) AS totalPesanan
FROM
    orders
JOIN
    orderdetails USING (orderNumber)
JOIN
    products USING (productCode)
WHERE
    MONTH(orderDate) % 2 <> 0
    AND productName LIKE '19%'
GROUP BY
	 productName, orderYear
HAVING
    totalPesanan < 450
ORDER BY
    orderYear, orderMonth, tanggalorder, totalPesanan;



