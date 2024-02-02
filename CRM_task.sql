create database CRM;
use CRM;
select * from accounts;
select * from clicks;
select * from products;
SELECT * FROM crm.`sales-pipeline`;
select * from `sales-teams`;

#1 SELECT Clause: Find the names of all products.
SELECT product FROM products;

#2 WHERE Clause: Retrieve all sales records for deals closed after January 1, 2016.

SELECT * FROM crm.`sales-pipeline` WHERE close_date > '2016-01-01';

#3"GROUP BY Clause
#Write a query in SQL to find the sum of amount using salespipeline"

SELECT EXTRACT(YEAR FROM Close_Date) AS CloseDateYear,
EXTRACT(MONTH FROM Close_Date) AS CloseDateMonth,
SUM(Close_Value) AS sumAmount
FROM crm.`sales-pipeline`
GROUP BY EXTRACT(YEAR FROM Close_Date), EXTRACT(MONTH FROM Close_Date)
ORDER BY CloseDateYear, CloseDateMonth
LIMIT 1000;

#4 "JOIN Clause
#Write a query in SQL to obtain the name of the account with Opportunity_ID who are yet to be affiliated."

SELECT Opportunity_ID, Sales_Agent, sp.account
FROM crm.`sales-pipeline` sp
INNER JOIN accounts a ON sp.account = a.account
ORDER BY sp.account
LIMIT 0, 1000;

#5 Write a query in SQL Count the number of sales team members for each regional office and display only those with more than 5 members.
SELECT Regional_Office, COUNT(*) AS TeamSize FROM `sales-teams`
GROUP BY Regional_Office HAVING COUNT(*) > 8;


#6 "Else Case Statement
#Write a query in SQL Categorize sales team members based on regional offices HQ  or Field office"

SELECT Sales_Agent, CASE WHEN Regional_Office = 'HQ' THEN 'HQ' ELSE 'Field Office'
END AS OfficeCategory FROM `sales-teams`;


#7 "UNION Operator
#Write a query in SQL Combine accounts with 'Closed-Won' deals and 'Closed-Lost' deals."

SELECT Account, Close_Value FROM crm.`sales-pipeline` WHERE Deal_Stage = 'Won'
UNION
SELECT Account, Close_Value FROM crm.`sales-pipeline` WHERE Deal_Stage = 'Lost';


#8 "Else Case Statement
#Write a query in SQL Categorize deal stages as 'High Value' or 'Low Value'"

SELECT Deal_Stage, CASE WHEN Close_Value > 100000 THEN 'High Value' ELSE 'Low Value'
END AS ValueCategory FROM crm.`sales-pipeline`;


#9 "AVG  Maths
#Write a query in SQL avg salespipeline followed by Sales_Agent"
SELECT Sales_Agent, AVG(Close_Value) AS AvgCloseValue
FROM crm.`sales-pipeline` GROUP BY Sales_Agent;

#10 "OFFSET Clause
#Write a query in SQL to find OFFSET  of  product followed by created date"
SELECT Created_On, Account
FROM crm.`sales-pipeline`
ORDER BY Product
LIMIT 10 OFFSET 20;


#11 "Windowing  Function
#Write a query in SQL to find Lead and lag of  Industry  followed by created date"
SELECT
Created_On, Industry,
LEAD(Created_On) OVER (ORDER BY Industry) AS next_value,
LAG(Created_On) OVER (ORDER BY Industry) AS previous_value
FROM clicks;


#12 "FETCH Clause
#Write a query in SQL to FETCH Opportunity_ID, Sales_Agent, Product  Followed by LIMIT 10, 5;"
SELECT Opportunity_ID, Sales_Agent, Product
FROM crm.`sales-pipeline`
ORDER BY Opportunity_ID
LIMIT 10, 5;
