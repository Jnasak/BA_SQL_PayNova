# Data Schema – transactions table

| Column              | Data Type | Description                                      |
|---------------------|-----------|--------------------------------------------------|
| transaction_id      | TEXT      | Unique transaction identifier                    |
| transaction_date    | DATETIME  | Date and time of the transaction                 |
| customer_id         | TEXT      | Unique customer identifier                       |
| merchant_id         | TEXT      | Unique merchant identifier                       |
| merchant_name       | TEXT      | Merchant business name                           |
| merchant_category   | TEXT      | Merchant category (Retail, Food, Travel, etc.)   |
| payment_method      | TEXT      | UPI, Credit Card, Debit Card, Wallet, Bank Transfer |
| channel             | TEXT      | Mobile App, Web, POS, API                        |
| amount              | DECIMAL   | Transaction amount                               |
| fee                 | DECIMAL   | Fee charged by PayNova                           |
| status              | TEXT      | Success, Failed, Pending                         |
| failure_reason      | TEXT      | Reason if status = Failed (NULL otherwise)       |
| is_fraud            | INTEGER   | 1 = Fraudulent, 0 = Legitimate                   |
| country             | TEXT      | Country of the transaction                       |
| city                | TEXT      | City                                             |

**Notes:**
- One row = one payment transaction
- `is_fraud = 1` means the transaction was later confirmed as fraudulent
- Failed transactions can still be marked as fraud in some cases
