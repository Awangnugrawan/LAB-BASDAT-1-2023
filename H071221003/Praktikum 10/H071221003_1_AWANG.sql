#H071221003
#Rabiatul Awalyah
#Kelompok 1
#Paket 1
#Kelas C

use sakila;


#nomor 1 (mutia)
select title as judul, description as deskripsi_film, rental_rate as biaya_sewa, special_features as spesial_fitur
from film
where rental_rate > 4 and special_features = 'trailers';


#nomor 2 (trisman)
select f.title as judul_film, concat(a.first_name,' ',a.last_name) as Nama_aktor
from film f join film_actor fa using (film_id)
join actor a using (actor_id)
join film_category fc using (film_id)
join category c using (category_id)
where concat(a.first_name,' ',a.last_name) in ('Susan Davis', 'Walter Torn', 'Nick Wahlberg', 'Grace Mostel')
and c.name = 'Action'
group by f.title, c.name, concat(a.first_name,' ',a.last_name)
having sum(concat(a.first_name,' ',a.last_name) = 'Susan Davis')
order by f. title;


#nomor 3 (ardi)
select c.name, count(f.film_id) as jumlah_film, sum(p.amount) as total_payment,
case
when count(f.film_id) > 1000 and sum(p.amount) > (select avg(total_payment)
from (select sum(p.amount) as total_payment
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.category_id) ab)
then 'Kategori A Baik'
when count(f.film_id) < 1000 and sum(p.amount) > (select avg(total_payment)
from (select sum(p.amount) as total_payment
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.category_id) ab)
then 'Kategori A Kurang'
end 'Keterangan'
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
where left(c.name,1)='A'
group by c.category_id
having `keterangan` is not null
union
select c.name, count(f.film_id) as jumlah_film, sum(p.amount) as total_payment,
case
when count(f.film_id) > 1000 and sum(p.amount) > (select avg(total_payment) * 0.5
from (select sum(p.amount) as total_payment
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.category_id) ab)
then 'Kategori C Baik'
when count(f.film_id) < 1000 and sum(p.amount) > (select avg(total_payment) * 0.5
from (select sum(p.amount) as total_payment
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.category_id) ab)
then 'Kategori C Kurang'
end 'Keterangan'
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
where left(c.name,1)='C'
group by c.category_id
having `keterangan` is not null
union
select c.name, count(f.film_id) jumlah_film, sum(p.amount) as total_payment,
case
when count(f.film_id) > 1000 and sum(p.amount) > (select min(total_payment)
from (select sum(p.amount) as total_payment
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.category_id) ab)
then 'Kategori D Baik'
when count(f.film_id) < 1000 and sum(p.amount) > (select min(total_payment)
from (select sum(p.amount) as total_payment
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.category_id) ab)
then 'Kategori D Kurang'
end 'Keterangan'
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
where left(c.name,1)='D'
group by c.category_id
having `keterangan` is not null;