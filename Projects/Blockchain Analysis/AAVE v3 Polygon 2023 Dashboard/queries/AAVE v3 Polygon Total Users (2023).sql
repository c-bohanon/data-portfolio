-- Total number of users on AAVE v3 Polygon in 2023

WITH supply_users AS (
    SELECT onBehalfOf AS user_address
    FROM aave_v3_polygon.Pool_evt_Supply
    WHERE YEAR(evt_block_time) = 2023
),
liquidator_users AS (
    SELECT liquidator AS user_address
    FROM aave_v3_polygon.Pool_evt_LiquidationCall
    WHERE YEAR(evt_block_time) = 2023
),
borrow_users AS (
    SELECT onBehalfOf AS user_address
    FROM aave_v3_polygon.Pool_evt_Borrow
    WHERE YEAR(evt_block_time) = 2023
),
withdraw_users AS (
    SELECT to AS user_address
    FROM aave_v3_polygon.Pool_evt_Withdraw
    WHERE YEAR(evt_block_time) = 2023
),
flashloan_users AS (
    SELECT initiator AS user_address
    FROM aave_v3_polygon.Pool_evt_FlashLoan
    WHERE YEAR(evt_block_time) = 2023
),
repay_users AS (
    SELECT user AS user_address
    FROM aave_v3_polygon.Pool_evt_Repay
    WHERE YEAR(evt_block_time) = 2023
)
SELECT COUNT(DISTINCT(user_address))
    AS total_users_2023
FROM (
    SELECT user_address FROM supply_users
    UNION ALL
    SELECT user_address FROM liquidator_users
    UNION ALL
    SELECT user_address FROM borrow_users
    UNION ALL
    SELECT user_address FROM withdraw_users
    UNION ALL
    SELECT user_address FROM flashloan_users
    UNION ALL
    SELECT user_address FROM repay_users
) AS user_addresses_2023
