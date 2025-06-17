-- Objective 2
-- Explore the orders table
-- Your second objective is to better understand the orders table by finding the date range, the number of items within each order, and the orders with the highest number of items.

-- -------
# 1. View the order_details table. What is the date range of the table?
-- -------
SELECT MIN(order_date) AS Min_Date_range, MAX(order_date) AS Max_Date_range  
FROM order_details;

-- ------------------------------------------------------------------------------------
-- -------
# 2. How many orders were made within this date range? How many items were ordered within this date range?
-- -------
SELECT 
    MIN(order_date) AS min_date_range,
    MAX(order_date) AS max_date_range,
    COUNT(DISTINCT order_id) AS total_orders, -- counts how many unique orders are in the table (each order_id once)
    SUM(order_id) AS total_items_ordered 
FROM order_details;
-- ------------------------------------------------------------------------------------

-- -------
# 3. Which orders had the most number of items?
-- -------
SELECT order_id,
COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- ------------------------------------------------------------------------------------

-- -------
# 4. How many orders had more than 12 items?
-- -------

SELECT COUNT(*) AS num_orders_with_more_than_12_items
FROM (
    SELECT order_id                -- BELOW THIS PART SHOWS ORDERS MORE THAN 12 ITEMS so make it a subquery
    FROM order_details
    GROUP BY order_id
    HAVING COUNT(item_id) > 12    -- HAVING filters groups after aggregation
) AS num_orders;
-- ------------------------------------------------------------------------------------