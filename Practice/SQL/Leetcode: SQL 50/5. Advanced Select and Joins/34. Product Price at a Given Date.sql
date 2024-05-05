/*
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.

 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
*/

-- Products with a defined price on 2019-08-16
WITH p1 AS (
    SELECT 
        product_id,
        MAX(change_date) AS change_date
    FROM Products
    WHERE change_date <= DATE('2019-08-16')
    GROUP BY 
        product_id
)
-- Table of latest prices as of 2019-08-16
SELECT 
    p0.product_id,
    new_price AS price
FROM Products p0
JOIN p1
    ON p0.product_id = p1.product_id
    AND p0.change_date = p1.change_date

UNION ALL 

-- Table of remaining rows in product_id
SELECT 
    DISTINCT (product_id),
    10 AS price
    FROM Products
    WHERE product_id NOT IN (
        SELECT product_id
        FROM p1
    );
