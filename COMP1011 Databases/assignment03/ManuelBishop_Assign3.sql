/*
	MANUEL BISHOP NORIEGA
    2023/03/21
    ASSIGNMENT 03
*/
USE sakila;
-- 1.	 Display the number of films (2)
SELECT COUNT(film_id) AS "Number of Films" FROM film;

-- 2.	Display the number of customers who are not active (3)
SELECT 	COUNT(active) AS "Number of non-active customers"
FROM 	customer
WHERE 	active=0;

-- 3.	Display the number of customers per store (4)
SELECT 	store_id, COUNT(customer_id) AS "Number of customers per Store"
FROM 	customer
GROUP BY store_id;

-- 4.	Using payment table, produce this output: (7)
SELECT 	COUNT(payment_id) AS "Number of Payments",
		MIN(amount) AS Lowest_Payment,
		MAX(amount) AS Highest_Payment,
		AVG(amount) AS Avg_Payment,
		SUM(amount) AS Total_of_all_payments
 FROM 	payment;

-- 5.	Display all film titles and descriptions only for descriptions that have both the words ‘dog’ and ‘squirrel’ in it. 
--      Sort alphabetically by title. 6 rows returned. (6)
SELECT title, description
FROM	film
WHERE	description LIKE "%dog%" AND description LIKE "%squirrel%"; 

-- 6.	 a) display the average film length (2)
SELECT 	AVG(length) as Avg_Film_Length
FROM	film;

        -- b)  Display films with a length longer than the average length. Sort by length, highest to lowest. (6)
SELECT 	film_id, title, length
FROM	film
WHERE	length > (SELECT AVG(length) from film)
ORDER BY length DESC;

-- 7.	Display the total rental amounts by customer for payment dates in July 2005 only. 
		-- Then display only results that total more than $50. Sort by customer ID. Use payment table - 179 rows returned (10), 240 rows
        -- I didn't understand what was the difference until I ran and compared both and realized how time impacts results leaving out rows from last day
		-- if I don't use DATE function.
SELECT 	*
FROM 	(	SELECT	customer_id,
					SUM(amount) AS Total_rental_amount_for_July
			FROM 	payment
            WHERE 	DATE(payment_date) BETWEEN "2005-07-01" AND "2005-07-31"
            GROUP BY customer_id
		) as derived_table
WHERE 	total_rental_amount_for_july > 50;

-- 8.	Display rental ID, last name, first name for customers that are not active.  Use rental and customer tables -not all rows are showing here. (6)
SELECT	rental_id,
		last_name,
		first_name
FROM	rental
JOIN	customer
USING	(customer_id)
WHERE	active=0;
-- 9.	Code an INSERT statement to add a category of ‘Zombie Programmers’ to category table. Use a column list using the name column only. (4)
INSERT INTO	category(name)
VALUES	("Zombie Programmers");

-- 10.	Code a DELETE statement to delete the row you added in question 10. (3) 
-- Disabling Workbench SQL Editor SAFE UPDATES feature is required to execute next query successfully
DELETE FROM category
WHERE name="Zombie Programmers";

-- 11.	Code an UPDATE statement to modify the customers table.  Change email address to the word ‘reset’ for non-active customers only. (4)
UPDATE	customer
SET		email="reset"
WHERE	active=0;

-- 12.	Write the statement to create an index for the email column in the customers table using a standard index name. (4)
CREATE INDEX customer_email_idx ON customer(email);
-- ALTER TABLE customer DROP INDEX customer_email_idx;

-- 13.	Display the indexes for the customers table. (2)
show index from customer; -- it's possible to use indexes instead of index too