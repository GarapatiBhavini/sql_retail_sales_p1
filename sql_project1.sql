create database retailsales_tb;
--
create table retailsales_tb(
       transactions_id int,	
	   sale_date date,	
	   sale_time time,	
	   customer_id	int,
	   gender varchar(15),	
	   age	varchar(15)
	   category	int,
	   quantiy	int,
	   price_per_unit  float,
	   cogs	float,
	   total_sale float,

)
--
select * from retailsales_tb;
--

select * from retailsales_tb
where sale_date is null;
--
select * from retailsales_tb
where sale_time is null;
--
select * from retailsales_tb
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 cogs is null
	 or
	 total_sale is null;

delete from retailsales_tb
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 cogs is null
	 or
	 total_sale is null;
--data exploration

--how many sales we have

select count(*) from retailsales_tb;
--
select count(*) as total_sale from retailsales_tb;
--
select count(distinct customer_id) from retailsales_tb;

--data analysis & business key problems
--
--1.write a sql query to retrieve all the columns for sales made on  '2022-11-05'

select * from retailsales_tb 
where sale_date = '2022-11-05';

--2.write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4
--in the month of nov-2022
select * from retailsales_tb
where category = 'Clothing' and to_char(sale_date , 'YYYY-MM') = '2022-11' and quantiy >= 4;

--3.write a sql query to calculate the total sales from each category

select category,sum(total_sale) from retailsales_tb
group by category;

--4.write a sql query to find the average age of customers who purchased items from the 'Beauty' category

select round(avg(age),2) from retailsales_tb
where category = 'Beauty';

--5.write a sql query to find all transactions where the total_sale is greater than 1000

select transactions_id from retailsales_tb
where total_sale > 1000;

--6.write a sql query to find the total number of transactions(transactions_id) made by each gender in each category

select count(*),gender,category from retailsales_tb
group by gender,category;

--7.write a sql query to calculate the average sale for each month.find out best selling month in each year

select YEAR,MONTH,avg_sale from (
select extract(YEAR from sale_date) as YEAR,
       extract(MONTH from sale_date) as month,
	   avg(total_sale) as avg_sale,
	   rank() over(PARTITION BY extract(YEAR from sale_date) order by avg(total_sale) desc ) from retailsales_tb
group by 1,2
) as t1
where rank =1;

--8.write a sql query to find the top 5 customers based on the highest total sale
select customer_id,sum(total_sale) from retailsales_tb
group by 1
order by 2 desc
limit 5;

--9.write a sql query to find the number of unique customers who purchased items from each category
select count(distinct customer_id),category from retailsales_tb
group by category;

--10.write an sql query to create an shift and number of orders

with hourly_sale
as
(
select *,
      case 
	  when extract(hour from sale_time) < 12 then 'Morning'
	  when extract(hour from sale_time)  between 12 and 17 then 'afternoon'
	  else 'Evening'
	  end as shift from retailsales_tb
)
select shift ,count(*) from hourly_sale
group by 1;

--end of project
	  

	   


