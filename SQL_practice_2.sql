SELECT * 
FROM people;

SELECT * 
FROM books;

SELECT * 
FROM transactions;

-- Which books has Connie had to pay a fine for (if any)? When were they due?

SELECT name, title, return_date 
FROM people AS p 
    LEFT OUTER JOIN transactions AS t 
        ON p.person_id = t.person_id 
    LEFT OUTER JOIN books AS b 
        ON t.book_id = b.book_id 
WHERE name = 'Connie' 
    AND fine > '$0.00';


--3. Which people (if any) have never had a fine associated with them?

SELECT name, SUM(fine) AS total_fines 
FROM people AS p 
    LEFT OUTER JOIN transactions AS t 
        ON p.person_id = t.person_id 
GROUP BY name 
HAVING SUM(fine) = '$0.00';

--4. What are the names of the books which haven't been returned yet?

SELECT title
FROM books AS b 
    LEFT OUTER JOIN transactions AS t 
        ON b.book_id = t.book_id
WHERE return_date IS NULL
AND checkout_date IS NOT NULL;


--4.What are the names of the people who have never checked out a book (if any)?

SELECT name
FROM people AS p 
    LEFT OUTER JOIN transactions AS t 
        ON p.person_id = t.person_id
WHERE name IS NULL;


--5. What genres of books (if any) have never had a fine associated with them?

SELECT genre, SUM(fine::numeric) AS total_fines
FROM books AS b 
    LEFT OUTER JOIN transactions AS t 
        ON b.book_id = t.book_id
GROUP BY genre
HAVING SUM(fine::numeric) = 0;


--6. Which books has Pearl checked out?

SELECT name, title 
FROM people AS p 
    LEFT OUTER JOIN transactions AS t 
        ON p.person_id = t.person_id 
    LEFT OUTER JOIN books AS b 
        ON t.book_id = b.book_id 
WHERE name = 'Pearl';


--7. Which books has Garnet checked out? When are they due?

SELECT name, title, return_date
FROM people AS p 
    LEFT OUTER JOIN transactions AS t 
        ON p.person_id = t.person_id 
    LEFT OUTER JOIN books AS b 
        ON t.book_id = b.book_id
WHERE name = 'Garnet';


--9. Who are the people who have checked out The Hobbit?

SELECT name, title
FROM people AS p 
    LEFT OUTER JOIN transactions AS t
        ON p.person_id = t.person_id 
    LEFT OUTER JOIN books AS b 
        ON t.book_id = b.book_id
WHERE title = 'The Hobbit';

--10. What are the names of the people who had to pay a fine for Crazy Rich Asians?

SELECT name, SUM(fine) AS total_fines
FROM people AS p 
    LEFT OUTER JOIN transactions AS t 
        ON p.person_id = t.person_id 
    LEFT OUTER JOIN books AS b 
        ON t.book_id = b.book_id
WHERE title = 'Crazy Rich Asians'
GROUP BY name
HAVING SUM(fine) > '$0.00';