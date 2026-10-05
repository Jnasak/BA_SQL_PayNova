-- =====================================================
-- 02. Payment Method Performance
-- =====================================================

SELECT 
    payment_method,
    COUNT(*)                                    AS total_txns,
    ROUND(SUM(amount), 2)                       AS total_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN amount ELSE 0 END), 2) AS successful_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_loss,
    ROUND(SUM(fee), 2)                          AS fee_revenue,
    ROUND(AVG(amount), 2)                       AS avg_amount
FROM transactions
GROUP BY payment_method
ORDER BY total_value DESC;
