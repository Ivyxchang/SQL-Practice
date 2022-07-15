

-- Take a look at the payment table.
SELECT *
FROM payment;

-- Take a look at the customer table.
SELECT *
FROM customer;


-- JOIN the payment and customer tables.
-- Only keep records found in both tables.
SELECT *
FROM payment AS p
INNER JOIN customer AS c
  ON p.customer_id = c.customer_id;

-- How many records result from this JOIN?
-- 16049
SELECT COUNT(*)
FROM payment AS p
INNER JOIN customer AS c
  ON p.customer_id = c.customer_id;

-- How many records were in each of the 2 input tables?
SELECT COUNT(*) FROM customer;  -- 599
SELECT COUNT(*) FROM payment;   -- 16049

-- We are sending out a promotion via snail mail.
-- We want to avoid saying "Current resident"; instead we
-- want the full name.  Please retrieve all the pieces of info
-- for addressing the envelopes.
SELECT *
FROM customer;

SELECT *
FROM address;

-- Row count: 599
SELECT INITCAP(first_name) AS first_name,
       INITCAP(last_name) AS last_name,
	   address
FROM customer AS c
INNER JOIN address AS a
   ON c.address_id = a.address_id;

-- Repeat the above query but this time ensure that you don't
-- lose any records from either table.
-- Row count: 603
SELECT first_name,
       last_name,
	   address
FROM customer AS c
FULL JOIN address AS a
   ON c.address_id = a.address_id;

-- In this case, did changing the JOIN type make a difference?
-- How can you tell?  Row count is different
-- If there is a difference, can you write a query to isolate
-- the different records?
SELECT first_name,
       last_name,
	   address
FROM customer AS c
FULL JOIN address AS a
   ON c.address_id = a.address_id
WHERE first_name IS NULL
   OR address IS NULL;

-- Use table IS NULL to find rows
SELECT first_name,
       last_name,
	   address
FROM customer AS c
FULL JOIN address AS a
   ON c.address_id = a.address_id
WHERE c IS NULL;


-- customer <-customer_id-> payment
SELECT first_name,
       last_name,
	   address,
       amount AS payment_amount
FROM address AS a
INNER JOIN customer AS c
  ON a.address_id = c.address_id
INNER JOIN payment AS p
  ON p.customer_id = c.customer_id;

-- Aggregate the data from the last query to show a payment total per customer
SELECT first_name,
       last_name,
	   address,
       SUM(amount) AS total_payment_amount
FROM address AS a
INNER JOIN customer AS c
  ON a.address_id = c.address_id
INNER JOIN payment AS p
  ON p.customer_id = c.customer_id
GROUP BY c.customer_id,
         first_name,
		 last_name,
		 address
ORDER BY total_payment_amount DESC;

-- We can also JOIN a table to itself

SELECT a.customer_id,
       CONCAT('A - ', a.first_name) AS cust_name_a,
       CONCAT('B - ', b.first_name) AS cust_name_b
FROM customer AS a
INNER JOIN customer AS b
  ON a.customer_id = b.customer_id;

