SELECT * FROM apple_store;
SELECT * FROM apple_store_description;

/* 
Which app categories are most popular?
Which app categories have lower ratings?
How can you maximize user ratings?
*/

-- Exploratory Data Analysis 

;

-- Check number of unique apps in both tables

SELECT COUNT(DISTINCT id) AS unique_ids
FROM apple_store;
-- 7197

SELECT COUNT(DISTINCT id) AS unique_ids
FROM apple_store_description;
-- 7197 

-- Check for missing values in key fields

SELECT COUNT(*) AS missing_values
FROM apple_store
WHERE track_name IS NULL
    OR user_rating IS NULL
    OR prime_genre IS NULL;
-- There are no missing values in these columns

SELECT COUNT(*) AS missing_values
FROM apple_store_description
WHERE app_desc IS NULL;
-- There are no missing values in this column

-- Find the number of apps per genre

SELECT prime_genre, COUNT(*) as num_apps
FROM apple_store
GROUP BY prime_genre
ORDER BY num_apps DESC;

-- Get an overview of the apps' ratings

SELECT min(user_rating) AS min_rating, 
    max(user_rating) AS max_rating, 
    avg(user_rating) AS avg_rating
FROM apple_store;
-- Minimum = 0, Maximum = 5, Average = 3.53

-- Data Analysis 

;

-- Determine whether paid apps have higher ratings than free apps

SELECT CASE 
    WHEN price > 0 THEN 'Paid'
    ELSE 'Free'
    END AS app_type, avg(user_rating) AS avg_rating
FROM apple_store
GROUP BY app_type;

-- Check if apps with more languages have higher ratings 

SELECT CASE 
    WHEN "lang.num" < 10 THEN '<10 languages'
    WHEN "lang.num" BETWEEN 10 AND 30 THEN '10-30 languages'
    ELSE '>30 languages'
    END AS lang_bin, avg(user_rating) AS avg_rating
FROM apple_store
GROUP BY lang_bin
ORDER BY avg_rating DESC;

-- Check genres with low ratings

SELECT prime_genre, avg(user_rating) AS avg_rating
FROM apple_store
GROUP BY prime_genre
ORDER BY avg_rating ASC
LIMIT 10;

-- Check for a correlation between description length and average rating

SELECT CASE 
    WHEN length(b.app_desc) < 500 THEN 'short'
    WHEN length(b.app_desc) BETWEEN 500 AND 1000 THEN 'medium'
    ELSE 'long'
    END AS desc_length_bin, avg(a.user_rating) AS avg_rating
FROM apple_store AS a
JOIN apple_store_description AS b ON a.id = b.id
GROUP BY desc_length_bin
ORDER BY avg_rating;

-- Find the top- and most-rated apps for each genre

SELECT prime_genre, track_name, user_rating
FROM (
    SELECT prime_genre, track_name, user_rating,
        RANK() OVER(PARTITION BY prime_genre
                    ORDER BY user_rating DESC, rating_count_tot DESC
                    ) AS rank
    FROM apple_store
) AS a
WHERE a.rank = 1;
-- An app developer may consider evaluating these top-rated apps

/* 
Findings
1. Paid apps have better ratings
2. Apps supporting 10 to 30 languages have better ratings
    Users may prefer to use apps in their native language
3. Catalogs, finance and book apps have low ratings,
    suggesting a potential opportunity due to unsatisfied users
4. Apps with longer descriptions have better ratings
    Users prefer having a better understanding of the app before downloading
5. A new app should aim for an average rating higher than 3.5
6. Games and entertainment have a large number of apps
    These categories may be subject to high competition
    but also high user demand.
*/
