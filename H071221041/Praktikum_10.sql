USE sakila;

#no1
SELECT
		f.title AS judul, 
		f.description AS 'deskripsi film', 
		f.rental_rate AS 'biaya sewa', 
		f.special_features AS 'spesial fitur'
FROM film f
WHERE f.special_features = 'trailers' AND f.rental_rate > 4;

#opsi lain
START TRANSACTION;

SELECT district FROM address WHERE address_id = 1;

UPDATE address
SET district = 'makassar'
WHERE address_id = 1;

ROLLBACK;

#no2
SELECT 
		CONCAT(c.first_name, ' ', c.last_name) 'nama lengkap', 
		f.title AS judul, 
		DATEDIFF(r.return_date, r.rental_date) 'lama sewa'
FROM customer c
JOIN rental r
USING(customer_id)
JOIN inventory i
USING(inventory_id)
JOIN film f
USING(film_id)
WHERE LEFT(c.first_name,1) IN ('a', 'i', 'u', 'e', 'o') AND DATEDIFF(r.return_date, r.rental_date) = 7 
GROUP BY c.customer_id
HAVING LENGTH(`nama lengkap`) > 15 ;

#nomor 3

(SELECT
    CONCAT(actor.first_name, ' ', actor.last_name) AS 'nama aktor',
    GROUP_CONCAT(film.title) AS 'judul film',
    special_features,
    CASE
        WHEN (SELECT COUNT(*) FROM film_actor WHERE actor.actor_id = film_actor.actor_id) < (SELECT AVG(banyakMain)
        																													FROM (SELECT COUNT(*) banyakMain
		  																													FROM film_actor fa
		  																													JOIN actor a USING(actor_id)
		  																													WHERE a.actor_id = fa.actor_id
																															GROUP BY a.actor_id ) banyakMain)  AND LENGTH(CONCAT(actor.first_name, ' ', actor.last_name)) > 10
		  THEN 'Aktor Cilik Junior'
        WHEN (SELECT COUNT(*) FROM film_actor WHERE actor.actor_id = film_actor.actor_id) > (SELECT AVG(banyakMain)
        																													FROM (SELECT COUNT(*) banyakMain
		  																													FROM film_actor fa
		  																													JOIN actor a USING(actor_id)
		  																													WHERE a.actor_id = fa.actor_id
																															GROUP BY a.actor_id ) banyakMain) AND LENGTH(CONCAT(actor.first_name, ' ', actor.last_name)) > 10
		  THEN 'Aktor Cilik Senior'
    END AS 'status aktor'
FROM
    actor
JOIN
    film_actor USING(actor_id)
JOIN
    film USING(film_id)
JOIN 
	 film_category USING(film_id)
JOIN
	 category USING(category_id)
WHERE category.name = 'Children' AND film.rating = 'G'
GROUP BY actor_id
HAVING `status aktor`IS NOT NULL)
UNION
(SELECT
    CONCAT(actor.first_name, ' ', actor.last_name) AS 'nama aktor',
    GROUP_CONCAT(film.title) AS 'judul film',
    special_features,
    CASE
        WHEN (SELECT COUNT(*) FROM film_actor WHERE actor.actor_id = film_actor.actor_id) < (SELECT AVG(banyakMain)
        																													FROM (SELECT COUNT(*) banyakMain
		  																													FROM film_actor fa
		  																													JOIN actor a USING(actor_id)
		  																													WHERE a.actor_id = fa.actor_id
																															GROUP BY a.actor_id ) banyakMain) AND LENGTH(CONCAT(actor.first_name, ' ', actor.last_name)) > 5
		  THEN 'Aktor Action Junior'
        WHEN (SELECT COUNT(*) FROM film_actor WHERE actor.actor_id = film_actor.actor_id) > (SELECT AVG(banyakMain)
        																													FROM (SELECT COUNT(*) banyakMain
		  																													FROM film_actor fa
		  																													JOIN actor a USING(actor_id)
		  																													WHERE a.actor_id = fa.actor_id
																															GROUP BY a.actor_id ) banyakMain) AND LENGTH(CONCAT(actor.first_name, ' ', actor.last_name)) > 5
		  THEN 'Aktor Action Senior'
    END AS 'status aktor'
FROM
    actor
JOIN
    film_actor USING(actor_id)
JOIN
    film USING(film_id)
JOIN 
	 film_category USING(film_id)
JOIN
	 category USING(category_id)
WHERE category.name = 'Action' AND film.rating = 'PG'
GROUP BY actor_id
HAVING `status aktor`IS NOT NULL)
ORDER BY `status aktor`;