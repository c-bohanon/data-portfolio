SELECT * FROM artist;
SELECT * FROM canvas_size;
SELECT * FROM image_link;
SELECT * FROM museum_hours;
SELECT * FROM museum;
SELECT * FROM product_size;
SELECT * FROM subject;
SELECT * FROM work;

-- Which paintings are not displayed in any museums? 

SELECT * FROM work
WHERE museum_id IS NULL;

-- Are there museums without any paintings?
-- No.

SELECT * FROM museum AS m
LEFT JOIN work AS w ON m.museum_id = w.museum_id
WHERE w.museum_id IS NULL;

-- How many paintings have an asking price of more than their regular price?
-- None.

SELECT COUNT(*) FROM product_size
WHERE sale_price > regular_price;

-- Which paintings have a sale price less than 50% of the regular price?

SELECT * FROM product_size
WHERE sale_price < (regular_price * 0.5);

-- Which canvas size costs the most?
-- 48" x 96" (122 cm x 244 cm)

SELECT cs.label, ps.sale_price FROM canvas_size AS cs
JOIN product_size AS ps ON cs.size_id::text = ps.size_id
ORDER BY ps.sale_price DESC
LIMIT 1;

-- Which museums have invalid city information?

SELECT * FROM museum
WHERE city ~ '^[0-9]';

-- What are the top 10 most famous painting subjects?

SELECT subject, COUNT(*) AS no_of_paintings FROM subject
GROUP BY subject
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Which museums are open on both Sunday and Monday?
-- Return the museum name and city.

SELECT m.name, m.city
FROM museum AS m
JOIN museum_hours AS mh ON m.museum_id = mh.museum_id
WHERE mh.day IN ('Sunday', 'Monday')
GROUP BY m.name, m.city
HAVING COUNT(mh.day) = 2;

-- How many museums are open every single day?

SELECT COUNT(*) AS num_open_everyday
FROM (
    SELECT museum_id, COUNT(*) AS num_days
    FROM museum_hours
    GROUP BY museum_id
    HAVING COUNT(DISTINCT day) = 7
);

-- Which 5 museums have the most paintings?

SELECT m.name AS museum, m.city, m.country, x.no_of_paintings
FROM (
    SELECT m.museum_id, COUNT(*) AS no_of_paintings
    FROM work AS w
    JOIN museum AS m ON m.museum_id = w.museum_id
    GROUP BY m.museum_id
) AS x
JOIN museum AS m on m.museum_id = x.museum_id
ORDER BY no_of_paintings DESC 
LIMIT 5;

-- Which 5 artists have the most paintings in museums?

SELECT a.full_name AS artist, a.nationality, x.no_of_paintings
FROM (
    SELECT a.artist_id, COUNT(*) AS no_of_paintings
    FROM work AS w
    JOIN artist AS a ON a.artist_id = w.artist_id
    GROUP BY a.artist_id
) AS x
JOIN artist AS a ON a.artist_id = x.artist_id 
ORDER BY no_of_paintings DESC 
LIMIT 5;


-- Which museum is open for the longest during a day? 
-- Display museum name, state, hours open, and the day.

SELECT * FROM (
    SELECT m.name AS museum_name, m.state, mh.day, open, close, 
        to_timestamp(open, 'HH:MI AM') AS open_time, 
        to_timestamp(close, 'HH:MI PM') AS close_time, 
        to_timestamp(close, 'HH:MI AM') - to_timestamp(open, 'HH:MI PM') AS duration, 
        RANK() OVER(ORDER BY (to_timestamp(close, 'HH:MI AM') - to_timestamp(open, 'HH:MI PM')) DESC) AS rank
    FROM museum_hours mh 
    JOIN museum m on m.museum_id=mh.museum_id
) AS x
WHERE x.rank=1;

-- Which artist has the most portrait paintings outside the USA?
-- Display artist name, number of paintings, and nationality.

SELECT full_name AS artist_name, nationality, no_of_paintings
FROM (
    SELECT a.full_name, a.nationality, COUNT(*) AS no_of_paintings
    FROM work AS w
    JOIN artist AS a on a.artist_id = w.artist_id
    JOIN subject AS s ON s.work_id = w.work_id
    JOIN museum AS m ON m.museum_id = w.museum_id
    WHERE s.subject='Portraits'
    AND m.country != 'USA'
    GROUP BY a.full_name, a.nationality
) AS x
ORDER BY no_of_paintings DESC 
LIMIT 1;
