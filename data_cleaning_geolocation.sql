-- Performing Data Quality Assessment on  olist_geolocation_dataset --

-- 1.Checking the number of rows in the table wheather it is matching the data rows to prevent missing data --

SELECT COUNT(*) AS count 
FROM olist_geolocation_dataset

-- Output count 1000163 as number of rows in the table matching with our csv file --

--2.Checking nulls in the coulmns like geolocation_zip_code_prefix to prevent pk,fk errors --

SELECT COUNT (*) as null_geolocation_zip_code_prefix
FROM olist_geolocation_dataset
WHERE geolocation_zip_code_prefix IS NULL

-- Output is 0 which refers there is no nulls in our geolocation_zip_code_prefix --

--3.Checking  missing locations columns which are important for analysis --

SELECT COUNT(*) as total_rows,
COUNT(geolocation_zip_code_prefix) as zipcode_not_null ,
COUNT(geolocation_city) as city_not_null ,
COUNT(geolocation_state) as state_not_null
FROM olist_geolocation_dataset

-- Output have  same number of rows for all columns which means there is no missing data in the geolocation table --


--4.Finding duplicates in the geolocation_zip_code_prefix so thart we can assign pk ad fk for the table --

SELECT geolocation_zip_code_prefix ,COUNT(*) as zipcode_cnt
FROM olist_geolocation_dataset
GROUP BY  geolocation_zip_code_prefix 
HAVING COUNT(*) > 1

--5.Now we check any lower cases and upper cases in the text columns which refers same city --

SELECT geolocation_city,count(*) as city_cnt,
geolocation_state ,count (*) as state_cnt
FROM olist_geolocation_dataset
GROUP BY geolocation_city , geolocation_state
ORDER BY  city_cnt ,state_cnt DESC;

-- Verified that each city is consistently mapped to a single state with no duplicates city-state combinations found --

--6.Checking the length of text columns to avoid truncation errors --

SELECT 
MAX(LEN(geolocation_city))as max_city_len,
MAX(LEN(geolocation_state))as max_state_len
FROM olist_geolocation_dataset

-- We have provided enough size for text columns which avoids truncation errors --

--7. Checking invalid state code thath are presennt in the table --

SELECT DISTINCT geolocation_state
FROM olist_geolocation_dataset 
WHERE LEN( geolocation_state) <>2;


--Since 2 rows are appered  so there is  invalid state codes --

--since there are duplicates in the zipcode we ae adding surrgant key as geo_id into the location  table --

ALTER TABLE   olist_geolocation_dataset 
ADD geo_id INT IDENTITY(1,1);

-- Created surrgant key and making it as primary key --



