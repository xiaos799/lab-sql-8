use sakila;

select * from film;
#1 Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over (order by length) as ranking
from film
where length != 0 and length IS NOT NULL;

#2 Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the 
#columns title, length, rating and rank.
select title, length, rating, rank() over (partition by rating order by length) as ranking
from film
where length != 0 and length IS NOT NULL;

#3 How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" 
# and "film_category".
select * from category;
select * from film_category;

select count(film_id) as num_film, name from category c
join film_category f
using (category_id)
group by name;

#4 Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number 
# of times an actor appears.
select * from actor;
select * from film_actor;

select first_name, last_name, count(film_id) from actor
join film_actor
using (actor_id)
group by first_name, last_name
order by count(film_id) desc limit 1;

#5 Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" 
# and "rental" and count the rental_id for each customer.
select * from rental;
select * from customer;

select first_name, last_name, count(rental_id)
from rental
join customer
using (customer_id)
group by first_name, last_name
order by count(rental_id) desc limit 1;

# Bonus: Which is the most rented film?
select * from inventory;
select title, count(rental_id)
from inventory 
join rental using (inventory_id)
join film using (film_id)
group by title
order by count(rental_id) desc limit 1;
