use bank_tabs;

SELECT * FROM bank_tabs;
SHOW TABLES;

-- 4.Select all the data from table credit_card_data to check if the data was imported correctly.
SELECT * FROM creditcardmarketing LIMIT 10;
DESCRIBE creditcardmarketing;

-- 5.Use the alter table command to drop the column q4_balance from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
ALTER TABLE creditcardmarketing DROP COLUMN q4_balance;

-- To verify if the column is dropped and limit the results to 10:
SELECT * FROM creditcardmarketing LIMIT 10;

-- 6.Use sql query to find how many rows of data you have.
SELECT COUNT(*) FROM creditcardmarketing;

-- 7.Now we will try to find the unique values in some of the categorical columns:

SELECT DISTINCT `offer_accepted` FROM creditcardmarketing;
SELECT DISTINCT reward FROM creditcardmarketing;
SELECT DISTINCT `mailer type` FROM creditcardmarketing;
SELECT DISTINCT `credit cards held` FROM creditcardmarketing;
SELECT DISTINCT `household size` FROM creditcardmarketing;

-- 8.Arrange the data in a decreasing order by the average_balance of the customer. Return only the customer_number of the top 10 customers with the highest average_balances in your data.
SELECT `Customer Number`
FROM creditcardmarketing
ORDER BY `Average Balance` DESC
LIMIT 10;


-- 9.What is the average balance of all the customers in your data?
SELECT AVG(`average balance`) AS `avg balance` 
FROM creditcardmarketing;

-- 10.In this exercise we will use simple group_by to check the properties of some of the categorical variables in our data. Note wherever average_balance is asked, please take the average of the column average_balance:
-- Average balance grouped by income_level: 
SELECT `income level`, AVG(`average balance`) AS `avg balance` 
FROM creditcardmarketing 
GROUP BY `income level`;

-- Average balance grouped by number_of_bank_accounts_open:
SELECT `# Credit Cards Held`, AVG(`Average Balance`) AS `avg_balance`
FROM creditcardmarketing
GROUP BY `# Credit Cards Held`;

-- What is the average number of credit cards held by customers for each of the credit card ratings? The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.
SELECT `credit rating`, AVG(`# credit cards held`) AS `avg credit cards` 
FROM creditcardmarketing 
GROUP BY `credit rating`;

-- Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

DESCRIBE creditcardmarketing;

SELECT `# Credit Cards Held`, AVG(`# Bank Accounts Open`) AS `avg_bank_accounts`
FROM creditcardmarketing
GROUP BY `# Credit Cards Held`
LIMIT 0, 1000;


-- 11.Your managers are only interested in the customers with the following properties:

SELECT * 
FROM creditcardmarketing 
WHERE `Credit Rating` IN ('medium', 'high') 
  AND `# Credit Cards Held` <= 2
  AND `Own Your Home` = 'Yes'
  AND `Household Size` >= 3
LIMIT 0, 1000;

-- 12.Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. Write a query to show them the list of such customers. You might need to use a subquery for this problem.
SELECT * 
FROM creditcardmarketing 
WHERE `Average Balance` < (
    SELECT AVG(`Average Balance`) 
    FROM creditcardmarketing
);

-- 13.Since this is something that the senior management is regularly interested in, create a view of the same query.
CREATE VIEW Customers_Below_Average_Balance AS
SELECT * 
FROM creditcardmarketing 
WHERE `Average Balance` < (
    SELECT AVG(`Average Balance`) 
    FROM creditcardmarketing
);

SELECT * FROM Customers_Below_Average_Balance;

-- 14.What is the number of people who accepted the offer vs number of people who did not?
SELECT `Offer Accepted`, COUNT(*) AS `Number of Customers`
FROM creditcardmarketing
GROUP BY `Offer Accepted`;

-- 15.Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?
SELECT 
    (SELECT AVG(`Average Balance`) 
     FROM creditcardmarketing 
     WHERE `Credit Rating` IN ('High', 'Medium')) AS `Avg_High_Medium`,
     
    (SELECT AVG(`Average Balance`) 
     FROM creditcardmarketing 
     WHERE `Credit Rating` = 'Low') AS `Avg_Low`,
     
    ((SELECT AVG(`Average Balance`) 
      FROM creditcardmarketing 
      WHERE `Credit Rating` IN ('High', 'Medium')) - 
     (SELECT AVG(`Average Balance`) 
      FROM creditcardmarketing 
      WHERE `Credit Rating` = 'Low')) AS `Difference`;

-- 16.In the database, which all types of communication (mailer_type) were used and with how many customers?
SELECT `Mailer Type`, COUNT(*) AS `Number of Customers`
FROM creditcardmarketing
GROUP BY `Mailer Type`;

-- 17.Provide the details of the customer that is the 11th least Q1_balance in your database.
SELECT *
FROM creditcardmarketing
ORDER BY `Q1 Balance` ASC
LIMIT 10, 1;





