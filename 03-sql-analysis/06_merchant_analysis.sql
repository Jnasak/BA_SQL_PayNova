-- =====================================================
-- 06. Merchant Analysis
-- =====================================================

-- Top Merchants by Volume and Value
SELECT 
    merchant_id,
    merchant_name,
    merchant_category,
    COUNT(*)                                    AS total_txns,
    ROUND(SUM(amount), 2)                       AS total_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN amount ELSE 0 END), 2) AS successful_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct,
    ROUND(SUM(fee), 2)                          AS fee_revenue
FROM transactions
GROUP BY merchant_id, merchant_name, merchant_category
ORDER BY successful_value DESC
LIMIT 15;


-- Merchant Category Performance
SELECT 
    merchant_category,
    COUNT(*) AS total_txns,
    ROUND(SUM(amount), 2) AS total_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(SUM(fee), 2) AS fee_revenue
FROM transactions
GROUP BY merchant_category
ORDER BY total_value DESC;
