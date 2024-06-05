/*
Generate the following two result sets:

    Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

    Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

    There are a total of [occupation_count] [occupation]s.

    where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.
*/

WITH cte AS (
    SELECT
        Occupation,
        COUNT(*) AS num_professionals
    FROM OCCUPATIONS
    GROUP BY Occupation
)
(
    SELECT 
        CONCAT(SUBSTRING_INDEX(Name, ' ', 1),
               '(',
               SUBSTR(Occupation, 1, 1),
               ')') AS string_1
    FROM OCCUPATIONS
    ORDER BY 1
)
UNION ALL
(
    SELECT 
        CONCAT('There are a total of ',
              num_professionals,
              ' ',
              LOWER(Occupation),
              's.') AS string_2
    FROM cte
    ORDER BY 
        num_professionals,
        Occupation
)
ORDER BY 1
