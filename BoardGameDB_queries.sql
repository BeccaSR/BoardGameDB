/* TABLES */
SELECT * FROM staff;
SELECT * FROM department;
SELECT * FROM customers;
SELECT * FROM cust_addresses;
SELECT * FROM email_addresses;
SELECT * FROM stock;
SELECT * FROM online_orders;
SELECT * FROM instore_sales;




/* USING JOINS TO CREATE A VIEW
Create a view showing the sales id, staff name, game name and cost of each instore sales */

CREATE VIEW vw_instore AS
SELECT i.Sale_ID, CONCAT(s.First_Name, ' ', s.Last_Name) AS Name, g.G_Name, i.sales_cost
FROM instore_sales i
LEFT JOIN staff s
ON i.Staff_ID = s.Staff_ID
LEFT JOIN stock g
ON i.Game_ID = g.Game_ID;

SELECT * FROM vw_instore;


/* Use the view to show the top 3 salepersons and the total sum of their sales */

SELECT Name, SUM(Sales_Cost) AS Total_Sold
FROM vw_instore
GROUP BY Name
ORDER BY Total_Sold DESC
LIMIT 3;




/* VIEW WITH 3-4 BASE TABLES, QUERY TO DEMONSTRATE with GROUP BY AND HAVING
Create a view showing the order id, customer name, customer postcode, game name and cost of each online order */

CREATE VIEW vw_online AS
SELECT o.Order_ID, CONCAT(c.C_First_Name, ' ', c.C_Last_Name) AS Name, a.Post_Code, g.G_Name, o.Order_Cost
FROM online_orders o
LEFT JOIN customers c
ON o.Cust_ID = c.Cust_ID
LEFT JOIN cust_addresses a
ON c.Address_ID = a.Address_ID
LEFT JOIN stock g
ON o.Game_ID = g.Game_ID;

SELECT * FROM vw_online;


/* QUERY WITH GROUP BY AND HAVING
 Use the view to find out the game name and number of online orders for each game sold for more than £40 */

SELECT G_Name, Order_Cost, COUNT(Order_ID) AS No_Sold
FROM vw_online
GROUP BY G_Name, Order_Cost
HAVING Order_Cost > 40
ORDER BY No_Sold DESC;




/* QUERY WITH SUBQUERY
Find the first name and last name of each customer who has placed an order online for a 'worker placement' game */

SELECT C_First_Name, C_Last_Name
FROM customers
WHERE Cust_ID IN (SELECT DISTINCT Cust_ID
					FROM online_orders
                    WHERE Game_ID IN (SELECT Game_ID
										FROM stock
                                        WHERE G_Category = 'Worker Placement'));




/*STORED FUNCTION 
Write a stored function that tells you the department of a staff member when given their department_ID */

DELIMITER //
CREATE FUNCTION Staff_Department(Department_ID INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE staff_department VARCHAR(50);
    IF Department_ID = 001 THEN
		SET staff_department = 'Sales';
	ELSEIF Department_ID = 002 THEN
		SET staff_department = 'Warehouse';
	ELSEIF Department_ID = 003 THEN
		SET staff_department = 'Purchasing';
	ELSEIF Department_ID = 004 THEN
		SET staff_department = 'HR';
	END IF;
RETURN (staff_department);
END //
DELIMITER ;


SELECT *, Staff_Department(Department_ID) AS Department
FROM staff;




/* STORED PROCEDURE
 Write a stored procedure that inserts sales values into the instore_sales table */

DELIMITER //
CREATE PROCEDURE InsertSales(IN Sale_ID INT, IN Staff_ID INT, Game_ID INT, Sales_Cost FLOAT)
BEGIN
	INSERT INTO instore_sales(Sale_ID, Staff_ID, Game_ID, Sales_Cost)
	VALUES (Sale_ID, Staff_ID, Game_ID, Sales_Cost);
END //
DELIMITER ;


/* Use the new procedure to insert the below sale into the instore_sales table
   (531, 92, 31, 17.99) */

CALL InsertSales(531, 92, 31, 17.99);

SELECT * FROM instore_sales;




/* TRIGGER
Create a trigger to keep track of game price changes, by updating the price_changes table */

DELIMITER //
CREATE TRIGGER PriceChange
AFTER UPDATE ON stock
FOR EACH ROW
BEGIN
	IF OLD.G_Price <> NEW.G_Price THEN
		INSERT INTO price_changes(Game_ID, Old_Cost, New_Cost)
        VALUES (old.Game_ID, old.G_Price, new.G_Price);
	END IF;
END //
DELIMITER ;

UPDATE stock
SET G_Price = 39.99
WHERE Game_ID = 018;

SELECT * FROM price_changes;




/* EVENT
Create an event that updates the running_profit table once a day */

DELIMITER //
CREATE EVENT RunningProfit
	ON SCHEDULE EVERY 24 HOUR   
DO BEGIN
	INSERT INTO running_profit(OnlineSales, InstoreSales, TotalSales)
		SELECT SUM(Order_Cost) AS OnlineSales, SUM(Sales_Cost) AS InstoreSales, SUM(Order_Cost) + SUM(Sales_Cost) AS TotalSales
		FROM online_orders, instore_sales;
END //
DELIMITER ;

SELECT * FROM running_profit;

DROP EVENT RunningProfit;