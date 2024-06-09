/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
*/

-- This solution is with MS SQL Server instead of MySQL

SELECT
    [Doctor],
    [Professor],
    [Singer],
    [Actor]
FROM
    (SELECT 
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) row_num,
         [Name],
         [Occupation] 
     FROM 
         Occupations
    ) AS source 
PIVOT
    ( MIN([Name]) FOR [occupation] IN ([Doctor],[Professor],[Singer],[Actor]) ) as pvt
ORDER BY row_num
