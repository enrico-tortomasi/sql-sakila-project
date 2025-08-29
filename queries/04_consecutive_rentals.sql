-- ============================================================
-- File: 04_consecutive_rentals.sql
-- Obiettivo: Identificare sequenze di noleggi consecutivi (giorno per giorno) per ciascun cliente.
--			 Una sequenza è valida se il cliente ha noleggiato per almeno 3 giorni consecutivi.
-- Database: Sakila (PostgreSQL)
-- Tabelle coinvolte: customer, rental
-- ============================================================

-- 1. Estraggo solo la data (senza orario) e rimuovo eventuali duplicati:
--    se un cliente ha più noleggi nello stesso giorno, conta comunque come 1.
WITH Nol_Days_Customers AS (
    SELECT DISTINCT
        customer_id,
        rental_date::date AS rental_days
    FROM rental
),

-- 2. Assegno un "sequence_id" per identificare i gruppi consecutivi:
--    L’idea è confrontare la data con la posizione ordinata (ROW_NUMBER).
--    La differenza rimane costante all’interno di una sequenza di giorni consecutivi.
Grp AS (
    SELECT 
        customer_id,
        rental_days,
        ((rental_days) - DATE '2000-01-01') 
        - ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_days) AS sequence_id
    FROM Nol_Days_Customers
)

-- 3. Raggruppo per cliente e sequenza e calcolo:
--    - numero di giorni consecutivi
--    - data di inizio e fine della sequenza
SELECT
    g.customer_id,
    c.first_name,
    c.last_name,
    COUNT(*) AS num_consecutive_rentals,
    MIN(rental_days) AS start_date,
    MAX(rental_days) AS end_date
FROM Grp g
JOIN customer c ON c.customer_id = g.customer_id
GROUP BY 1,2,3,sequence_id
HAVING COUNT(*) > 2  -- considero solo sequenze di almeno 3 giorni consecutivi
ORDER BY 4 DESC;     -- ordino per lunghezza della sequenza (decrescente)
