#H071221068
#Muhammad Ardiansyah Asrifah
#Kelas C
#Paket 1

#Nomor 1 (Farel)

SELECT 
	CONCAT(first_name, ' ',last_name) AS 'nama aktor', 
	COUNT(film.film_id) AS 'jumlah film', 
	SUM(film.length) AS 'total tayang'
FROM actor
JOIN 
	film_actor ON film_actor.actor_id = actor.actor_id
JOIN 
	film ON film.film_id = film_actor.film_id
WHERE first_name LIKE '%ESO%' OR last_name LIKE '%ESO%'
GROUP BY CONCAT(first_name, ' ',last_name);

#Nomor 2 (Farrel)

SELECT f.title AS 'judul film', 
		 CONCAT(f.`length`, ' menit') AS 'durasi',
		 cat.`name` AS 'genre', 
		 GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name)) AS 'nama aktor', 
		 f.rating AS 'rating film'
FROM film AS f
JOIN 
	film_category USING (film_id)
JOIN 
	category AS cat USING (category_id)
JOIN 
	film_actor USING (film_id)
JOIN 
	actor AS a USING (actor_id)
WHERE f.`length` > 114
GROUP BY f.title
HAVING f.rating = 'G' AND cat.`name` = 'Comedy';

#Nomor 3 (alya)

(SELECT 
	customer.customer_id,
	CONCAT(customer.first_name,' ',customer.last_name)AS nama_lengkap,
	(DATEDIFF(rental.return_date,rental.rental_date)) AS 'dipinjam(hari)',
   SUM(payment.amount)AS total_pembayaran,
   	CASE 
			WHEN (DATEDIFF(rental.return_date,rental.rental_date)) >= 8 THEN 'dipinjam dalam waktu lebih dari seminggu'
    		WHEN (DATEDIFF(rental.return_date,rental.rental_date)) = 1 THEN 'dipinjam dan dikembalikan dihari yang sama'
    	ELSE 'dipinjam dalam waktu kurang dari seminggu'
    	END
    	AS status_pinjaman,
    	'diatas rata rata' ket_total_pembayaran
FROM customer
	JOIN 
		payment USING (customer_id)
	JOIN 
		rental USING (rental_id)
GROUP BY nama_lengkap
HAVING
	total_pembayaran > (SELECT 
								avg(total) 
									FROM 
										(SELECT 
											sum(amount) AS total 
											FROM 
												payment 
											GROUP BY customer_id) AS tabel)
LIMIT 6)

UNION

(SELECT 
	customer.customer_id,
	CONCAT(customer.first_name,' ',customer.last_name)AS nama_lengkap,
	(DATEDIFF(rental.return_date,rental.rental_date)) AS 'dipinjam(hari)',
   SUM(payment.amount)AS total_pembayaran,
    	CASE 
		 	WHEN (DATEDIFF(rental.return_date,rental.rental_date)) >= 8 THEN 'dipinjam dalam waktu lebih dari seminggu'
			WHEN (DATEDIFF(rental.return_date,rental.rental_date)) = 1 THEN 'dipinjam dan dikembalikan dihari yang sama'
    	ELSE 'dipinjam dalam waktu kurang dari seminggu'
    	END
    	AS status_pinjaman,
    	'dibawah rata rata' 
FROM 
	customer
JOIN 
	payment USING (customer_id)
JOIN 
	rental USING (rental_id)
GROUP BY nama_lengkap
HAVING total_pembayaran < (SELECT 
										AVG(total) 
									FROM 
										(SELECT 
											SUM(amount) AS total 
											FROM 
												payment 
											GROUP BY customer_id) AS tabel)
LIMIT 6);