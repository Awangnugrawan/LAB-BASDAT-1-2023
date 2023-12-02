#H071221021
#Dewa Ayu Eka Natalia Pratiwi
#Kelas C
#Paket 1

-- Soal 1 (Trisman)
select title as Judul,
	   rental_duration as Waktu_Sewa,
	   rental_rate as Biaya_Sewa
from film 
where rental_duration >= 7 and rental_rate < 4.50
order by rental_rate;

-- Soal 2 (Kelvin)
select concat(actor.first_name, ' ', actor.last_name) as Nama_Actor,
	   count(title) as Jumlah_Film
from actor
join film_actor using (actor_id)
join film using (film_id)
group by Nama_Actor
having Jumlah_Film > 15
order by Jumlah_Film desc
limit 5;

-- Soal 3 (Trisman)
select * from (
    (select title AS 'Nominasi', 
                case 
                    When`length` = (select max(`length`) from film) then 'film dengan durasi terlama'
                    when `length` = (select min(`length`) from film) then 'film dengan durasi tercepat'	
                end as 'Penghargaan'
        from film )
    union
    (select title, 'film action terbaik' 
        from film f
        join film_category fc using (film_id)
        join category c using (category_id)
        where c.`name` = 'Action' and rental_rate = (select max(rental_rate) from film) )
    union
    (select CONCAT(first_name, ' ', last_name), 'aktor dengan film terbanyak' 
        from actor a
        join film_actor fa USING (actor_id)
        group by fa.actor_id
        having COUNT(film_id) = (select MAX(film_count) FROM (SELECT actor_id, COUNT(film_id) AS film_count
                                                            FROM film_actor
                                                            GROUP BY actor_id) AS a ) )
    UNION
    (SELECT title, 
                CASE 
                    WHEN COUNT(actor_id) = (SELECT MAX(actor_count) FROM (SELECT film_id, COUNT(actor_id) AS actor_count
                                                                        FROM film_actor
                                                                        GROUP BY film_id) AS a) THEN 'film dengan aktor paling banyak'
                    WHEN COUNT(actor_id) = (SELECT MIN(actor_count) FROM (SELECT film_id, COUNT(actor_id) AS actor_count
                                                                        FROM film_actor
                                                                        GROUP BY film_id) AS a) THEN 'film dengan aktor paling sedikit'
                END AS 'penghargaan'
        FROM film AS f
        JOIN film_actor AS fa USING (film_id)
        GROUP BY fa.film_id )
) AS result
WHERE penghargaan IS NOT NULL
ORDER BY Penghargaan DESC;

