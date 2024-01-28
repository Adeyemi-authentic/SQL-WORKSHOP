
create database product_sales;
use product_sales ;
create table customer(
cust_id int primary key auto_increment,
cust_name varchar(10),
email text ,joining_date date );
insert into customer(cust_name,email,joining_date)
values 
('sam','samb@emailcom','2022-01-15'),
('kim','kim@email.com','2022-02-20'),
('kane','kane@email.com','2022-03-25'),
('dave','dave@email.com','2022-04-10');

create table orders(order_id int,
cust_ref_id int,
order_date date,total_amount int,
foreign key(cust_ref_id)references customer(cust_id)
);

insert into orders(order_id,cust_ref_id,order_date,total_amount)
values
(101,1,'2022-04-01',100),
(102,2,'2022-04-05',75),
(103,1,'2022-04-10',45),
(104,3,'2022-05-20',150),
(105,2,'2022-05-05',65),
(106,4,'2022-05-10',200);


create table prod_tbl
(prod_id int ,prod_name varchar(20),
unit_price int 
);

insert into prod_tbl(prod_id,prod_name,unit_price)
values
(1,'laptop',800),
(2,'phone',400),
(3,'tablet',300),
(4,'headphones',50),
(5,'mouse',15),
(6,'keyboard',30);

select*from customer;
select*from orders;

select c.cust_id ,c.cust_name,joining_date,o.cust_ref_id,order_date,total_amount,order_id 
from customer c
join orders o 
on c.cust_id=o.cust_ref_id;

create view customer_orders as select c.cust_id ,c.cust_name,joining_date,o.cust_ref_id,order_date,total_amount,order_id 
from customer c
join orders o 
on c.cust_id=o.cust_ref_id;


drop view customer_orders;




-- retreieve the na,es of each customer who joined before 2022-03-25
select* from customer where joining_date<'2022-03-25';

-- 1. what is the total amount of  order made by kim --
select cust_id from customer where cust_name like 'kim';

select  cust_ref_id,sum(total_amount) as money_spent
from orders
group by cust_ref_id;

-- another method--
select*from customer_orders;

select sum(total_amount) from customer_orders
where cust_name='kim';

-- 2. list out every order made by kim --

select cust_id from customer where cust_name='kim';

select order_date,total_amount,order_id from orders
where cust_id= (select cust_id from customer where cust_name='kim');

-- OR--
SELECT TOTAL_AMOUNT,ORDER_ID FROM CUSTOMER_ORDERS;


-- 3. what is the average order amount for customers who joined before 2022-03-25 --
select avg(total_amount),order_date from orders
where order_date<'2022-03-25'
group by order_date;


-- 4. what is the total_revenue generated from orders placed in may 2022--
select sum(total_amount) from customer_orders where month(order_date)=05;

select sum(total_amount) from customer_orders where order_date>'2022-04-30' and  order_date<'2022-06-01';


-- 5. what is the total amount of order placed by customer who have spent more than 500 --
 select cust_id ,sum(total_amount) from customer_orders
 where total_amount =500 or total_amount>500
 group by cust_id;
 
 select*from customer_orders;
 --  6. retrieve the customer name who spent the most on  orders--
 select cust_ref_id,sum(total_amount) as money_spent from orders
 group by cust_ref_id ;
 
 select cust_ref_id,sum(total_amount) as money_spent from orders
 group by cust_ref_id 
 having money_spent =max(total_amount)
  ;

select cust_name from customer where
cust_id=( select cust_ref_id,sum(total_amount) as money_spent from orders
 group by cust_ref_id 
 having money_spent =max(total_amount));
 -- JTHIS DIDNT WORK --
 -- OR--
select cust_name from customer where
cust_id= 4;

-- 7.  retreieve the name of customer who spent the most on a single order --

 select cust_ref_id,count(order_date) as no_of_orders,sum(total_amount) as money_spent from orders
 group by cust_ref_id ;
 
 /*after getting the cust_ref_id we now search for the name attached to that id */
 select cust_name from customer where
cust_id= 4;

-- OR --

select cust_ref_id from orders
order by total_amount desc limit 1;
 
select cust_name from customer 
where cust_id =(select cust_ref_id from orders
order by total_amount desc limit 1);


-- 8. find the customers who didnt place any order in may 2022--

select  distinct cust_ref_id from orders
where order_date < '2022-05-01';

select cust_name from customer where cust_id in (select  distinct cust_ref_id from orders
where order_date  < '2022-05-01');


-- 9. get the names of all customers along with the total amount they spent 
-- ordered by the total amount from  highest to lowest --
select cust_ref_id ,sum(total_amount) as money_spent
from  orders 
group by cust_ref_id 
order by money_spent desc;

select cust_name from customer
where cust_id in (select cust_ref_id ,sum(total_amount) as money_spent
from  orders 
group by cust_ref_id 
order by money_spent desc);


-- or--
select cust_name,sum(total_amount) as money_spent
 from customer_orders
group by cust_name
order by money_spent desc;


