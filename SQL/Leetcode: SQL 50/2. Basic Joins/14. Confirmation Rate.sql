/*
Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.

 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').

 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.
*/

WITH 
    total_confirmations AS (
    SELECT 
        ids.user_id,
        COUNT(conf.action) AS confirmation_count
    FROM 
        (SELECT DISTINCT(user_id) 
         FROM Signups) AS ids
    LEFT JOIN Confirmations AS conf
        ON ids.user_id = conf.user_id
        AND conf.action = 'confirmed'
    GROUP BY ids.user_id
    ),
    /*
    | user_id | confirmation_count |
    | ------- | ------------------ |
    | 3       | 0                  |
    | 6       | 0                  |
    | 2       | 1                  |
    | 7       | 3                  |
    */
    total_actions AS (
    SELECT 
        ids.user_id,
        COUNT(conf.action) AS action_count
    FROM 
        (SELECT DISTINCT(user_id)
         FROM Signups) AS ids
    LEFT JOIN Confirmations AS conf
        ON ids.user_id = conf.user_id
    GROUP BY ids.user_id
    )
    /*
    | user_id | action_count |
    | ------- | ------------ |
    | 3       | 2            |
    | 6       | 0            |
    | 2       | 2            |
    | 7       | 3            |
    */
SELECT 
    a.user_id,
    CASE
        WHEN b.action_count = 0 THEN 0
        ELSE ROUND(CAST(a.confirmation_count AS NUMERIC) / 
            CAST(b.action_count AS NUMERIC), 2)
    END AS confirmation_rate
FROM total_confirmations a
JOIN total_actions b
    ON a.user_id = b.user_id;
