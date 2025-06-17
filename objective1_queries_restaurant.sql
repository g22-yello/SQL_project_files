-- Objective 1
-- Explore the items table
-- Your first objective is to better understand the items table by finding the number of rows in the table, the least and most expensive items, and the item prices within each category.

-- -------
# 1. view the menu_items table and write a query to find the number of items on the menu
-- -------
USE restaurant_db;
SELECT * FROM menu_items;

SELECT COUNT(*) AS 'Total menu item count'
FROM menu_items;

-- ------------------------------------------------------------------------------------
# 2. least and most expensive items on the menu?
-- -------

SELECT * FROM menu_items   -- first see the lowest and higest amount
ORDER BY price;            -- add desc to check highest

SELECT *
FROM menu_items
WHERE price = (SELECT MAX(price) FROM menu_items)
   OR price = (SELECT MIN(price) FROM menu_items);
   
-- ------------------------------------------------------------------------------------
 # 3. how many italian dishes are on the menu? what are the least and most expensive italian dishes on the menu?
 -- both subqueries an douter queries need the condition of category as italian to work out
 -- -------
SELECT COUNT(*) AS 'Total italian dishes'
FROM menu_items
WHERE category = 'Italian';

SELECT *
FROM menu_items
WHERE category = 'Italian'
  AND (
      price = (SELECT MAX(price) FROM menu_items WHERE category = 'Italian')
      OR
      price = (SELECT MIN(price) FROM menu_items WHERE category = 'Italian')
  );
  
-- ------------------------------------------------------------------------------------
 # 4. How may dishes are in each category? what is the average dish price within each category?
 -- -------
SELECT category,
       COUNT(menu_item_id) AS total_dishes,
       ROUND(AVG(price), 2) AS average_price      # , 2 upto 2 decimals and as group by category averages each seperately
FROM menu_items
GROUP BY category; # This categorizes as category so count works as total count of each menu (nned to add in select statement!

-- ------------------------------------------------------------------------------------