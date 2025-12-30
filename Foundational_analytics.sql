/* 1.What is the total number of orders, customers, and products in the dataset?*/

SELECT 
(SELECT COUNT(DISTINCT order_id)
FROM olist_orders_dataset ) AS total_orders,

(SELECT COUNT(DISTINCT customer_id)
FROM olist_customers_dataset ) AS total_customers,

(SELECT COUNT(DISTINCT product_id)
FROM olist_products_dataset) AS total_products;

/* Total orders = 99441 
Total customers = 99441
Total products ordered = 32951 */



/* 2.How are orders distributed by order status (delivered, canceled, shipped, etc.)? */

SELECT  DISTINCT order_status
FROM olist_orders_dataset;

--We have 8 type of order status avaliable in the store --

/* 3.What is the monthly trend of orders over time? */


SELECT 
      FORMAT(order_purchase_timestamp ,'yyyy-MM') AS order_month,
      COUNT(*)AS total_orders
FROM  olist_orders_dataset
GROUP BY  FORMAT(order_purchase_timestamp ,'yyyy-MM')
ORDER BY order_month ;

--Sales are low in the first quarter of the year and high on 2nd,3rd quater of the year --


/* 4.What is the average order value (AOV)?*/

SELECT ROUND(AVG(price) ,2)AS average_order_value
FROM olist_order_items_dataset;

--Average_order_value is 120.65 BRAZILLIAN REAL (BRLL) --

/* 5.Which product categories generate the highest revenue?*/

SELECT 
 SUM(o.price)AS revenue,
 p.product_category_name
 FROM olist_order_items_dataset AS o
 LEFT JOIN olist_products_dataset AS p
 ON o.product_id = p.product_id
 GROUP BY product_category_name
 ORDER BY SUM(o.price) DESC;

 --The most selling product category is beleza_saudein the stores --

 /* 6.What are the top 10 best-selling products by quantity and by revenue?*/

 SELECT TOP 10
 p.product_category_name,
 COUNT (order_item_id) AS quantity,
 SUM(o.price) AS revenue
 FROM olist_order_items_dataset AS o
 LEFT JOIN olist_products_dataset AS p
 ON o.product_id = p.product_id
 GROUP BY product_category_name , p.product_id
 ORDER BY quantity DESC;

 /* 7.What is the average delivery time (order purchase to delivery)?*/

 SELECT AVG(DATEDIFF(DAY,order_purchase_timestamp,order_delivered_customer_date)) AS avg_delivery_date
 FROM olist_orders_dataset
 WHERE order_status = 'delivered '
 AND order_delivered_customer_date IS NOT NULL;

 -- Avereage delivary date is 12 days --

 /* 8.How many orders are delivered late compared to the estimated delivery date? */

 SELECT 
 COUNT(*) AS order_deliveries,
 SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date 
 THEN 1 ELSE 0 
 END ) AS late_deliveries
 FROM olist_orders_dataset
 WHERE order_status = 'delivered' and  order_delivered_customer_date is not null;

 /* “Computed late delivery count and SLA breach percentage by comparing actual and estimated delivery dates using SQL.”*/

 /* 9.Which states or cities place the highest number of orders?*/

 SELECT COUNT(order_id) AS total_orders,
 customer_city ,
 customer_state 
 FROM olist_customers_dataset AS c
 LEFT JOIN olist_orders_dataset AS o
 ON c.customer_id = o.customer_id
 WHERE order_status ='delivered'
 GROUP BY customer_city ,customer_state
 ORDER BY COUNT(order_id) DESC;

 --“Analyzed geographic order distribution by city and state using normalized joins and aggregation to identify high-demand regions.”--
















