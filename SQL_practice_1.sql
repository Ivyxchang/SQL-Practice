

-- Get to know the sfo_listings table
SELECT *
FROM sfo_listings
LIMIT 100;

-- Which host has the most listings?
SELECT host_id, COUNT(*) AS listings
FROM sfo_listings
GROUP BY host_id, host_name
ORDER BY listings DESC;

-- Which host has the most listings in Haight Ashbury?
SELECT host_id, host_name, COUNT(*) AS listings
FROM sfo_listings
WHERE neighbourhood = 'Haight Ashbury'
GROUP BY host_id, host_name
ORDER BY listings DESC;

SELECT DISTINCT neighbourhood
FROM sfo_listings
ORDER BY neighbourhood;

-- What is the most common room type?
SELECT room_type, COUNT(*) AS listings
FROM sfo_listings
GROUP BY room_type
ORDER BY listings DESC;

-- What neighborhood is the most expensive on average?
SELECT neighbourhood, ROUND(AVG(price)::numeric, 2) AS avg_price
FROM sfo_listings
GROUP BY neighbourhood
ORDER BY avg_price DESC;

-- What 'popular' neighborhood is the most expensive on average?
-- 'popular' defined as having more than 400 listings in the table.
SELECT neighbourhood, ROUND(AVG(price)::numeric, 2) AS avg_price
FROM sfo_listings
GROUP BY neighbourhood
HAVING COUNT(*) > 400
ORDER BY avg_price DESC;

-- Which neighborhoods have above average number of reviews?
-- * To clarify, we're talking about if the listings within a neighborhood
-- have more reviews than an average listing across all neighborhoods.
SELECT ROUND(AVG(number_of_reviews))
FROM sfo_listings;
--42

SELECT neighbourhood, ROUND(SUM(number_of_reviews)) AS avg_reviews
FROM sfo_listings
GROUP BY neighbourhood
HAVING ROUND(AVG(number_of_reviews)) > 42
ORDER BY avg_reviews DESC
LIMIT 5;
