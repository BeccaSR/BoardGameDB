CREATE DATABASE BoardGameDB;
USE BoardGameDB;

CREATE TABLE staff
(Staff_ID INT NOT NULL PRIMARY KEY,
First_Name VARCHAR (50) NOT NULL,
Last_Name VARCHAR (50) NOT NULL,
Department_ID INT NOT NULL
);

CREATE TABLE department
(Department_ID INT NOT NULL PRIMARY KEY,
D_Name VARCHAR (50) NOT NULL,
D_Manager VARCHAR (50) NULL
);

CREATE TABLE stock
(Game_ID INT NOT NULL PRIMARY KEY,
G_Name VARCHAR (50) NOT NULL,
G_Category VARCHAR (50) NULL,
G_No_in_Stock INT NULL,
G_Price FLOAT NOT NULL
);

CREATE TABLE customers
(Cust_ID INT NOT NULL PRIMARY KEY,
C_First_Name VARCHAR (50) NOT NULL,
C_Last_Name VARCHAR (50) NOT NULL,
Address_ID INT NULL,
Email_ID INT NULL
);

CREATE TABLE cust_addresses
(Address_ID INT NOT NULL PRIMARY KEY,
A_First_Line VARCHAR (100) NOT NULL,
Post_Code VARCHAR (10) NOT NULL
);

CREATE TABLE email_addresses
(Email_ID INT NOT NULL PRIMARY KEY,
Email_Address VARCHAR (100) NOT NULL
);

CREATE TABLE online_orders
(Order_ID INT NOT NULL PRIMARY KEY,
Cust_ID INT NOT NULL,
Game_ID INT NOT NULL,
Order_Cost FLOAT NOT NULL,
Order_Processed BOOLEAN,
FOREIGN KEY (Cust_ID) REFERENCES customers(Cust_ID) ON UPDATE CASCADE,
FOREIGN KEY (Game_ID) REFERENCES stock(Game_ID) ON UPDATE CASCADE
);

CREATE TABLE instore_sales
(Sale_ID INT NOT NULL PRIMARY KEY,
Staff_ID INT NULL,
Game_ID INT NOT NULL,
Sales_Cost FLOAT NOT NULL,
FOREIGN KEY (Staff_ID) REFERENCES staff(Staff_ID) ON UPDATE CASCADE,
FOREIGN KEY (Game_ID) REFERENCES stock(Game_ID) ON UPDATE CASCADE
);

ALTER TABLE staff
ADD FOREIGN KEY (Department_ID) REFERENCES department(Department_ID) ON UPDATE CASCADE;

ALTER TABLE customers
ADD FOREIGN KEY (Address_ID) REFERENCES cust_addresses(Address_ID) ON UPDATE CASCADE,
ADD FOREIGN KEY (Email_ID) REFERENCES email_addresses(Email_ID) ON UPDATE CASCADE;

INSERT INTO department
(Department_ID, D_Name, D_Manager)
VALUES
(001, 'Sales', 'Mike'),
(002, 'Warehouse', 'Dave'),
(003, 'Purchasing', 'Helen'),
(004, 'HR', 'Sam');

SELECT * FROM department;

INSERT INTO staff
(Staff_ID, First_Name, Last_Name, Department_ID)
VALUES
(037, 'Dave', 'Woods', 002),
(042, 'Mike', 'Sanderson', 001),
(047, 'Sam', 'Holland', 004),
(058, 'Sonia', 'Bonner', 002),
(073, 'Helen', 'Cannon', 003),
(074, 'Alfred', 'Castaneda', 002),
(075, 'Kimberley', 'Potter', 004),
(076, 'Hari', 'Foley', 002),
(082, 'Nathanael', 'Bonner', 003),
(083, 'Saffron', 'Cameron', 002),
(086, 'Tatiana', 'Knowles', 002),
(087, 'Natalie', 'Pierce', 001),
(092, 'Amir', 'Hutchinson', 001),
(093, 'Frankie', 'Walls', 002),
(096, 'Aiza', 'Duke', 001),
(099, 'Allan', 'Horton', 001),
(102, 'Theresa', 'Spencer', 004),
(103, 'Harris', 'David', 001),
(105, 'Shannon', 'Lindsay', 002),
(106, 'Alanna', 'Collins', 001),
(108, 'Kareem', 'Obrien', 001);

SELECT * FROM staff;

INSERT INTO stock
(Game_ID, G_Name, G_Category, G_No_in_Stock, G_Price)
VALUES
(001, 'Gloomhaven', 'Adventure', 4, 126.99),
(002, 'Pandemic Legacy: Season 1', 'Cooperative', 10, 64.99),
(003, 'Brass: Birmingham', 'Economic Strategy', 11, 59.99),
(004, 'Terraforming Mars', 'Economic Strategy', 7, 54.99),
(005, 'Gloomhaven: Jaws of the Line', 'Adventure', 8, 39.99),
(006, 'Gaia Project', 'Strategy', 11, 66.99),
(007, 'Star Wars: Rebellion', 'Strategy', 3, 80.99),
(008, 'Twilight Struggle', 'Historical Strategy', 0, 69.99),
(009, 'Great Western Trail 2nd Edition', 'Economic Strategy', 12, 35.99),
(010, 'Spirit Island', 'Cooperative', 3, 69.99),
(011, 'Scythe', 'Historical Strategy', 7, 66.99),
(012, 'Terra Mystica', 'Strategy', 9, 74.99),
(013, '7 Wonders Duel', 'Engine-Building', 13, 18.99),
(014, 'Brass: Lancashire', 'Economic Strategy', 9, 58.99),
(015, 'Wingspan', 'Engine-Building', 8, 43.99),
(016, 'A Feast for Odin', 'Worker Placement', 5, 89.99),
(017, 'Viticulture', 'Worker Placement', 3, 26.99),
(018, 'Root', 'Worker Placement', 6, 43.99),
(019, 'Food Chain Magnate', 'Strategy', 0, 77.99),
(020, 'Agricola', 'Engine-Building', 2, 48.99),
(021, 'Everdell', 'Worker Placement', 10, 38.99),
(022, 'Power Grid', 'Strategy', 1, 49.99),
(023, 'Azul', 'Strategy', 12, 25.99),
(024, 'Clank! in Space!: A Deck-Building Adventure', 'Engine-Building', 4, 49.99),
(025, 'Marvel Champions: The Card Game', 'Cooperative', 7, 50.99),
(026, 'Clank!: A Deck-Building Adventure', 'Engine-Building', 6, 48.99),
(027, 'The Quacks of Quedlingburg', 'Push Your Luck', 8, 39.99),
(028, 'Five Tribes', 'Worker Placement', 2, 48.99),
(029, 'Lords of Waterdeep', 'Worker Placement', 4, 38.99),
(030, 'Keyflower', 'Strategy', 7, 41.99),
(031, 'Patchwork', 'Strategy', 10, 17.99),
(032, 'Codenames', 'Party Game', 9, 17.99),
(033, 'Roll for the Galaxy', 'Dice', 7, 52.99),
(034, 'Pandemic', 'Cooperative', 7, 29.99);

SELECT * FROM stock;

INSERT INTO cust_addresses
(Address_ID, A_First_Line, Post_Code)
VALUES
(001, '82 Manchester Road', 'NW60 9WY'),
(002, '77 West Street', 'EC97 2KR'),
(003, '86 West Street', 'E48 3DP'),
(004, '821 Park Avenue', 'W19 8FY'),
(005, '557 Queensway', 'E38 6VD'),
(006, '58 Broadway', 'E71 6WK'),
(007, '43 Queens Road', 'N87 9UP'),
(009, '13 Stanley Road', 'EC08 2GO'),
(010, '16 The Grove', 'SW61 4NM'),
(011, '625 Grove Road', 'SE71 8DW'),
(012, '9 London Road', 'WC46 9IR'),
(014, '904 Main Road', 'WC85 6RJ'),
(015, '68 Alexander Road', 'NW27 0CI'),
(016, '572 Victoria Road', 'W49 3YS'),
(017, '69 North Road', 'N27 3VD'),
(018, '12 York Road', 'SE60 8QC'),
(019, '768 Chester Road', 'EC13 5VL'),
(020, '233 Mill Road', 'W76 9PS');

SELECT * FROM cust_addresses;

INSERT INTO email_addresses
(Email_ID, Email_Address)
VALUES
(001, 'robert.smith@gmail.com'),
(002, 'debbiecooks@gmail.co.uk'),
(003, 'dottymorris@gmail.com'),
(004, 'joemorris@gmail.com'),
(005, 'graceh@yahoo.co.uk'),
(006, 'tom_roberts@hotmail.com'),
(007, 'young.paul@btinternet.com'),
(008, 'alexandpam@gmail.com'),
(009, 'adamhughes98@gmail.co.uk'),
(010, 'justin.e.kelly@hotmail.com'),
(011, 'k_parker@googlemail.com'),
(012, 'anne_1999@yahoo.com'),
(013, 'collins_d12@gmail.co.uk'),
(014, 'dwightys@hotmail.com'),
(015, 'jess.cook@gmail.com'),
(016, 'cook_jack89@hotmail.com'),
(017, 'lisamoore@yahoo.com'),
(018, 'josejacks_son@hotmail.co.uk'),
(019, 'bettina.brown@gmail.com'),
(020, 'joe.morgan@yahoo.com'),
(021, 'l_davies_9@gmail.com'),
(022, 'izzym07@gmail.co.uk');

SELECT * FROM email_addresses;

INSERT INTO customers
(Cust_ID, C_First_Name, C_Last_Name, Address_ID, Email_ID)
VALUES
(001, 'Robert', 'Smith', 001, 001), 
(002, 'Jerry', 'Evans', 002, NULL),
(003, 'Debra', 'Cook', 003, 002),
(004, 'Dorothy', 'Morris', 004, 003),
(005, 'Joesph', 'Morris', 004, 004), 
(006, 'Grace', 'Harrison', 005, 005),
(007, 'Thomas', 'Roberts', 005, 006),
(008, 'Paul', 'Young', 006, 007),
(009, 'Alexander', 'Parker', 007, 008), 
(010, 'Alexander', 'Anderson', 009, NULL), 
(011, 'Pamela', 'Parker', 007, 008), 
(012, 'Adam', 'Hughes', 010, 009), 
(013, 'Justin', 'Kelly', NULL, 010), 
(014, 'Karen', 'Parker', 011, 011),
(015, 'Donald', 'Collins', 012, 013), 
(016, 'Jessica', 'Cook', 014, 015),
(017, 'Jack', 'Cook', 014, 016),
(018, 'David', 'Simpson', 015, NULL), 
(019, 'Lisa', 'Clark', NULL, 017), 
(020, 'Jose', 'Jackson', 016, 018), 
(021, 'Betty', 'Brown', 017, 019), 
(022, 'Jonathan', 'Morgan', 018, 020), 
(023, 'Leo', 'Davies', 019, 021), 
(024, 'Isabella', 'Morgan', 020, 022); 

SELECT * FROM customers;

INSERT INTO online_orders
(Order_ID, Cust_ID, Game_ID, Order_Cost, Order_Processed)
VALUES
(101, 015, 029, 38.99, TRUE),
(102, 015, 015, 43.99, TRUE),
(103, 011, 020, 48.99, TRUE),
(104, 001, 032, 17.99, TRUE),
(105, 003, 001, 126.99, TRUE),
(106, 007, 027, 39.99, TRUE),
(107, 004, 012, 74.99, TRUE),
(108, 006, 026, 48.99, TRUE),
(109, 009, 018, 43.99, TRUE),
(110, 012, 026, 48.99, TRUE),
(111, 007, 023, 25.99, TRUE),
(112, 020, 034, 29.99, TRUE),
(113, 005, 014, 58.99, TRUE),
(114, 012, 026, 48.99, TRUE),
(115, 021, 011, 66.99, TRUE),
(116, 022, 031, 17.99, TRUE),
(117, 003, 005, 39.99, TRUE),
(118, 003, 023, 25.99, TRUE),
(119, 023, 032, 17.99, TRUE),
(120, 009, 026, 48.99, TRUE),
(121, 024, 021, 38.99, TRUE),
(122, 009, 024, 49.99, TRUE),
(123, 021, 008, 69.99, TRUE),
(124, 024, 019, 77.99, FALSE),
(125, 004, 015, 43.99, TRUE),
(126, 004, 023, 25.99, FALSE),
(127, 004, 003, 59.99, FALSE);
 
SELECT * FROM online_orders;

INSERT INTO instore_sales
(Sale_ID, Staff_ID, Game_ID, Sales_Cost)
VALUES
(501, 087, 015, 43.99),
(502, 087, 023, 25.99),
(503, 092, 011, 66.99),
(504, 087, 026, 48.99),
(505, 092, 023, 25.99),
(506, 092, 020, 48.99),
(507, 092, 026, 48.99),
(508, 096, 002, 64.99),
(509, 099, 015, 43.99),
(510, 099, 028, 48.99),
(511, 096, 031, 17.99),
(512, 087, 018, 43.99),
(513, 096, 025, 50.99),
(514, 096, 002, 64.99),
(515, 087, 015, 43.99),
(516, 099, 021, 38.99),
(517, 099, 026, 48.99),
(518, 099, 034, 29.99), 
(519, 092, 026, 48.99),
(520, 092, 009, 35.99),
(521, 096, 021, 38.99),
(522, 103, 015, 43.99),
(523, 092, 017, 26.99),
(524, 103, 024, 49.99),
(525, 106, 031, 17.99),
(526, 108, 026, 48.99),
(527, 099, 016, 89.99),
(528, 099, 014, 58.99),
(529, 106, 028, 48.99);

SELECT * FROM instore_sales;




/* TRIGGER AND EVENT TABLES */

CREATE TABLE Price_Changes
(ID INT AUTO_INCREMENT PRIMARY KEY,
Game_ID INT,
Old_Cost FLOAT,
New_Cost FLOAT,
Changed_At TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE price_changes
ADD FOREIGN KEY (Game_ID) REFERENCES stock(Game_ID) ON UPDATE CASCADE;

SELECT * FROM price_changes;

CREATE TABLE Running_Profit
(Day_ID INT AUTO_INCREMENT PRIMARY KEY,
OnlineSales FLOAT,
InstoreSales FLOAT,
TotalSales FLOAT,
Last_Update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM running_profit;