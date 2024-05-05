/*
Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.

 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.
*/

SELECT 
    visited_on,
    amount,
    ROUND(average_amount, 2) AS average_amount
FROM (
    SELECT
        CASE 
            WHEN visited_on - 6 IN (
                SELECT visited_on
                FROM Customer
            ) THEN visited_on
            ELSE NULL
            END AS visited_on,
        SUM(day_total) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ) AS amount,
        AVG(day_total) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ) AS average_amount
    FROM (
        SELECT 
            visited_on,
            SUM(amount) AS day_total
        FROM Customer
        GROUP BY visited_on
        ORDER BY visited_on
    )
)
WHERE visited_on IS NOT NULL
