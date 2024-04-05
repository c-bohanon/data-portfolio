/*
Token to USD price is taken as the recorded price in the same minute as the transaction
Table prices.usd does not have USD price data for jEUR
    This query replaces jEUR/USD price with EURS/USD price
Table prices.usd does not have USD price data for MATICX before 2023-1-27 10:55
    This query replaces MATICX/USD with stMATIC/USD price for transactions before 2023-1-27 10:55
These calculations do not include liquidations
*/

WITH prices AS (
    SELECT 
        minute,
        contract_address AS token_address,
        decimals,
        symbol,
        price
    FROM prices.usd
    WHERE blockchain = 'polygon'
),
supply AS (
    SELECT 
        'Supply' AS method,
        s.evt_tx_hash,
        s.evt_block_time,
        s.amount AS amount_in_wei,
        s.onBehalfOf AS user,
        s.reserve AS token_address,
        CASE
            WHEN p.decimals IS NULL
                AND s.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  --MATICX
                OR s.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 18
            ELSE p.decimals
            END AS decimals,
        CASE
            WHEN p.symbol IS NULL
                AND s.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN 'MATICX'
            WHEN p.symbol IS NULL
                AND s.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 'jEUR'
            ELSE p.symbol
            END AS symbol,
        CASE
            WHEN p.price IS NULL
                AND s.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', s.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4  -- stMATIC
                )
            WHEN p.price IS NULL
                AND s.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', s.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99  -- EURS
                )
            ELSE p.price
            END AS base_price
    FROM aave_v3_polygon.Pool_evt_Supply AS s
    LEFT JOIN prices AS p
        ON s.reserve = p.token_address
        AND DATE_TRUNC('minute', s.evt_block_time) = DATE_TRUNC('minute', p.minute)
    WHERE YEAR(evt_block_time) = 2023
),
borrow AS (
    SELECT 
        'Borrow' AS method,
        b.evt_tx_hash,
        b.evt_block_time,
        b.amount AS amount_in_wei,
        b.onBehalfOf AS user,
        b.reserve AS token_address,
        CASE
            WHEN p.decimals IS NULL
                AND b.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  --MATICX
                OR b.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 18
            ELSE p.decimals
            END AS decimals,
        CASE
            WHEN p.symbol IS NULL
                AND b.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN 'MATICX'
            WHEN p.symbol IS NULL
                AND b.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 'jEUR'
            ELSE p.symbol
            END AS symbol,
        CASE
            WHEN p.price IS NULL
                AND b.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', b.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4  -- stMATIC
                )
            WHEN p.price IS NULL
                AND b.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', b.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99  -- EURS
                )
            ELSE p.price
            END AS base_price
    FROM aave_v3_polygon.Pool_evt_Borrow AS b
    LEFT JOIN prices AS p
        ON b.reserve = p.token_address
        AND DATE_TRUNC('minute', b.evt_block_time) = DATE_TRUNC('minute', p.minute)
    WHERE YEAR(evt_block_time) = 2023
),
withdraw AS (
    SELECT 
        'Withdraw' AS method,
        w.evt_tx_hash,
        w.evt_block_time,
        w.amount AS amount_in_wei,
        w.to AS user,
        w.reserve AS token_address,
        CASE
            WHEN p.decimals IS NULL
                AND w.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  --MATICX
                OR w.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 18
            ELSE p.decimals
            END AS decimals,
        CASE
            WHEN p.symbol IS NULL
                AND w.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN 'MATICX'
            WHEN p.symbol IS NULL
                AND w.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 'jEUR'
            ELSE p.symbol
            END AS symbol,
        CASE
            WHEN p.price IS NULL
                AND w.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', w.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4  -- stMATIC
                )
            WHEN p.price IS NULL
                AND w.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', w.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99  -- EURS
                )
            ELSE p.price
            END AS base_price
    FROM aave_v3_polygon.Pool_evt_Withdraw AS w
    LEFT JOIN prices AS p
        ON w.reserve = p.token_address
        AND DATE_TRUNC('minute', w.evt_block_time) = DATE_TRUNC('minute', p.minute)
    WHERE YEAR(evt_block_time) = 2023
),
flash_loan AS (
    SELECT 
        'Flash Loan' AS method,
        f.evt_tx_hash,
        f.evt_block_time,
        f.amount AS amount_in_wei,
        f.initiator AS user,
        f.asset AS token_address,
        CASE
            WHEN p.decimals IS NULL
                AND f.asset = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  --MATICX
                OR f.asset = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 18
            ELSE p.decimals
            END AS decimals,
        CASE
            WHEN p.symbol IS NULL
                AND f.asset = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN 'MATICX'
            WHEN p.symbol IS NULL
                AND f.asset = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 'jEUR'
            ELSE p.symbol
            END AS symbol,
        CASE
            WHEN p.price IS NULL
                AND f.asset = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', f.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4  -- stMATIC
                )
            WHEN p.price IS NULL
                AND f.asset = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', f.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99  -- EURS
                )
            ELSE p.price
            END AS base_price
    FROM aave_v3_polygon.Pool_evt_FlashLoan AS f
    LEFT JOIN prices AS p
        ON f.asset = p.token_address
        AND DATE_TRUNC('minute', f.evt_block_time) = DATE_TRUNC('minute', p.minute)
    WHERE YEAR(evt_block_time) = 2023
),
repay AS (
    SELECT 
        'Repay' AS method,
        r.evt_tx_hash,
        r.evt_block_time,
        r.amount AS amount_in_wei,
        r.user AS user,
        r.reserve AS token_address,
        CASE
            WHEN p.decimals IS NULL
                AND r.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  --MATICX
                OR r.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 18
            ELSE p.decimals
            END AS decimals,
        CASE
            WHEN p.symbol IS NULL
                AND r.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN 'MATICX'
            WHEN p.symbol IS NULL
                AND r.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN 'jEUR'
            ELSE p.symbol
            END AS symbol,
        CASE
            WHEN p.price IS NULL
                AND r.reserve = 0xfa68fb4628dff1028cfec22b4162fccd0d45efb6  -- MATICX
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', r.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4  -- stMATIC
                )
            WHEN p.price IS NULL
                AND r.reserve = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c  -- jEUR
                THEN (
                    SELECT p2.price
                    FROM prices AS p2
                    WHERE DATE_TRUNC('minute', r.evt_block_time) = DATE_TRUNC('minute', p2.minute)
                        AND p2.token_address = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99  -- EURS
                )
            ELSE p.price
            END AS base_price
    FROM aave_v3_polygon.Pool_evt_Repay AS r
    LEFT JOIN prices AS p
        ON r.reserve = p.token_address
        AND DATE_TRUNC('minute', r.evt_block_time) = DATE_TRUNC('minute', p.minute)
    WHERE YEAR(evt_block_time) = 2023
),
all_tables AS (
    SELECT *
    FROM supply

    UNION ALL 

    SELECT *
    FROM borrow

    UNION ALL 

    SELECT *
    FROM withdraw

    UNION ALL 

    SELECT *
    FROM flash_loan

    UNION ALL

    SELECT *
    FROM repay
)
SELECT ROUND((SUM((amount_in_wei / POWER(10, decimals)) * base_price) / 1e9), 2) AS total_volume_in_usd
FROM all_tables
