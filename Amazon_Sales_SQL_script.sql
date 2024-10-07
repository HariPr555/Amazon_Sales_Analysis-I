-- Create Amazon_Sales Database
create database Amazon_Sales;

-- Open the database to create tables inside it
use amazon_sales;

-- Drop any table named sales in Amazon_sales that exists to avoid error
drop table if exists sales;

-- Create a Table Sales in the Amazon_Sales database
create table if not exists Sales
(invoice_id varchar(30) not null,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float(6,4) not null,
total decimal(10,2) not null,
date date not null,
time time not null,
payment_method varchar(20) not null,
cogs decimal(10,2) not null,
gross_margin_percentage float(11,9) not null,
gross_income decimal(10,2) not null,
rating float(3,1) not null,
primary key (invoice_id) );

-- Verify if the table is created successfully with required columns and constraints
describe sales;

-- Path to upload the file to import data
show variables like 'secure_file_priv';

-- Insert values into the Sales table using csv file
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Amazon.csv'
into table Sales
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- Query to view all the records
select * from sales;

/* Adding a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. 
   Adding a new column named dayname that contains the extracted days of the week on which the given transaction took place. 
   Adding a new column named monthname that contains the extracted months of the year on which the given transaction took place */

alter table sales
add column timeofday varchar(20) not null,
add column dayname varchar(20) not null,
add column monthname varchar(20) not null;

-- Updating values to timeofday, dayname, monthname using transaction to maintian data integrity

-- Disable Safe Update Mode Temporarily
SET SQL_SAFE_UPDATES = 0;

-- Begins a new transaction.
start transaction;

-- Insert the values into timeofday column
update sales
set timeofday = case
				when time between '6:00:00' and '12:00:00' then 'Morning'
				when time between '12:00:01' and '18:00:00' then 'Afternoon'
				when time between '18:00:01' and '21:00:00' then 'Evening'
				when time between '21:00:01' and '00:00:00' then 'Night'
				else 'Late Night' end;

-- -- Insert the values into dayname column
update sales
set dayname = date_format(date, '%a');

-- Insert the values into monthname column
update sales
set monthname = date_format(date, '%b');

-- If all updates are successful, commit the transaction to apply all changes to the database.
commit;

--  If there’s an error or if something goes wrong, ROLLBACK to undo all changes made during the transaction.
rollback;

-- Enable Safe Update Mode
SET SQL_SAFE_UPDATES = 1;

-- EDA to find business insights

-- 1. What is the count of distinct cities in the dataset?
select count(distinct city) as city_count from sales;

-- Insights : There are total of 3 distinct cities

-- 2. For each branch, what is the corresponding city?
select distinct branch, city from sales;

-- Insights : There are 3 branches namely A,B and C with city names Yangon, Naypyitaw and Mandalay respectively.

-- 3. What is the count of distinct product lines in the dataset?
select count(distinct product_line) as product_line_count from sales;

-- Insights : There are total of 6 distinct Product Lines.

-- 4. Which payment method occurs most frequently?
select payment_method, count(*) as payment_count from sales
group by payment_method
order by payment_count desc
limit 1;

-- Insight : The Ewallet is the most frequently used payment method with 345 payments.

-- 5. Which product line has the highest sales?
select product_line, sum(total) as total_sales from sales
group by product_line
order by total_sales desc
limit 1;

-- Insight : Food and beverages has the highest sales in product line with total sales of 56144.96

-- 6. How much revenue is generated each month?
select monthname, sum(total) as total_revenue from sales
group by monthname
order by total_revenue desc;

-- Insights : Jan has the highest revenue compared to other months with total sales of 116292.11

-- 7. In which month did the cost of goods sold reach its peak?
select monthname, sum(cogs) as total_cogs from sales
group by monthname 
order by total_cogs desc
limit 1;

-- Insights : Cost of goods sold reached its peak in Jan with a total_cogs of 110754.16

-- 8. Which product line generated the highest revenue?
select product_line, sum(total) as total_revenue from sales
group by product_line
order by total_revenue desc 
limit 1;

-- Insight : Food and beverages has the highest revenue in product line with total revenue of 56144.96

-- 9. In which city was the highest revenue recorded?
select city, sum(total) as total_revenue from sales
group by city
order by total_revenue desc
limit 1;

-- Insight : Naypyitaw has the highest revenue in cities with total revenue of 110568.86

-- 10. Which product line incurred the highest Value Added Tax?
select product_line , sum(vat) as total_vat from sales
group by product_line
order by total_vat desc;

-- Insight : Food and beverages has the highest tax in product line with total VAT of 2673.5640

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

with product_line_sales as
(select product_line, sum(total) as total_sales from sales
group by product_line)

select product_line, 
	   sum(total) as line_total_sales, 
       case
	   when sum(total) > (select avg(total_sales) from product_line_sales) then 'Good'
       else 'Bad' end as sales_performance
from sales
group by product_line;

/* Insights : Except Health and beauty all other product lines exhibit good sales performance 
              well above the product line sales average.*/

-- 12. Identify the branch that exceeded the average number of products sold.

with branch_sales as
(select branch, sum(quantity) as total_quantity from sales
group by branch)

select branch, sum(quantity) as total_sales from sales
group by branch
having total_sales > (select avg(total_quantity) from branch_sales)
order by total_sales desc;

/* Insight : 'A' is the only branch that has 1859 total product sold 
			 which is well above the branch average products sold */

-- 13. Which product line is most frequently associated with each gender?
SELECT gender, product_line, COUNT(*) AS Frequency
FROM sales
GROUP BY gender, product_line
ORDER BY gender, Frequency DESC;

/* Insights : 'Health and beauty' is the most popular product line among men
			  'Fashion accessories' is the most popular product line among women */
              
-- 14. Calculate the average rating for each product line?
select product_line, round(avg(rating), 2) as Average_rating from sales
group by product_line
order by average_rating desc;

-- Insights : Food and beverages has the highest average rating of 7.11 among product lines.

-- 15. Count the sales occurrences for each time of day on every weekday
select dayname, timeofday, count(invoice_id) as sales_count from sales
group by dayname, timeofday
order by sales_count desc;

/* Insights : Saturday is the most busiest day and Monday being the most relaxed.
			  Afteroon has the most sales compared to other time of the day
              Saturday Afternoon is usually the busiest time of the week and Monday Morning being the most relaxed */

-- 16. Identify the customer type contributing the highest revenue.
select customer_type,round(sum(total), 2) as total_revenue from sales
group by customer_type
order by total_revenue desc
limit 1;

-- Insights : Most of the revenue is generated from 'Member' segment with total revenue of 164223.81

-- 17. Determine the city with the highest VAT percentage.
select city, round(avg(100*vat/cogs), 2) as vat_percentage
from sales
group by city
order by vat_percentage desc
limit 1;

-- Insights : All the cities has 5% VAT percentage.

-- 18. Identify the customer type with the highest VAT payments.
select customer_type, sum(vat) as total_vat from sales
group by customer_type
order by total_vat desc
limit 1;

-- Insights : 'Member' contribute to the highest VAT payments.

-- 19. What is the count of distinct customer types in the dataset?
select count(distinct customer_type) as segment_count from sales;

-- Insights : There are 2 disinct Customer types.

-- 20. What is the count of distinct payment methods in the dataset?
select count(distinct payment_method) as payment_method_count from sales;

-- Insights : There are 3 disinct Payment methods.

-- 21. Which customer type occurs most frequently?
select customer_type, count(invoice_id) as customer_count from sales
group by customer_type
order by customer_count desc;

-- Insights : Members shop more frequently.

-- 22. Identify the customer type with the highest purchase frequency.
select customer_type, count(invoice_id) as customer_count from sales
group by customer_type
order by customer_count desc;

-- Insights : Members shop more frequently.

-- 23. Determine the predominant gender among customers.
select gender, count(*) as customer_count from sales
group by gender
order by customer_count desc
limit 1;

-- Insights : Female are the predominant gender.

-- 24. Examine the distribution of genders within each branch
select branch, gender , count(*) as customer_count from sales
group by branch, gender
order by branch, customer_count desc;

-- Insights : Male are the popular gender in Branch 'A' and 'B' while Female are popular among 'C'

-- 25. Identify the time of day when customers provide the most ratings.
select timeofday, count(rating) as rating_count from sales
group by timeofday
order by rating_count desc
limit 1;

-- Insights : Most of the ratings are provided in the Afternoon. 

-- 26. Determine the time of day with the highest customer ratings for each branch.
select branch, timeofday, count(rating) as rating_count from sales
group by branch, timeofday
order by branch, rating_count desc;

-- Insights : Afternoon has the most ratings in all the branches.

-- 27. Identify the day of the week with the highest average ratings.
select dayname, round(avg(rating), 2) as average_rating from sales
group by dayname
order by average_rating desc
limit 1;

-- Insights : Monday ahd the highest average rating of 7.15

-- 28. Determine the day of the week with the highest average ratings for each branch.
select branch, dayname, round(avg(rating), 2) as average_rating from sales
group by branch, dayname
order by branch, average_rating desc;

-- Insights : A - Friday(7.31), B - Monday(7.34), C - Friday(7.28)
