/*
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.

 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.

 

Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 

 

Write a solution to:

    Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
    Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/

SELECT MIN(name) AS results
FROM (
    SELECT  
        m1.user_id,
        COUNT(m1.user_id) AS num_reviews,
        u.name
    FROM MovieRating m1
    JOIN Users u
        ON m1.user_id = u.user_id
    GROUP BY 
        m1.user_id,
        u.name
    HAVING COUNT(m1.user_id) = (
        SELECT MAX(num_reviews)
        FROM (
            SELECT COUNT(user_id) AS num_reviews
            FROM MovieRating
            GROUP BY user_id
        )
    )
)

UNION ALL

SELECT MIN(title) AS results
FROM (
    SELECT 
        m2.movie_id,
        AVG(m2.rating) AS avg_rating,
        mo.title 
    FROM MovieRating m2
    JOIN Movies mo
        ON m2.movie_id = mo.movie_id
    WHERE EXTRACT(YEAR FROM m2.created_at) = 2020
        AND EXTRACT(MONTH FROM m2.created_at) = 2
    GROUP BY 
        m2.movie_id,
        mo.title
    HAVING AVG(m2.rating) = (
        SELECT MAX(avg_rating)
        FROM (
            SELECT AVG(rating) AS avg_rating
            FROM MovieRating
            WHERE EXTRACT(YEAR FROM created_at) = 2020
                AND EXTRACT(MONTH FROM created_at) = 2
            GROUP BY movie_id
        )
    )
)
