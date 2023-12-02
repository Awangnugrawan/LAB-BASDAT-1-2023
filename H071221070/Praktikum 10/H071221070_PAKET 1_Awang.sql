# H071221070
# Zefanya Farrel Palinggi
# Kelas D
# Paket 1

USE sakila

-- No1 (Ardi)
SELECT f.title AS 'title', 
		 cat.name AS 'name', 
		 AVG(py.amount) AS 'avg_payment'
FROM payment AS py
JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film AS f USING (film_id)
JOIN film_category USING (film_id)
JOIN category AS cat USING (category_id)
GROUP BY f.title
HAVING AVG(py.amount) > 7
ORDER BY AVG(py.amount) DESC

-- No2 (Ardi)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'nama_pelanggan',
		 a.phone AS 'no_telp',
		 f.title AS 'judul_film',
		 r.rental_date AS 'tanggal_rental',
		 f.rental_duration AS 'lama_rental',
		 DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS 'tanggal_jatuh_tempo'
FROM address AS a
JOIN customer AS c USING (address_id)
JOIN rental AS r USING (customer_id)
JOIN inventory USING (inventory_id)
JOIN film AS f USING (film_id)
WHERE r.return_date IS NULL AND f.rental_duration > 5
ORDER BY f.title

-- No3 (Natalia)
SELECT f.film_id AS 'film_id',
		 f.title AS 'judul_film',
		 cat.`name` AS 'genre_film',
		 f.rating AS 'rating',
		 f.rental_rate AS 'rental_rate',
		 r.rental_date AS 'rental_date',
		 case
		 when f.rental_rate > (SELECT AVG(rental_rate) FROM film) then 'Harga Tinggi'
		 when f.rental_rate < (SELECT AVG(rental_rate) FROM film) then 'Harga Terjangkau'
		 ELSE 'rata-rata'
		 END AS 'Keterangan'
FROM rental AS r
JOIN inventory USING (inventory_id)
JOIN film AS f USING (film_id)
JOIN film_category USING (film_id)
JOIN category AS cat USING (category_id)
WHERE MONTH(r.rental_date) % 2 = 0 AND DAY(r.rental_date) % 2 <> 0 AND LEFT(f.title, 1) NOT IN ('A', 'I', 'U', 'E', 'O') AND LENGTH(f.title) > 20 	
GROUP BY f.title

UNION 

SELECT f.film_id AS 'film_id',
		 f.title AS 'judul_film',
		 cat.`name` AS 'genre_film',
		 f.rating AS 'rating',
		 f.rental_rate AS 'rental_rate',
		 r.rental_date AS 'rental_date',
		 case
		 when f.rental_rate > (SELECT AVG(rental_rate) FROM film) then 'Harga Tinggi'
		 when f.rental_rate < (SELECT AVG(rental_rate) FROM film) then 'Harga Terjangkau'
		 ELSE 'rata-rata'
		 END AS 'Keterangan'
FROM rental AS r
JOIN inventory USING (inventory_id)
JOIN film AS f USING (film_id)
JOIN film_category USING (film_id)
JOIN category AS cat USING (category_id)
WHERE MONTH(r.rental_date) % 2 <> 0 AND DAY(r.rental_date) % 2 = 0 AND LEFT(f.title, 1) NOT IN ('A', 'I', 'U', 'E', 'O') AND LENGTH(f.title) > 20 	
GROUP BY f.title	 