

-- Show the database names in the current instance
SELECT datname 
FROM pg_database;


-- What tables are in the pg database abbreviated as pg?
SELECT table_name
FROM information_schema.tables;


-- Using information schema show the column names in customer_dim table 
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customer_dim';


-- Write a query to return 
-- the full name of the customer by concatenating first_name and last_name
-- the email of the customer
-- for customer who are 'y' in is_current COLUMN
SELECT first_name || ' ' || last_name AS full_name, 
       email 
FROM customer_dim 
WHERE is_current = 'y';




