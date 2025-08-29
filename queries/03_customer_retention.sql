-- ============================================================
-- File: 03_customer_retention.sql
-- Obiettivo: calcolare il numero medio di giorni tra un noleggio 
--           e il successivo per ciascun cliente
-- Database: Sakila (PostgreSQL)
-- Tabelle coinvolte: customer, rental
-- ============================================================

-- Step 1: calcolare la differenza tra un noleggio e il precedente
-- LAG() permette di accedere alla riga precedente nel tempo, 
-- partizionando per cliente e ordinando per data noleggio
WITH rental_diff AS (
    SELECT
        customer_id,
        rental_date,
        rental_date - LAG(rental_date) OVER (
            PARTITION BY customer_id
            ORDER BY rental_date
        ) AS date_diff	-- differenza tra noleggi consecutivi
    FROM rental
)

-- Step 2: aggregare per cliente e calcolare la media dei giorni tra noleggi
-- EXTRACT(DAY FROM date_diff) trasforma l'intervallo in numero di giorni
-- AVG calcola la media dei giorni tra noleggi
-- ROUND arrotonda il risultato a numero intero
SELECT 
    rd.customer_id,         -- ID del cliente
    c.first_name,           -- Nome del cliente
    c.last_name,            -- Cognome del cliente
    ROUND(AVG(EXTRACT(DAY FROM date_diff))) AS days_between_rentals	
							-- Giorni medi tra noleggi consecutivi
FROM rental_diff rd
JOIN customer c 
    ON c.customer_id = rd.customer_id
GROUP BY 1,2,3				-- Raggruppa per cliente
ORDER BY 4 DESC;			-- Ordina per i giorni medi tra noleggi consecutivi partendo dai maggiori
