WITH supply AS (
    SELECT
        COUNT(DISTINCT(onBehalfOf)) AS num_users,
        DATE_TRUNC('month', evt_block_time) AS date
    FROM aave_v3_polygon.Pool_evt_Supply
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 2
),
liquidation AS (
    SELECT
        COUNT(DISTINCT(liquidator)) AS num_users,
        DATE_TRUNC('month', evt_block_time) AS date
    FROM aave_v3_polygon.Pool_evt_LiquidationCall
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 2
),
borrow AS (
    SELECT
        COUNT(DISTINCT(onBehalfOf)) AS num_users,
        DATE_TRUNC('month', evt_block_time) AS date
    FROM aave_v3_polygon.Pool_evt_Borrow
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 2
),
withdraw AS (
    SELECT
        COUNT(DISTINCT(to)) AS num_users,
        DATE_TRUNC('month', evt_block_time) AS date
    FROM aave_v3_polygon.Pool_evt_Withdraw
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 2
),
flash_loan AS (
    SELECT
        COUNT(DISTINCT(initiator)) AS num_users,
        DATE_TRUNC('month', evt_block_time) AS date
    FROM aave_v3_polygon.Pool_evt_FlashLoan
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 2
),
repay AS (
    SELECT
        COUNT(DISTINCT(user)) AS num_users,
        DATE_TRUNC('month', evt_block_time) AS date
    FROM aave_v3_polygon.Pool_evt_Repay
    WHERE YEAR(evt_block_time) = 2023
    GROUP BY 2
)
SELECT
    s.date,
    SUM(s.num_users) AS total_monthly_users
FROM supply s
JOIN liquidation 
    ON MONTH(s.date) = MONTH(liquidation.date)
JOIN borrow
    ON MONTH(s.date) = MONTH(borrow.date)
JOIN withdraw
    ON MONTH(s.date) = MONTH(withdraw.date)
JOIN flash_loan
    ON MONTH(s.date) = MONTH(flash_loan.date)
JOIN repay
    ON MONTH(s.date) = MONTH(repay.date)
GROUP BY 1;
