-- Query does not include liquidations as transactions

WITH symbols AS (
    SELECT 
        DISTINCT(symbol) AS symbol,
        contract_address AS token_address
    FROM prices.usd
    WHERE blockchain = 'polygon'
    GROUP BY 
        symbol,
        contract_address
),
supply AS (
    SELECT 
        reserve AS token_address,
        DATE_TRUNC('day', evt_block_time) AS day,
        COUNT(evt_tx_hash) AS num_txns
    FROM aave_v3_polygon.Pool_evt_Supply 
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 
        1,
        2
),
borrow AS (
    SELECT 
        reserve AS token_address,
        DATE_TRUNC('day', evt_block_time) AS day,
        COUNT(evt_tx_hash) AS num_txns
    FROM aave_v3_polygon.Pool_evt_Borrow 
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 
        1,
        2
),
withdraw AS (
    SELECT 
        reserve AS token_address,
        DATE_TRUNC('day', evt_block_time) AS day,
        COUNT(evt_tx_hash) AS num_txns
    FROM aave_v3_polygon.Pool_evt_Withdraw
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 
        1,
        2
),
flash_loan AS (
    SELECT 
        asset AS token_address,
        DATE_TRUNC('day', evt_block_time) AS day,
        COUNT(evt_tx_hash) AS num_txns
    FROM aave_v3_polygon.Pool_evt_FlashLoan
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 
        1,
        2
),
repay AS (
    SELECT 
        reserve AS token_address,
        DATE_TRUNC('day', evt_block_time) AS day,
        COUNT(evt_tx_hash) AS num_txns
    FROM aave_v3_polygon.Pool_evt_Repay
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 
        1,
        2
),
all_actions AS (
    SELECT 
        s.token_address,
        s.day,
        SUM(s.num_txns) AS sum_txns
    FROM supply s
    FULL JOIN borrow b
        ON s.token_address = b.token_address
        AND s.day = b.day
    FULL JOIN withdraw w
        ON s.token_address = w.token_address
        AND s.day = w.day
    FULL JOIN flash_loan f
        ON s.token_address = f.token_address
        AND s.day = f.day
    FULL JOIN repay r
        ON s.token_address = r.token_address
        AND s.day = r.day
    GROUP BY 
        s.token_address,
        s.day
)
SELECT 
    a.token_address,
    DATE_FORMAT(a.day, '%Y-%m-%d') AS day,
    a.sum_txns,
    CASE
        WHEN sy.symbol IS NULL
            THEN 'jEUR'
        ELSE sy.symbol
        END AS symbol
FROM all_actions AS a
LEFT JOIN symbols AS sy
    ON a.token_address = sy.token_address
ORDER BY 
    symbol,
    2;
