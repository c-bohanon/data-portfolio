/*
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).

 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
*/

WITH first_orders AS (
    SELECT 
    customer_id,
        MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
),
joined_table AS (
    SELECT 
        f.customer_id,
        f.first_order_date,
        d.customer_pref_delivery_date
    FROM first_orders f
    LEFT JOIN Delivery d
        ON f.first_order_date = d.order_date
        AND f.customer_id = d.customer_id
)
SELECT
    ROUND(((CAST(COUNT(
        CASE
            WHEN first_order_date = customer_pref_delivery_date
            THEN 1
            ELSE NULL
            END
    ) AS NUMERIC) * 100) / CAST(COUNT(*) AS NUMERIC)), 2) AS immediate_percentage
FROM joined_table;
