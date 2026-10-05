-- =====================================================
-- 08. Time Trends (Monthly)
-- =====================================================

-- Monthly Performance (SQLite syntax)
SELECT 
    strftime('%Y-%m', transaction_date)         AS year_month,
    COUNT(*)                                    AS total_txns,
    ROUND(SUM(amount), 2)                       AS total_value,
    ROUND(SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_pct,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_loss,
    ROUND(SUM(fee), 2)                          AS fee_revenue
FROM transactions
GROUP BY strftime('%Y-%m', transaction_date)
ORDER BY year_month;


-- Note for other databases:
-- PostgreSQL:  DATE_TRUNC('month', transaction_date)
-- MySQL:       DATE_FORMAT(transaction_date, '%Y-%m')
