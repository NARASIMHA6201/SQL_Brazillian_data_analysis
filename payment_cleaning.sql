-- Performing Data Quality Assessment on olist__order_payments_dataset --

-- 1.Checking the number of rows in the table wheather it is matching the data rows to prevent missing data 


SELECT COUNT(*)
FROM  olist_order_payments_dataset;

-- All rows are inserted in the table matching with csv file --

--2.Checking nulls in the coulmns like order_id to prvent pk,fk errors --

SELECT COUNT(*) AS null_sellers
FROM   olist_order_payments_dataset 
WHERE order_id is null ;



--3.Finding duplicates in the order_id so thart we can assign pk ad fk for the table --

SELECT order_id , COUNT(*) AS id_count 
FROM olist_order_payments_dataset
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Duplicates returned so order_id cant be primary key --


                -- DATA CLEANING --

-- ASSIGNING SURGANT KEY AS PAYMENT_ID --

ALTER TABLE olist_order_payments_dataset
ADD  payment_id INT IDENTITY (1,1);

-- Added surgent key and assigning it as primary key--


-- ASSIGNING PRIMARY KEY --

ALTER TABLE  olist_order_payments_dataset
ADD CONSTRAINT pk_payment PRIMARY KEY (payment_id);

--Adding forigen key --

ALTER TABLE olist_order_payments_dataset
ADD CONSTRAINT fk_orders_payments 
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset (order_id);

