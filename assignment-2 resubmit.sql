
use mavenmovies;

-- 1) Retrieve the total number of rentals made in the Sakila database. 

select count(rental_id) as total_no_of_rental from rental;

-- 2)Find the average rental duration (in days) of movies rented from the Sakila database.

  select avg(rental_duration) from film;

-- 3)  Display the first name and last name of customers in uppercase. 

    select upper(First_name) , upper(last_name) from customer;
    
    mene assignment submit kiya tha usme bta rhe hai ki ye code galat hai
    SELECT
    UPPER(first_name) AS first_name_uppercase,
    UPPER(last_name) AS last_name_uppercase
FROM
    customer;


-- 4 Extract the month from the rental date and display it alongside the rental ID. 

   select rental_id, extract(month from rental_date) as month from rental;

					-- OR
                      
   select rental_id , month(rental_date)  from rental;

-- 5) Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 

   SELECT cust.customer_id, COUNT(*) AS Total_Rentals
FROM rental AS r
INNER JOIN customer AS cust ON r.customer_id = cust.customer_id
GROUP BY cust.customer_id;

                        -- OR
                         
select customer_id, count(*) as total_rental from rental group by customer_id;


-- 6) Find the total revenue generated by each store. 

SELECT
    s.store_id,
   
    SUM(p.amount) AS total_revenue
FROM
    store s
JOIN
    staff st ON s.manager_staff_id = st.staff_id
JOIN
    payment p ON st.staff_id = p.staff_id
GROUP BY
    s.store_id
ORDER BY
    s.store_id;



-- 7) Display the title of the movie, customer s first name, and last name who rented it. 

     select f.title , c.first_name , c.last_name from film f 
   join inventory i on f.film_id = i.film_id 
 join rental r on r.inventory_id = i.inventory_id
 join customer c on r.customer_id = c.customer_id;


-- 8) Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 

select  a.first_name , a.last_name from actor a 
join film_actor fa on fa.actor_id = a.actor_id
join film f on fa.film_id = f.film_id
where title = "Gone with the Wind"; 


-- 9) Determine the total number of rentals for each category of movies. 

select * from film; -- film_id , rental_duration , rental_rate
select * from film_category; -- film_id , category_id
select * from rental; -- rental_id , customer_id, inventory_id;

SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    total_rentals;


-- 10) Find the average rental rate of movies in each language. 

select l.language_id, avg(rental_rate) from language l join film on l.language_id = film.language_id group by language_id;


-- 11) Retrieve the customer names along with the total amount they've spent on rentals.

SELECT c.first_name, c.last_name, SUM(amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;




-- 12) List the titles of movies rented by each customer in a particular city (e.g., 'London').  

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.address,
    ci.city,
    f.title AS rented_movie_title
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id

ORDER BY 
    c.customer_id, rented_movie_title;

-- 13) Display the top 5 rented movies along with the number of times they've been rented. 


SELECT 
    f.title AS movie_title,
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id
ORDER BY 
    rental_count asc
LIMIT 5;




-- 14) Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    store s ON i.store_id = s.store_id
WHERE 
    s.store_id IN (1, 2)
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT s.store_id) = 2;

