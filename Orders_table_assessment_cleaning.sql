-- Performing Data Quality Assessment on olist_customers_dataset --

-- 1.Checking the number of rows in the table wheather it is matching the data rows to prevent missing data --

SELECT COUNT(*) AS count 
FROM olist_orders_dataset

-- Output count 99441 as number of rows in the table matching with our csv file --

--2.Checking nulls in the coulmns like order_id ,customer_id  to prevent pk,fk errors --

SELECT COUNT (*) as null_order_id 
FROM olist_orders_dataset
WHERE order_id IS NULL;

SELECT COUNT (*) as null_customer_id 
FROM olist_orders_dataset
WHERE customer_id IS NULL;

-- Output is 0 which refers there is no nulls in our order_id , customer_id column --

-- Order status domain validation --

SELECT DISTINCT order_status
FROM  olist_orders_dataset;

-- Frequency check --

SELECT order_status ,COUNT(*) as freq_cnt
FROM  olist_orders_dataset
GROUP BY  order_status
ORDER BY  freq_cnt DESC;

-- We have performed frequency check so that we can find errors in the orders --

-- Case insenstivity check --

SELECT order_status 
FROM olist_orders_dataset
WHERE order_status<>LOWER (order_status );

--No rows returned which means all are in same cases --

--Null checks --

SELECT 
      SUM( CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS null_timestamps,
      SUM( CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS null_approved,
      SUM( CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) AS null_carrier_date,
      SUM( CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS null_customer_date,
      SUM( CASE WHEN order_estimated_delivery_date IS NULL THEN 1 ELSE 0 END) AS null_delivery_date
FROM olist_orders_dataset;


-- Noted nulls in some columns which are fine --

-- Logical consistency check --

SELECT *
FROM  olist_orders_dataset
WHERE order_approved_at <order_purchase_timestamp ;


SELECT *
FROM  olist_orders_dataset
WHERE order_delivered_customer_date  < order_purchase_timestamp ;

SELECT *
FROM  olist_orders_dataset
WHERE order_delivered_customer_date <  order_delivered_carrier_date  ;

-- “Identified minor timestamp inconsistencies where customer delivery date precedes carrier shipment date, likely due to system or timezone discrepancies.”--


-- Business Rule Validation  1.Delivered orders without delivery date  --

SELECT * 
FROM   olist_orders_dataset
WHERE order_status = 'delivered' and order_delivered_customer_date is null;

-- Found 8 orders delivered without entring the delivered customer date --

--2.Cancelled orders with delivered date --

SELECT * 
FROM   olist_orders_dataset
WHERE order_status = 'cancelled' and order_delivered_customer_date is not null;

-- No rows returned so no mis matches --

-- Volume distrubtion check 1.day orders --

SELECT 
      CAST(order_purchase_timestamp AS DATE) AS order_date,
      COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY  order_date ;


-- Month wise orders --


SELECT 
      FORMAT(order_purchase_timestamp ,'yyyy-MM') AS order_month,
      COUNT(*)AS total_orders
FROM  olist_orders_dataset
GROUP BY  FORMAT(order_purchase_timestamp ,'yyyy-MM')
ORDER BY order_month;


-- Data type verification for complete table --

EXEC sp_help 'olist_orders_dataset';

--“Validated the orders table structure using sp_help, confirming appropriate data types, lengths, and nullability for identifiers, status fields, and lifecycle timestamps to ensure compatibility for constraints and analytical queries.” --


                      -- DATA CLEANING --

--Updating purchase_time_stamp to not null--

SELECT COUNT (*) as null_purchase_time_stamps
FROM olist_orders_dataset
WHERE order_purchase_timestamp IS NULL;

ALTER TABLE olist_orders_dataset
ALTER COLUMN order_purchase_timestamp DATETIME NOT NULL;

-- ASSIGNING PRIMARY KEY --

ALTER TABLE olist_orders_dataset
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);


