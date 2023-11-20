# H071221041
# ANDI MUTHIA MULIA PUTRI
# KELOMPOK 1
# PAKET 1
# KELAS A

#no1 (nata)
SELECT f.title 'judul_film', f.rating 'rating_film'
FROM film f
WHERE f.rating = 'g';

#no2 (alya)
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    MAX(DATEDIFF(r.return_date, r.rental_date)) AS 'terlama(hari)',
    MIN(DATEDIFF(r.return_date, r.rental_date)) AS 'tersingkat(hari)'
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE LEFT(c.last_name, 1) IN ('a', 'e', 'i', 'o', 'u')
GROUP BY customer_name;

#no3 (kevin)
(SELECT DISTINCT 
	f.title 'judul',
	f.release_year AS 'tahun rilis',
	CONCAT(a.first_name, ' ', a.last_name)'nama aktor',
	r.rental_date AS 'tanggal rental',
	case 
		when r.rental_date IS NOT NULL then 'rented'
		ELSE 'not rented'
	END AS status
FROM film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
JOIN inventory i USING(film_id)
LEFT JOIN rental r USING(inventory_id)
WHERE i.store_id IN (1,2) AND f.film_id IN (
															SELECT DISTINCT i.film_id
															FROM inventory i
															WHERE i.store_id IN(1,2))
ORDER BY `status`
LIMIT 5)

UNION 

(SELECT DISTINCT 
	f.title 'judul',
	f.release_year 'tahun rilis',
	CONCAT(a.first_name, ' ', a.last_name)'nama aktor',
	r.rental_date AS 'tanggal rental',
	case 
		when r.rental_date IS NOT NULL then 'rented'
		ELSE 'not rented'
	END AS status
FROM film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
JOIN inventory i USING(film_id)
LEFT JOIN rental r USING(inventory_id)
WHERE i.store_id IN (1,2) AND f.film_id IN (
															SELECT DISTINCT i.film_id
															FROM inventory i
															WHERE i.store_id IN(1,2))
ORDER BY `status` DESC
LIMIT 5);


 







































