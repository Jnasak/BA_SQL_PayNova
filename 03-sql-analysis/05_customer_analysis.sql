-- =====================================================
-- 05. Customer Analysis
-- =====================================================

-- Top 15 Customers by Successful Transaction Value
SELECT 
    customer_id,
    COUNT(*)                                    AS total_txns,
    ROUND(SUM(CASE WHEN status = 'Success' THEN amount ELSE 0 END), 2) AS successful_value,
    ROUND(SUM(fee), 2)                          AS total_fees_paid,
    SUM(is_fraud)                               AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct
FROM transactions
GROUP BY customer_id
ORDER BY successful_value DESC
LIMIT 15;


-- Customers with highest fraud involvement
SELECT 
    customer_id,
    COUNT(*) AS total_txns,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_amount
FROM transactions
GROUP BY customer_id
HAVING SUM(is_fraud) >= 2
ORDER BY fraud_count DESC, fraud_amount DESC
LIMIT 10;
