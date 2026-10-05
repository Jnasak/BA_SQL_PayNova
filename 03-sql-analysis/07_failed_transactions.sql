-- =====================================================
-- 07. Failed Transactions Analysis
-- =====================================================

-- Failure reasons breakdown
SELECT 
    failure_reason,
    COUNT(*) AS failure_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions WHERE status = 'Failed'), 2) AS pct_of_failures,
    ROUND(SUM(amount), 2) AS failed_value
FROM transactions
WHERE status = 'Failed'
GROUP BY failure_reason
ORDER BY failure_count DESC;


-- Failure rate by Payment Method
SELECT 
    payment_method,
    COUNT(*) AS total_txns,
    SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) AS failed_txns,
    ROUND(SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS failure_rate_pct
FROM transactions
GROUP BY payment_method
ORDER BY failure_rate_pct DESC;


-- Failure rate by Channel
SELECT 
    channel,
    COUNT(*) AS total_txns,
    SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) AS failed_txns,
    ROUND(SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS failure_rate_pct
FROM transactions
GROUP BY channel
ORDER BY failure_rate_pct DESC;
