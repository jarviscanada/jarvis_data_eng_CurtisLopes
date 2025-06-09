-- Show table schema 
\d+ retail;

-- Show first 10 rows
SELECT * FROM retail limit 10;

-- Check # of records
SELECT COUNT (*) FROM retail;

-- number of clients (e.g. unique client ID)
SELECT COUNT(DISTINCT customer_id) FROM retail;

-- invoice date range (e.g. max/min dates)
SELECT
    MAX(invoice_date) AS max,
    MIN(invoice_date) AS min
FROM retail;

-- number of SKU/merchants (e.g. unique stock code)
SELECT COUNT(DISTINCT stock_code) FROM retail;

-- Calculate average invoice amount excluding invoices with a negative amount (e.g. canceled orders have negative amount)
SELECT AVG(invoice_total) AS avg
FROM (
    SELECT invoice_no, SUM(quantity * unit_price) AS invoice_total
    FROM retail
    GROUP BY invoice_no
    HAVING SUM(quantity * unit_price) > 0
) subquery;

-- Calculate total revenue (e.g. sum of unit_price * quantity)
QUERY HERE
SELECT SUM(unit_price * quantity) AS sum
FROM retail;

-- Calculate total revenue by YYYYMM
SELECT
    (CAST(EXTRACT(YEAR FROM invoice_date) AS INTEGER) * 100 +
     CAST(EXTRACT(MONTH FROM invoice_date) AS INTEGER)) AS yyyymm,
    SUM(unit_price * quantity) AS sum
FROM retail
GROUP BY yyyymm
ORDER BY yyyymm;
