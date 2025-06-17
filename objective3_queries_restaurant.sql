-- Objective 3
-- Analyze customer behavior
-- Your final objective is to combine the items and orders tables, find the least and most ordered categories, and dive into the details of the highest spend orders.
-- -------
# 1. Combine the menu_items and order_details tables into a single table
-- ------- JOINS, left join add common columns and then first tables remaining col and then second tables remaining col
SELECT *
FROM order_details od LEFT JOIN menu_items mi   -- Add always first the transaction table to show what happened, od mi alias
 ON od.item_id = mi.menu_item_id;  -- both tables common columns

-- ------------------------------------------------------------------------------------
# 2. What were the least and most ordered items? What categories were they in?
-- -------
SELECT item_name,category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi  
 ON od.item_id = mi.menu_item_id
GROUP BY item_name , category     -- each means add group by, whatever u add in group by add in select
ORDER BY num_purchases ;         -- sort it

-- ------------------------------------------------------------------------------------

# 3. What were the top 5 orders that spent the most money?
-- -------
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi  
 ON od.item_id = mi.menu_item_id 
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;
-- ------------------------------------------------------------------------------------

# 4. View the details of the highest spend order. Which specific items were purchased?
-- -------
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi  
 ON od.item_id = mi.menu_item_id 
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 1;

SELECT category, COUNT(item_id) AS num_items 
FROM order_details od LEFT JOIN menu_items mi  
 ON od.item_id = mi.menu_item_id 
WHERE order_id = 440
GROUP BY category;

-- ------------------------------------------------------------------------------------
# 5. BONUS: View the details of the top 5 highest spend orders
-- -------
SELECT order_id, category, COUNT(item_id) AS num_items 
FROM order_details od LEFT JOIN menu_items mi  
 ON od.item_id = mi.menu_item_id 
WHERE order_id IN( 440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;
-- ------------------------------------------------------------------------------------

# Most expensive order
SELECT MAX(order_total) AS most_expensive_order
FROM (
    SELECT od.order_id, SUM(mi.price) AS order_total
    FROM order_details od
    JOIN menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY od.order_id
) AS sub;

