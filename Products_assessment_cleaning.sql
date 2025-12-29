-- Performing Data Quality Assessment on olist_products_dataset --

-- 1.Checking the number of rows in the table wheather it is matching the data rows to prevent missing data --

SELECT COUNT(*) AS count 
FROM olist_products_dataset

-- Output count 32951 as number of rows in the table matching with our csv file --

--2.Checking nulls in the coulmns like product_id to prvent pk,fk errors --

SELECT COUNT(*) AS cnt
FROM  olist_products_dataset
 WHERE product_id IS  NULL;

-- Output is 0 which refers there is no nulls in our product_id column --

--3.Checking  missing data columns which are important for analysis --

SELECT COUNT(*) AS total_cnt,
COUNT (product_category_name) AS prd_null_cnt,
COUNT (product_weight_g) AS weight_null,
COUNT (product_description_lenght) AS length_null
FROM olist_products_dataset;


--We encountered 2 rows are missing in  weight section and 10 rows are missing in the height section --

--4.Finding duplicates in the product_id so thart we can assign pk ad fk for the table --

SELECT  product_id ,COUNT(*) AS unique_id
FROM  olist_products_dataset
GROUP BY  product_id
HAVING   COUNT(*) > 1;

-- No rows returned in the Output which says "No duplicates values found in the product_id columns--

-- Distinct product name check --

SELECT DISTINCT product_category_name
FROM  olist_products_dataset;

-- no nulls in product category name section --

-- Over weight products check --

SELECT product_category_name,
product_weight_g
FROM olist_products_dataset
WHERE product_weight_g<0 OR product_weight_g>30000

--We got one product weighing over 40425 g --

-- Logical consistency check --

--product with dimensions but null weight --

SELECT product_category_name,
product_name_lenght,
product_length_cm,
product_height_cm,
product_weight_g AS null_weight
FROM olist_products_dataset
WHERE product_weight_g  IS NULL;

-- We have 2 rows with null weights in the weight section --


--   Check Product category_name products with different product_id --

SELECT 
product_category_name ,COUNT(*) AS category_cnt
FROM olist_products_dataset
GROUP BY product_category_name 
HAVING COUNT(*)>1;

-- We have encountered products with same category name but with different product_id --


-- Case insenstivity check --

SELECT product_category_name
FROM  olist_products_dataset
WHERE product_category_name<>LOWER (product_category_name);

-- No rows returned so all are in same cases --

             -- DATA CLEANING --
             
--Updated rows where its less than 0 --

UPDATE olist_products_dataset
SET product_weight_g = NULL 
WHERE  product_weight_g <=0;

-- Updated weight with more than 30000g to null to prevent future analysis --

UPDATE olist_products_dataset
SET product_weight_g = NULL 
WHERE  product_weight_g > 30000;

--Updating photos quantity with nulls where its less than 0 and more than 20 --

UPDATE olist_products_dataset
SET product_photos_qty = NULL
WHERE product_photos_qty <0
OR product_photos_qty>20;
 
--Updating meta data --

UPDATE olist_products_dataset
SET product_name_lenght = 0,
product_description_lenght = 0
WHERE  product_name_lenght IS NULL OR
product_description_lenght IS NULL ;

--    610 Rows affected --

--Updating weight column as null if all dimensions are null --

UPDATE olist_products_dataset
SET product_weight_g = NULL 
WHERE product_length_cm IS NULL AND 
product_height_cm IS NULL AND 
product_width_cm IS NULL ;

-- 2 Rows affected --

-- Final check --

SELECT COUNT (*) AS remaining_issues
FROM olist_products_dataset
WHERE  product_weight_g <= 0 OR 
product_length_cm <=0 OR
product_height_cm <=0 OR
product_width_cm <=0;

--Zero rows are with invalid data --

-- Assigning Primary key --

ALTER TABLE  olist_products_dataset
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);






