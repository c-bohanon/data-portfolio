SELECT
    'Supply' AS method,
    COUNT(onBehalfOf) AS num_actions,
    DATE_TRUNC('day', evt_block_time) AS date
FROM aave_v3_polygon.Pool_evt_Supply
WHERE YEAR(evt_block_time) = 2023
GROUP BY 3

UNION ALL 

SELECT
    'Liquidation' AS method,
    COUNT(liquidator) AS num_actions,
    DATE_TRUNC('day', evt_block_time) AS date
FROM aave_v3_polygon.Pool_evt_LiquidationCall
WHERE YEAR(evt_block_time) = 2023
GROUP BY 3

UNION ALL 

SELECT
    'Borrow' AS method,
    COUNT(onBehalfOf) AS num_actions,
    DATE_TRUNC('day', evt_block_time) AS date
FROM aave_v3_polygon.Pool_evt_Borrow
WHERE YEAR(evt_block_time) = 2023
GROUP BY 3

UNION ALL 

SELECT
    'Withdraw' AS method,
    COUNT(to) AS num_actions,
    DATE_TRUNC('day', evt_block_time) AS date
FROM aave_v3_polygon.Pool_evt_Withdraw
WHERE YEAR(evt_block_time) = 2023
GROUP BY 3

UNION ALL

SELECT
    'Flash Loan' AS method,
    COUNT(initiator) AS num_actions,
    DATE_TRUNC('day', evt_block_time) AS date
FROM aave_v3_polygon.Pool_evt_FlashLoan
WHERE YEAR(evt_block_time) = 2023
GROUP BY 3

UNION ALL 

SELECT
    'Repay' AS method,
    COUNT(user) AS num_actions,
    DATE_TRUNC('day', evt_block_time) AS date
FROM aave_v3_polygon.Pool_evt_Repay
WHERE YEAR(evt_block_time) = 2023
GROUP BY 3;
