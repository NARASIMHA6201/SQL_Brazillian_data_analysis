-- Performing Data Quality Assessment on olist_customers_dataset --

-- 1.Checking the number of rows in the table wheather it is matching the data rows to prevent missing data --

SELECT COUNT(*) AS count 
FROM olist_customers_dataset

-- Output count 99441 as number of rows in the table matching with our csv file --

--2.Checking nulls in the coulmns like customer_id ,customer_unique_id to prvent pk,fk errors --

SELECT COUNT (*) as null_customer_id 
FROM olist_customers_dataset
WHERE customer_id IS NULL

-- Output is 0 which refers there is no nulls in our customer_id column --

--3.Checking  missing locations columns which are important for analysis --

SELECT COUNT(*) as total_rows,
COUNT(customer_zip_code_prefix) as zipcode_not_null ,
COUNT(customer_city) as city_not_null ,
COUNT(customer_state) as state_not_null
FROM olist_customers_dataset 

-- Output we got is same number of rows for all columns which means there is no missing data in the customers table --

--4.Finding duplicates in the customer_id,customer_unique_id so thart we can assign pk ad fk for the table --

SELECT customer_id,COUNT(*) as id_cnt,
customer_unique_id,COUNT(*) as unique_id_cnt
FROM olist_customers_dataset 
GROUP BY customer_id,customer_unique_id
HAVING COUNT(*) > 1;

-- No rows returned in the Output which says "No duplicates values found in the customer_id,customer_unique_id columns--

--5.Checking the length of text columns to avoid truncation errors --

SELECT 
MAX(LEN(customer_city))as max_ity_len,
MAX(LEN(customer_state))as max_state_len
FROM olist_customers_dataset 

-- We provided enough size for text columns which avoids truncation errors --

--6.Now we check any lower cases and upper cases in the text columns which refers same city --

SELECT customer_city,count(*) as city_cnt,
customer_state ,count (*) as state_cnt
FROM olist_customers_dataset 
GROUP BY customer_city , customer_state
ORDER BY  city_cnt ,state_cnt DESC;

-- Verified that each customer is city is consistently mapped to a single state with no duplicates city-state combinations found --

--7. Checking invalid state code thath are presennt in the table --

SELECT DISTINCT customer_state
FROM olist_customers_dataset 
WHERE LEN(customer_state) <>2;

--Since no rows appered so there is no invalid state codes --

--8.Checking customers that are missing in orders so that we can sssign fk later --

SELECT COUNT(*) as cnt
FROM olist_orders_dataset AS o
LEFT JOIN olist_customers_dataset as c
ON o.customer_id = c.customer_id
WHERE  c.customer_id IS NULL;

-- Validated refrenntial integrity between orders and customers .no orphan records found in the data --

/* Confirmations that i have validated are 
           
           1.No Nulls in critical customer columns
           2.No duplicates in customer_id columns
           3.Wheather text columns have sufficient length or not
           4.City-state mappings are consistent 
           5.No orphan orders without customers   */



                                    -- DATA CLEANING --

--Standardizing text --

UPDATE  olist_customers_dataset
SET
     customer_city =LOWER(LTRIM(RTRIM( customer_city))),
     customer_state=UPPER(LTRIM(RTRIM( customer_state)));

-- Updated the text columns all in same cases to prevent future inconsistences --


-- ADDING PRIMARY KEY --

ALTER TABLE olist_customers_dataset
ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

-- ADDING FORIGEN KEY --

ALTER TABLE olist_orders_dataset
ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
REFERENCES olist_customers_dataset (customer_id);

/* “Performed comprehensive data quality validation including null checks, duplicate detection, text standardization  
and referential integrity verification prior to enforcing primary and foreign key constraints.”*/


