-- =====================================================
-- 03. Channel Performance
-- =====================================================

SELECT 
    channel,
    COUNT(*)                                    AS total_txns,
    ROUND(SUM(amount), 2)                       AS total_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_loss,
    ROUND(AVG(amount), 2)                       AS avg_amount
FROM transactions
GROUP BY channel
ORDER BY total_txns DESC;


-- Channel + Payment Method combination
SELECT 
    channel,
    payment_method,
    COUNT(*) AS total_txns,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM transactions
GROUP BY channel, payment_method
ORDER BY channel, total_txns DESC;
