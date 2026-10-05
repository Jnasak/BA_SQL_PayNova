-- =====================================================
-- 04. Fraud Analysis
-- =====================================================

-- Fraud by Payment Method
SELECT 
    payment_method,
    COUNT(*)                                    AS total_txns,
    SUM(is_fraud)                               AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2)  AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_loss
FROM transactions
GROUP BY payment_method
ORDER BY fraud_rate_pct DESC;


-- Fraud by Amount Range
SELECT 
    CASE 
        WHEN amount < 5000 THEN '1. Low (< 5k)'
        WHEN amount < 20000 THEN '2. Medium (5k-20k)'
        WHEN amount < 100000 THEN '3. High (20k-100k)'
        ELSE '4. Very High (> 100k)'
    END AS amount_range,
    COUNT(*) AS total_txns,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_loss
FROM transactions
GROUP BY 
    CASE 
        WHEN amount < 5000 THEN '1. Low (< 5k)'
        WHEN amount < 20000 THEN '2. Medium (5k-20k)'
        WHEN amount < 100000 THEN '3. High (20k-100k)'
        ELSE '4. Very High (> 100k)'
    END
ORDER BY amount_range;


-- Top Merchants by Fraud Loss
SELECT 
    merchant_id,
    merchant_name,
    merchant_category,
    COUNT(*) AS total_txns,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END), 2) AS fraud_loss
FROM transactions
GROUP BY merchant_id, merchant_name, merchant_category
HAVING SUM(is_fraud) > 0
ORDER BY fraud_loss DESC
LIMIT 15;
