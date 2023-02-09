--Welcome to my page, This is my first project on SQL.

-- On this project i will be working Finance Analysis of a company which base in some part of the world.

-- Here I will be creating a Database named BiolaPortifolio, 

CREATE DATABASE BiolaPortifolio;

GO                            

USE BiolaPortifolio;     

--Since the Database is just created, So I import data from Excel workbook to my Instance.

-- The importation of data has been done.

-- Let start by using the general select statement to retrive date from the Database.

SELECT * FROM BiolaPortifolio.dbo.Sales;

--This relational has 700 Records. 

SELECT COUNT(*) AS 'Number of Record' FROM BiolaPortifolio.dbo.Sales;

--When importing data, there are some error in column naming.

--In BiolaPortifolio.dbo.Sales, the column name [ Sales] has space in front and SQL won't query the column except it is written
-- in right way of writting column name.

-- Here is the code I used to modify the column name.


EXEC sp_rename 'Sales. Sales', 'Sales','COLUMN';

--Calculating Total Sales of The Company.

SELECT SUM(Sales) AS 'Total Sales' FROM BiolaPortifolio.dbo.Sales;

--Findind the total unit solds, total Manufacturing Price, total sales, total profit and gross margin 

SELECT SUM(Units_Sold) AS 'Total Unit Sold',
SUM(Manufacturing_Price) AS 'Total Manufacturing Price' ,
SUM(Sales) AS 'Total Sales',
SUM(Profit) AS 'Total Profit',
(SUM (Sales) - SUM(Profit)) AS 'Gross Profit'
FROM BiolaPortifolio.dbo.Sales;

--Here is the list of the countries the company operates.
SELECT DISTINCT Country FROM BiolaPortifolio.dbo.Sales;

--Calculating Total Sales of The Company across the countries.

SELECT Country, SUM(Sales) AS 'Total Sales' FROM BiolaPortifolio.dbo.Sales GROUP BY Country;

-- Finding the top 5 profitable country, with the product and total sales of that year 

SELECT TOP 5 Country, YEAR(DATE) AS Year, 
Product, SUM(Sales) AS'Total Sales of The Year', 
SUM(Profit) AS 'Total Profit of The Year'  
FROM BiolaPortifolio.dbo.Sales 
GROUP BY Country, DATE, Product 
ORDER BY 5 DESC;
 
 -- Finding the top 5 profitable country, with the product and total sales of specific year.

SELECT TOP 5 Country, YEAR(DATE) AS Year, 
Product, SUM(Sales) AS'Total Sales of The Year', 
SUM(Profit) AS 'Total Profit of The Year'  
FROM BiolaPortifolio.dbo.Sales 
WHERE YEAR(DATE)= 2014
GROUP BY Country, DATE, Product 
ORDER BY 5 DESC;

-- List of counties with thier Average Profit and Average Sales.


 SELECT DISTINCT Country, AVG( COALESCE(Profit, 0)) AS 'Average Profit' ,
 AVG( COALESCE(Sales, 0)) AS 'Average Sales' FROM BiolaPortifolio.dbo.Sales GROUP BY Country 
 ORDER BY  2 DESC;

 --Calculating Total Sales and Total Profit for Discount Band in each Segement.  

  SELECT Segment, Discount_band, COUNT(Discount_band) AS 'Number of Discount Band',  SUM(Sales) AS 'Total Sales',
  SUM(Profit) AS 'Total Profit'
  FROM BiolaPortifolio.dbo.Sales GROUP BY Segment, Discount_Band ORDER BY 1;

 --The Total Sales and Total Profit of
SELECT year, Month_Name, SUM(Sales) AS 'Total Sales', SUM(Profit) AS 'Total profit' 
FROM BiolaPortifolio.dbo.Sales GROUP BY year, Month_Name ORDER  BY 1,2, 3, 4 DESC;

--These are some query language use in SQL, they are used in retriving data from Database