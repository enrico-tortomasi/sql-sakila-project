-- =============================================================================
-- File: 01_top_customers.sql
-- Obiettivo: Identificare i 10 clienti che hanno speso di più
-- Database: Sakila (PostgreSQL)
-- Tabelle coinvolte: customer, payment
-- =============================================================================

-- Selezioniamo l'ID, nome e cognome del cliente
-- Calcoliamo la spesa totale tramite SUM sulla colonna amount
-- Raggruppiamo per cliente (ID, first_name, last_name)
-- Ordiniamo in ordine decrescente per avere prima i clienti che hanno speso di più
-- Limitiamo il risultato ai primi 10 clienti

SELECT 
    c.customer_id,      -- ID cliente
    c.first_name,       -- Nome cliente
    c.last_name,        -- Cognome cliente
    SUM(p.amount) AS total_spent  -- Spesa totale
FROM 
    customer c
JOIN 
    payment p 
    ON c.customer_id = p.customer_id   -- Collegamento tra clienti e pagamenti
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC  -- Ordinamento decrescente per spesa totale
LIMIT 10;             -- Top 10 clienti
