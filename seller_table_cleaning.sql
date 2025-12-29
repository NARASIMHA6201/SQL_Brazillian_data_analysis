-- Performing Data Quality Assessment on olist_sellers_dataset --

-- 1.Checking the number of rows in the table wheather it is matching the data rows to prevent missing data 


SELECT COUNT(*)
FROM olist_sellers_dataset;

-- All rows are inserted in the table matching with csv file --

--2.Checking nulls in the coulmns like seller_id to prvent pk,fk errors --

SELECT COUNT(*) AS null_sellers
FROM  olist_sellers_dataset 
WHERE seller_id is null ;

-- No nulls found in the seller id so that it can be primary key --

--3.Finding duplicates in the customer_id,customer_unique_id so thart we can assign pk ad fk for the table --

SELECT seller_id , COUNT(*) AS id_count 
FROM olist_sellers_dataset 
GROUP BY seller_id
HAVING COUNT(*) > 1;

--No rows returned so there are no duplicates in the data --


                -- DATA CLEANING --

-- ASSIGNING PRIMARY KEY --

ALTER TABLE olist_sellers_dataset 
ADD CONSTRAINT pk_seller PRIMARY KEY (seller_id);






