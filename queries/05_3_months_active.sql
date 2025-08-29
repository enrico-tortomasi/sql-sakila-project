-- ============================================================
-- File: 05_3_months_active.sql
-- Obiettivo: Clienti attivi per almeno 3 mesi consecutivi
-- 			 Calcolo anche il totale pagato in questi mesi
-- Database: Sakila (PostgreSQL)
-- Tabelle coinvolte: customer, rental, payment
-- ============================================================

-- Step 1: seleziono i mesi in cui ciascun cliente ha noleggiato almeno una volta
WITH Base AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC('month', rental_date)::date AS rental_month  -- tronco la data al mese
    FROM rental
),

-- Step 2: creo sequenze per identificare mesi consecutivi
Grp AS(
    SELECT 
        customer_id,
        rental_month,
        -- formula per generare un gruppo per mesi consecutivi
        ((EXTRACT(YEAR FROM rental_month) * 12) + (EXTRACT(MONTH FROM rental_month)))
        - ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_month) AS sequence_id
    FROM Base
),

-- Step 3: calcolo il totale pagato per cliente e mese
Payment_by_rental_month AS(
    SELECT
        customer_id,
        DATE_TRUNC('month', payment_date)::date AS payment_month,  -- tronco al mese
        SUM(amount) AS paid_month                                   -- somma dei pagamenti
    FROM payment
    GROUP BY 1,2
)

-- Step 4: aggrego i risultati finali
SELECT 
    g.customer_id,
    c.first_name,
    c.last_name,
    COUNT(*) AS active_months,            -- numero di mesi consecutivi
    MIN(g.rental_month) AS start_month,   -- primo mese della sequenza
    MAX(g.rental_month) AS end_month,     -- ultimo mese della sequenza
    COALESCE(SUM(pb.paid_month),0) AS total_paid  -- totale pagato in questi mesi
FROM Grp g
JOIN customer c ON g.customer_id = c.customer_id
LEFT JOIN Payment_by_rental_month pb
    ON g.customer_id = pb.customer_id
   AND g.rental_month = pb.payment_month  -- allineo il pagamento al mese del noleggio
GROUP BY 1,2,3,sequence_id
HAVING COUNT(*) >=3                       -- solo sequenze di almeno 3 mesi
ORDER BY active_months DESC;             -- ordino per numero di mesi attivi
