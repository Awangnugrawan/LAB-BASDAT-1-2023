-- H071221023
-- TRISMAN TEGAR WIRATAMA
-- KELAS A
-- PAKET 1

USE sakila

-- Nomor 1 (Soal Kevin)
SELECT title AS 'Judul Film', rating AS rate, release_year AS 'Tahun Rilis'
FROM film
WHERE rating > 4 AND release_year < 2010
ORDER BY title DESC 
LIMIT 10;

-- Nomor 2 (Soal Nata)
SELECT film_id as Id_Film, title as Judul_Film, category_id as Genre_film,
	 group_concat(first_name, ' ', last_name) as Nama_Customers, 
     count(customer_id) as Jumlah_Customers
FROM customer 
JOIN rental 
using (customer_id)
JOIN inventory  
using (inventory_id)
JOIN film 
using (film_id)
JOIN film_category 
using (film_id)
JOIN category 
using (category_id)
WHERE category.name IN ('Action','Documentary')
GROUP BY  title
HAVING COUNT(customer_id) > 10
ORDER BY Jumlah_Customers DESC;

-- Nomor 3 (Soal Farrel)
SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Aktor',
		 GROUP_CONCAT(f.title) AS 'Judul Film',
		 COUNT(f.title) AS 'Jumlah Film',
		 SUM(f.`length`) AS 'Total Durasi',
		 (SELECT c.`name`
        FROM film_category AS fc
        JOIN category AS c USING (category_id)
        WHERE fc.film_id IN (SELECT film_id 
		  							  FROM film_actor)
        GROUP BY c.`name`
        ORDER BY COUNT(*) DESC
        LIMIT 1) AS 'Genre Terbanyak',
		 case
		 when COUNT(f.title) > 40 then 'Senior'
		 when COUNT(f.title) >= 20 AND COUNT(f.title) <= 40 then 'Berpengalaman'
		 ELSE 'Pemula'
		 END AS 'Kategori'		 
FROM film AS f
JOIN film_actor USING (film_id)
JOIN actor AS a USING (actor_id)
WHERE a.actor_id = 35
UNION
SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Aktor',
		 GROUP_CONCAT(f.title) AS 'Judul Film',
		 COUNT(f.title) AS 'Jumlah Film',
		 SUM(f.`length`) AS 'Total Durasi',
		 (SELECT c.`name`
        FROM film_category AS fc
        JOIN category AS c USING (category_id)
        WHERE fc.film_id IN (SELECT film_id 
		  							  FROM film_actor)
        GROUP BY c.`name`
        ORDER BY COUNT(*) DESC
        LIMIT 1 ) AS 'Genre Terbanyak',
		 case
		 when COUNT(f.title) > 40 then 'Senior'
		 when COUNT(f.title) >= 20 AND COUNT(f.title) <= 40 then 'Berpengalaman'
		 ELSE 'Pemula'
		 END AS 'Kategori'		 
FROM film AS f
JOIN film_actor USING (film_id)
JOIN actor AS a USING (actor_id)
WHERE a.actor_id = 107
UNION
SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Aktor',
		 GROUP_CONCAT(f.title) AS 'Judul Film',
		 COUNT(f.title) AS 'Jumlah Film',
		 SUM(f.`length`) AS 'Total Durasi',
		 (SELECT c.`name`
        FROM film_category AS fc
        JOIN category AS c USING (category_id)
        WHERE fc.film_id IN (SELECT film_id 
		  							  FROM film_actor)
        GROUP BY c.`name`
        ORDER BY COUNT(*) DESC
        LIMIT 1 ) AS 'Genre Terbanyak',
		 case
		 when COUNT(f.title) > 40 then 'Senior'
		 when COUNT(f.title) >= 20 AND COUNT(f.title) <= 40 then 'Berpengalaman'
		 ELSE 'Pemula'
		 END AS 'Kategori'		 
FROM film AS f
JOIN film_actor USING (film_id)
JOIN actor AS a USING (actor_id)
WHERE a.actor_id = 56