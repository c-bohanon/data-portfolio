/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
*/

WITH tmp AS (
    SELECT DISTINCT ON (player_id)
    player_id, 
    event_date, 
    LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date ASC) AS next_event_date 
    FROM Activity
)
SELECT (COUNT(*)::REAL / (SELECT COUNT(*) FROM tmp))::NUMERIC(3,2) AS fraction 
FROM tmp
WHERE next_event_date - event_date = 1;
