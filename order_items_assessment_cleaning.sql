              -- DATA CLEANING --

--Updating the format of shipping date into standard formate --

UPDATE [dbo].[olist_order_items_dataset]
SET 
 shipping_limit_date=FORMAT(shipping_limit_date, 'yyyy-MM-dd HH:mm:ss') 


 --As order_item_id is not eligible for primary key we are adding surgent key making it as primary key --

 ALTER TABLE  [dbo].[olist_order_items_dataset]
 ADD item_id INT IDENTITY(1,1);
 
 -- Assigning primary key --
ALTER TABLE [dbo].[olist_order_items_dataset]
ADD CONSTRAINT pk_item PRIMARY KEY (item_id);

--Assigning foreign keys --

ALTER TABLE  [dbo].[olist_order_items_dataset]
ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset (order_id);

ALTER TABLE [dbo].[olist_order_items_dataset]
ADD CONSTRAINT fk_orderitemd_products FOREIGN KEY (product_id)
REFERENCES [dbo].[olist_products_dataset] (product_id);

ALTER TABLE [dbo].[olist_order_items_dataset]
ADD CONSTRAINT fk_orderitems_sellers FOREIGN KEY (seller_id)
REFERENCES olist_sellers_dataset (seller_id);