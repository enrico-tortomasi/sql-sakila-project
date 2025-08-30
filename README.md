# SQL Portfolio Project - Sakila Database

Questo progetto raccoglie query SQL create sul database **Sakila** (database demo di un videonoleggio).  
L’obiettivo è mostrare capacità di **analisi dei dati con SQL**, applicando tecniche avanzate come:
- Aggregazioni e funzioni finestra (window functions)
- CTE (Common Table Expressions)
- Identificazione di sequenze temporali e pattern consecutivi
- KPI business-oriented (fatturato, retention, frequenza clienti)

---

## Dataset
- Database: **Sakila (PostgreSQL)**
- Tabelle principali: `rental`, `payment`, `customer`, `film`, `film_category`, `category`, `inventory`
- Dimensioni: ~16.000 noleggi, 599 clienti, 1.000 film
  
Questo progetto utilizza il database **Sakila**, un dataset open-source mantenuto da PostgreSQL/MySQL come esempio di videonoleggio.  
Non è incluso nel repository per motivi di spazio.  

 Download:
- [Sakila for PostgreSQL](https://github.com/jOOQ/sakila)  
- [Sakila for MySQL (ufficiale)](https://dev.mysql.com/doc/sakila/en/)  

Dopo l’installazione, le query di questo repo possono essere eseguite direttamente.
---
## ERM
<img width="1219" height="805" alt="1000054551" src="https://github.com/user-attachments/assets/92194625-5909-436f-ab1b-8502896417e8" />

---

## Struttura repo

```
sql-sakila-project/
│── queries/ # Tutte le query SQL utilizzate nel progetto
│ ├── 01_top_customers.sql
│ ├── 02_monthly_revenue.sql
│ ├── 03_customer_retention.sql
│ └── ...
│── outputs/ # CSV con i risultati principali delle query
│ ├── 01_top_customers.csv
│ ├── 02_monthly_revenue.csv
│ ├── 03_customer_retention.csv
│ └── ...
│── screenshots/ # Screenshot dei grafici ed output tabelle
│ ├── 01_top_customers_chart.png
│ ├── 01_top_customers_table.png
│ ├── 02_monthly_revenue_chart.png
│ └── ...
│── README.md # Documentazione del progetto
```
---

## Domande analitiche e risultati (sintesi):

### 1. Top Customers
**Obiettivo:** trovare i clienti con la spesa totale più alta.  
- Query: [`queries/01_top_customers.sql`](queries/01_top_customers.sql)  
- Output: [`outputs/01_top_customers.csv`](outputs/01_top_customers.csv)
     
| customer_id | first_name | last_name | total_spent |
| ------------|------------|-----------|-------------|
| 112         | SARAH      | SMITH     | 320.50      |
| 305         | JOHN       | DOE       | 298.75      |
| ...         | ...        | ...       | ...         |
---

### 2. Monthly Revenue
**Obiettivo:** calcolare il fatturato mensile totale.  
- Query: [`queries/02_monthly_revenue.sql`](queries/02_monthly_revenue.sql)
- Output: [`outputs/02_monthly_revenue.csv`](outputs/02_monthly_revenue.csv)

| month      | total_revenue |
|------------|---------------|
| 2005-01-01 | 1540.75       |
| 2005-02-01 | 1623.50       |
| ...        | ...           |
---

### 3. Customer Retention
**Obiettivo:** calcolare i giorni medi tra un noleggio e il successivo per ciascun cliente.  
- Query: [`queries/03_customer_retention.sql`](queries/03_customer_retention.sql)
- Output: [`outputs/03_customer_retention.csv`](outputs/03_customer_retention.csv)

| customer_id | first_name | last_name | days_between_rentals |
|-------------|------------|-----------|----------------------|
| 112         | SARAH      | SMITH     | 5                    |
| 305         | JOHN       | DOE       | 7                    |
| ...         | ...        | ...       | ...                  |
---

### 4. Consecutive Rentals
**Obiettivo:** identificare sequenze di noleggi consecutivi (giorno per giorno).  
- Query: [`queries/04_consecutive_rentals.sql`](queries/04_consecutive_rentals.sql)
- Output: [`outputs/04_consecutive_rentals.csv`](outputs/04_consecutive_rentals.csv)

| customer_id | first_name | last_name | num_consecutive_rentals | start_date | end_date   |
|-------------|------------|-----------|-------------------------|------------|------------|
| 112         | SARAH      | SMITH     | 4                       | 2005-01-10 | 2005-01-13 |
| 305         | JOHN       | DOE       | 3                       | 2005-02-01 | 2005-02-03 |
| ...         | ...        | ...       | ...                     | ...        | ...        |
---

### 5. Active 3+ Months
**Obiettivo:** trovare i clienti che hanno noleggiato per almeno 3 mesi consecutivi.  
- Query: [`queries/05_3_months_active.sql`](queries/05_3_months_active.sql)
- Output: [`outputs/05_3_months_active.csv`](outputs/05_3_months_active.csv)  

| customer_id | first_name | last_name | active_months | start_month | end_month  | total_paid |
|-------------|------------|-----------|---------------|-------------|------------|------------|
| 112         | SARAH      | SMITH     | 4             | 2024-01-01  | 2024-04-01 | 120.50     |
| 305         | JOHN       | DOE       | 3             | 2024-02-01  | 2024-04-01 | 98.75      |
| ...         | ...        | ...       | ...           | ...         | ...        | ...        |

---

## Tecnologie
- **SQL (PostgreSQL)**
- DBeaver / pgAdmin per l’esecuzione query

---

## Note
- Tutte le query sono commentate e spiegano la logica.  
- I file CSV mostrano risultati immediatamente consultabili.  
- Screenshot dei grafici eventuali sono inseriti in `screenshots/`

---

## Come riprodurre
1. Scaricare il database Sakila per PostgreSQL  
2. Importare le query dalla cartella `queries/`  
3. Eseguire con `psql` o un client grafico (DBeaver, pgAdmin)
