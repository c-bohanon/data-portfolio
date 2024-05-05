/*
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.

 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.
*/

SELECT *
FROM (
    SELECT 
        id,
        COUNT(id) AS num
    FROM (
        SELECT 
            id
        FROM (
            SELECT requester_id AS id
            FROM RequestAccepted
            UNION ALL
            SELECT accepter_id AS id
            FROM RequestAccepted
        )
    )
    GROUP BY id
)
WHERE num = (
    SELECT MAX(num)
    FROM (
        SELECT 
        id,
        COUNT(id) AS num
        FROM (
            SELECT 
                id
            FROM (
                SELECT requester_id AS id
                FROM RequestAccepted
                UNION ALL
                SELECT accepter_id AS id
                FROM RequestAccepted
            )
        )
        GROUP BY id
    )
)
