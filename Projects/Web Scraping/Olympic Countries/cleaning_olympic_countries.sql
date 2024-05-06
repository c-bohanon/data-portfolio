-- Changing country names to match the Power BI map
UPDATE country_table
SET country_name = CASE
        WHEN country_name = 'ROC' THEN 'Russia'
        WHEN country_name = 'Peoples Republic of China' THEN 'China'
        WHEN country_name = 'Congo' THEN 'Republic of the Congo'
        WHEN country_name = 'BOC' THEN 'Belarus'
        WHEN country_name = 'Great Britain' THEN 'United Kingdom'
        WHEN country_name = 'Chinese Taipei' THEN 'Taiwan'
        ELSE country_name
    END,
    recognition_year = CASE
        WHEN country_name = 'ROC' THEN '1993'
        ELSE recognition_year
    END;
-- Dropping index column
ALTER TABLE country_table DROP COLUMN "Unnamed: 0";
