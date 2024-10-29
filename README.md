# Amazon_Sales_Analysis-I
This analysis offers an in-depth exploration of Amazon’s sales data, with a focus on understanding customer demographics, product performance, and sales trends. Leveraging MySQL, it reveals key insights into buying patterns, product popularity, and branch-specific performance, helping to inform data-backed strategies for improving customer satisfaction, refining product offerings, and boosting overall revenue.

## Background
Amazon is a global e-commerce leader, offering a wide range of products across multiple categories.The company is known for its customer-centric approach, vast product offerings, and innovations like Amazon Prime and Alexa. Its sales data provides insights into customer preferences, product performance, and revenue trends across different regions. Analyzing this data helps businesses optimize strategies for better market targeting and inventory management.

## Project Goals
The major aim of this project is to gain insight into the sales data of Amazon to understand the different factors that affect sales of the different branches.
- **Product Analysis**
- **Sales Analysis**
- **Customer Analysis**

## Techical Stack
**Data Analysis** : Excel, MySQL

## Data Understanding
This dataset contains 1000 sales transactions from three different branches of Amazon, respectively located in Mandalay, Yangon and Naypyitaw.
- **Sales**  : Invoice ID, Branch, City, Unit price, Quantity, VAT,  Total, Payment  method, Cogs, Gross Margin Percentage and Gross Income
- **Product** : Product line, unit price
- **Customer** : Gender, Customer type

## Data Preparation
### Data Wrangling
   - Creating a Database.
   - Creating a Table with constraints.
   - Loading and Inserting the values into the Table.
### Feature Engineering
   - Added new columns - Timeofday, Dayname, Monthname
 
## Business Questions
1. What is the count of distinct cities in the dataset?
2. For each branch, what is the corresponding city?
3. What is the count of distinct product lines in the dataset?
4. Which payment method occurs most frequently?
5. Which product line has the highest sales?
6. How much revenue is generated each month?
7. In which month did the cost of goods sold reach its peak?
8. Which product line generated the highest revenue?
9. In which city was the highest revenue recorded?
10. Which product line incurred the highest Value Added Tax?
11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
12. Identify the branch that exceeded the average number of products sold.
13. Which product line is most frequently associated with each gender?
14. Calculate the average rating for each product line?
15. Count the sales occurrences for each time of day on every weekday
16. Identify the customer type contributing the highest revenue.
17. Determine the city with the highest VAT percentage.
18. Identify the customer type with the highest VAT payments.
19. What is the count of distinct customer types in the dataset?
20. What is the count of distinct payment methods in the dataset?
21. Which customer type occurs most frequently?
22. Identify the customer type with the highest purchase frequency.
23. Determine the predominant gender among customers.
24. Examine the distribution of genders within each branch.
25. Identify the time of day when customers provide the most ratings.

## Sales Analysis
### Revenue Trends
  - **Highest Revenue Month**: January is the highest-grossing month
  - **City-wise Revenue**: Naypyitaw generates the most revenue
### Time bases Sales
  - **Peak Sales Times**: Afternoons, especially on Saturdays, are the busiest times.
  - **Slow Sales Times**: Mondays, particularly in the morning, have the lowest sales.
### Branch Performance
  - Top Performing Branch: Branch A exceeds average product sales, indicating strong performance.
### Payment Methods
  - Most Used Payment Method: E-wallets are the most frequently used, with 345 transactions.

## Product Analysis
### Top Performing Product Lines
  - **Food and Beverages**: This product line leads in total sales, revenue, and VAT contribution.
### Underperforming Product Lines
  - **Health and Beauty**: This product line has below-average sales performance.
### Highest Rated Product Line
  - **Food and Beverages**: This prodcut line has the highest average rating of 7.11.
### Sales Performance by Product Line
  - **Product Segmentation**: Most product lines perform well above average, except for "Health and Beauty."

## Customer Analysis
### Customer Segmentation
  - **Customer Type**: Members generate the most revenue and shop more frequently than non-members.
### Gender Distribution
  - **Predominant Gender**: Females are the predominant gender among customers.
  - **Branch-specific Gender Preferences**: Gender preferences vary across branches, with males dominating in Branch A and B, and females in Branch C.
### Customer Feedback
  - **Time of Day for Ratings**: Most customer ratings are provided in the afternoon.
  - **Highest Average Ratings**: Monday has the highest average customer ratings.

## Recommendations
### Sales Strategies
   - **Capitalize on Peak Sales Periods**: Focus promotions and inventory around afternoons, especially on Saturdays, to maximize revenue.
   - **Boost Sales During Low Periods**: Implement targeted campaigns or discounts on Mondays to increase sales during slower periods.
   - **Optimize Branch Performance**:  Replicate the successful strategies of Branch A in other branches to improve overall sales.

### Product Strategies
   - **Enhance High-Performing Product Lines** : Invest in marketing and expanding the "Food and Beverages" line to further boost its already strong performance.
   - **Revitalize Underperforming Lines** : Reevaluate the "Health and Beauty" product line, considering new product introductions, pricing adjustments, or targeted promotions to improve sales.
   - **Leverage Product Ratings** : Promote highly-rated products, like those in the "Food and Beverages" line, to attract quality-conscious customers.

### Customer Strategies
   - **Strengthen Loyalty Programs** : Since members contribute significantly to revenue, enhancing loyalty programs and personalized offers will help retain these valuable customers.
   - **Gender-specific Marketing** : Tailor product offerings and marketing campaigns to the gender preferences observed in each branch, ensuring that each customer segment feels catered to.
   - **Encourage Feedback** : Foster customer engagement by encouraging feedback during peak times, such as afternoons, to gather valuable insights for continuous improvement.

## Future Scope
   - **Customer Segmentation**: Analyze demographic and behavioral data to identify key customer segments, enhancing targeted marketing strategies.
   - **Predictive Analytics**: Implement models for sales forecasting and churn prediction to anticipate future trends and retain customers effectively.
   - **Sentiment Analysis**: Integrate customer reviews to gauge sentiment trends, helping to understand customer satisfaction and product quality.








