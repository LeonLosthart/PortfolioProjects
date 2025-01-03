USE restaurant_db;

SELECT *
FROM menu_items;

-- --------------------------------------------------
-- Menu exploration----------------------------------
-- --------------------------------------------------

-- Find the total number of items on the menu.
SELECT COUNT(*)
FROM menu_items;

-- What are the least and most expensive items on the menu?
SELECT *
FROM menu_items
ORDER BY price ASC
LIMIT 1;

SELECT *
FROM menu_items
ORDER BY price DESC
LIMIT 1;

-- How many Italian dishes are on the menu?
SELECT COUNT(category)
FROM menu_items
WHERE category = 'Italian';

-- What are the least and most expensive Italian dishes on the menu?
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price ASC
LIMIT 1;

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;

-- How many dishes are in each category?
SELECT category, COUNT(menu_item_id) AS Num_dishes
FROM menu_items
GROUP BY category;

-- What is the average dish price within each category?
SELECT category, ROUND(AVG(price), 2) AS Avg_price
FROM menu_items
GROUP BY category;

-- --------------------------------------------------
-- Orders exploration--------------------------------
-- --------------------------------------------------
SELECT *
FROM order_details;

-- What is the date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details;

-- How many orders were made within this date range?
SELECT COUNT(DISTINCT order_id) AS Num_orders
FROM order_details;

-- How many items were ordered within this date range?
SELECT COUNT(*) AS Num_items
FROM order_details;

-- Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS Items_ordered
FROM order_details
GROUP BY order_id
ORDER BY Items_ordered DESC;

-- How many orders had more than 12 items?
SELECT COUNT(*)
FROM
	(SELECT order_id, COUNT(item_id) AS Num_items
	FROM order_details
	GROUP BY order_id
	HAVING Num_items >12) AS Num_orders;

-- --------------------------------------------------
-- Customer Behavior---------------------------------
-- --------------------------------------------------
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_details_id) AS Num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY Num_purchases ASC;

SELECT item_name, COUNT(order_details_id) AS Num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY Num_purchases DESC;

-- What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS Total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY Total_spend DESC
LIMIT 5;

-- View the details of the highest spend order. What insights can you gather from the results?
SELECT category, COUNT(item_id) AS Num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT order_id, category, COUNT(item_id) AS Num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;