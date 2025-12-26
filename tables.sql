
-- Creating  table olist_geolocation_dataset --

CREATE TABLE olist_geolocation_dataset(
geolocation_zip_code_prefix varchar (10)not null ,
geolocation_lat FLOAT not null ,
geolocation_lng FLOAT not null ,
geolocation_city VARCHAR (255) not null,
geolocation_state VARCHAR(50)   not null ,
);

-- Now adding the data from CSV file into geolocation table --

BULK INSERT olist_geolocation_dataset 
FROM 'D:\csv_file\GEOLOCATION\olist_geolocation_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- Creating table  olist_customers_dataset --


CREATE TABLE olist_customers_dataset (
customer_id   VARCHAR (50) not null,
customer_unique_id VARCHAR (50) not null,
customer_zip_code_prefix  varchar (10) not null ,
customer_city  VARCHAR (255) not null,
customer_state VARCHAR(50)   not null ,
);

--  Now adding the data from CSV file into customers  table --

BULK INSERT olist_customers_dataset
FROM 'D:\csv_file\GEOLOCATION\olist_customers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- Creating table  olist_products_dataset -- 


CREATE TABLE olist_products_dataset (
product_id VARCHAR (50) not null,
product_category_name VARCHAR (50) not null,
product_name_lenght int ,
product_description_lenght int ,
product_photos_qty int ,
product_weight_g int ,
product_length_cm int ,
product_height_cm int ,
product_width_cm int ,
);

--  Now adding the data from CSV file into products table --

BULK INSERT  olist_products_dataset
FROM "D:\csv_file\GEOLOCATION\olist_products_dataset.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- Creating table olist_sellers_dataset --

CREATE TABLE olist_sellers_dataset (
seller_id VARCHAR (50) not null,
seller_zip_code_prefix  VARCHAR (50) not null,
seller_city VARCHAR (255) not null,
seller_state VARCHAR(50)   not null 
);

--  Now adding the data from CSV file into olist_sellers_dataset--

BULK INSERT  olist_sellers_dataset
FROM "D:\csv_file\GEOLOCATION\olist_sellers_dataset.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- Creating table olist_orders_dataset --

CREATE TABLE olist_orders_dataset (
order_id VARCHAR (50) not null,
customer_id VARCHAR (50) not null,
order_status varchar (50) not null,
order_purchase_timestamp DATETIME2(0),
order_approved_at DATETIME2(0),
order_delivered_carrier_date DATETIME2(0),
order_delivered_customer_date DATETIME2(0),
order_estimated_delivery_date DATETIME2(0)
);


--  Now adding the data from CSV file into olist_orders_dataset --

BULK INSERT olist_orders_dataset
FROM "D:\csv_file\GEOLOCATION\olist_orders_dataset.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- Creating table olist_order_items_dataset --

CREATE TABLE olist_order_items_dataset (
order_id VARCHAR (50) not null ,
order_item_id  VARCHAR (50) not null ,
product_id  VARCHAR (50) not null ,
seller_id  VARCHAR (50) not null ,
shipping_limit_date DATETIME2(0),
price NUMERIC (10,2),
freight_value  NUMERIC (10,2)
);

--  Now adding the data from CSV file into olist_order_items_dataset --

BULK INSERT olist_order_items_dataset
FROM  "D:\csv_file\GEOLOCATION\olist_order_items_dataset.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);


-- Creating table olist_order_payments_dataset --

CREATE TABLE olist_order_payments_dataset (
order_id VARCHAR (50) not null,
payment_sequential  INT ,
payment_type VARCHAR (50) not null,
payment_installments INT ,
payment_valueNUMERIC(10,2)
);

--  Now adding the data from CSV file into  olist_order_payments_dataset --

BULK INSERT olist_order_payments_dataset
FROM "D:\csv_file\GEOLOCATION\olist_order_payments_dataset.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);


-- Created all the required tables and inserted DATA from CSV file --












