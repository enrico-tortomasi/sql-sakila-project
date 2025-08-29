-- =============================================================================
-- File: 02_monthly_revenue.sql
-- Obiettivo: Calcolare il fatturato mensile totale
-- Database: Sakila (PostgreSQL)
-- Tabelle coinvolte: payment
-- =============================================================================

-- Seleziona il mese e il totale dei pagamenti

SELECT
    DATE_TRUNC('month', p.payment_date)::date AS month, -- tronca la data al primo giorno del mese
    SUM(p.amount) AS total_revenue               		-- somma totale dei pagamenti per quel mese
FROM payment p
GROUP BY 1              -- raggruppa per mese
ORDER BY 1 ASC;  		-- ordina dal mese più vecchio al più recente