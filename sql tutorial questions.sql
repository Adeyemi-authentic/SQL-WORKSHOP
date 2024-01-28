create database sql_prep;
use sql_prep;
create table worker(
worker_id int auto_increment,
primary key(worker_id),first_name varchar(20) not null,
last_name varchar(20) not  null ,salary int,
joining_date date,department varchar(20)
);

insert into worker(worker_id,first_name,last_name,salary,joining_date,department)
values
(001,'monika','arora',1000,'2021-02-20 09:00:00','HR'),
(002,'niharika','verma',3200,'2021-06-11 09:00:00','admin'),
(003,'vivek','bati',50000,'2021-06-11 09:00:00','account'),
(004,'satish','kumar',7500,'2021-01-20 09:00:00','admin');

create table bonus(
worker_ref_id int ,
bonus_date date,
bonus_amount int,
foreign key (worker_ref_id) references worker(worker_id)
);

insert into bonus(worker_ref_id,bonus_date,bonus_amount)
values
(001,'2023-02-20',2000),
(003,'2023-06-11',1200),
(004,'2023-06-11',4500);

create table title (
worker_ref_id int,worker_title varchar(20)
,affected_from varchar(30),
foreign key(worker_ref_id) references worker(worker_id)
);


insert into title(worker_ref_id,worker_title,affected_from)
values
(001,'manager',2023-02-20),
(002,'executive',2023-06-11);


-- 1.write a query to fetch the first name from the table using allias name worker name--

select first_name as worker_name from worker;

-- 2. write a query to fetch the firstname in upper case--

select upper(first_name) from worker;

-- 3.write query to fetch unique value of department from the worker table--
select distinct department from worker;

-- 4. write an sql query to print the first three character of the first name from the worker table-- 
select substring(first_name,1,3) from worker;

-- 5. write a query to find the position of the alphabet v in the first name column vivek from the worker table--
select instr(first_name,'v')
from worker where first_name='vivek';

-- 6. write a query that fetches the unique values of department from the worker and print its length--
select distinct length(department) from worker;

-- 7.write a query to print the first name from the worker table after replacing 'a' with 'A'

select  replace(FIRST_NAME,'a','A') FROM WORKER;


-- 8. write a query to print the first name and last namefrom the worker table into a single column complete name--
select concat(first_name,' ',last_name) as complete_name from worker ;

-- 9. write a query to print all worker details order by first name ascending--

select*from worker
order by first_name asc;

-- 10.write an sql query to print all details from worker order by firstname ascending and department descending
select* from worker 
order by first_name asc ,department desc;

-- 11. write a query to print all worker whose firstname ends with 'k' and contain five letter--
select*from worker where first_name like '____k';
-- note each underscore represent an alphabet count--

-- 12. write a query to fetch the count of employees in the admin department--

select count(*) from worker where department='admin';

-- 13. write a query to fetch the counts of employees working in the department 'admin'--
select count(*) from worker where department='admin';

-- 14. write an Sql query to fetch worker full names with salaries >=5000and <=7000--

select concat(first_name,' ',last_name) as full_names from worker;

select concat(first_name,' ',last_name) as full_names,salary from worker 
where salary between 5000 and 7000;

-- 15.write an sql query to fetch the number of workers for each department in descending order--

select department,count(worker_id) as total_count from worker
group by department
order by total_count desc;

-- 16. write a query to print details of the workers who are admin --

select worker_id,first_name,last_name,department
from worker where department='admin';

-- 17. write a query to show current date and time 

select curdate();
/*another method*/
select now();

-- 18.select to fetch the last record from a table --

select max(worker_id)from worker;

select*from worker where worker_id=(select max(worker_id)from worker);

