-- =====================================================
-- 01. Overall Business KPIs
-- =====================================================

SELECT 
    COUNT(*)                                    AS total_transactions,
    COUNT(DISTINCT customer_id)                 AS total_customers,
    COUNT(DISTINCT merchant_id)                 AS total_merchants,
    ROUND(SUM(amount), 2)                       AS total_transaction_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN amount ELSE 0 END), 2) AS successful_value,
    ROUND(SUM(fee), 2)                          AS total_fee_revenue,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS total_fraud_loss,
    ROUND(AVG(amount), 2)                       AS avg_transaction_value
FROM transactions;
