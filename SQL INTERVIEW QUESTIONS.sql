sql interview question 
## create a companys database 

create database company;
use company;
create table employee(
emp_id int primary key auto_increment,first_name varchar(20) not null,
last_name varchar(25) not null,
salary int not null, joining_date date not null,
department varchar(25) not null
);
insert into employee(emp_id,first_name,last_name,salary,joining_date,department)
values
(1001,'sam','greg',4500,'22-08-23','accouning'),
(1002,'kim','kay',6599,'22-12-21','medical'),
(1003,'snow','john',5000,'21-07-20','manager'),
(1004,'ray','draf',8500,'22-02-15','HR'),
(1005,'angela','white',5000,'19-09-16','secetary'),
(1006,'natash','nice',3400,'23-11-26','PR'),
(1007,'brown','kilm',9000,'24-01-10','salesman');

use company;
create table bonus(
emp_ref_id int not null,
bonus_date date not null,
bonus_amount int not null,
foreign key(emp_ref_id) references employee(emp_id)
on delete cascade
);

insert into bonus(emp_ref_id,bonus_date,bonus_amount)
values
(1001,'2022-10-25',1500),
(1002,'2023-11-26',500),
(1004,'2024-01-01',900),
(1006,'2023-12-29',8000);

create table emp_designation(
emp_ref_id int ,
designation varchar(30),
designation_date date, 
foreign key(emp_ref_id) references employee(emp_id)
);


insert into emp_designation(emp_ref_id,designation,designation_date)
values
(1001,'management','2024-06-22'),
(1006,'partnership','2024-02-13'),
(1003,'advertising','2024-09-25'),
(1004,'marketing','2024-03-22');

select* from emp_designation;
/*Q2 write an sql query to retrieve all detais where the firdt_name from the employee table starts
with k,s */

select*from EMPLOYEE where first_name like 'k%';
/* and i can write a query that shows any name that has the letter K in it (not only starts with the K)*/
SELECT* FROM EMPLOYEE WHERE FIRST_NAME LIKE '%S%';

/* Q3 write a qyery to print all the details of the employee whose salary is between 3000 and 6000
*/

select* from employee where salary between 3000 and 6000;

/*  ANOTHER METHOD */
select*from employee where salary<6500;


/*Q4  write an sql query to prit details of employee who also in marketing
*/

select* from employee;
select employee.emp_id,first_name,last_name,salary,designation 
from employee
inner join emp_designation 
on employee.emp_id=emp_designation.emp_ref_id where designation='marketing';

/* im gonna save the prior  query as a view cuz i miht need it again */

create view  employee_designation_table as
select employee.emp_id,first_name,last_name,salary,designation 
from employee
inner join emp_designation 
on employee.emp_id=emp_designation.emp_ref_id;

select* from employee_designation_table;

/* sql query to count employee in every depaartment*/

select count(*) from employee group by department;
select* from employee order by department;
/* write a query to show top salary earners */
select* from employee order by salary desc limit 5;

/* sql query to clone a new table from another table  */

create table clone_employee LIKE employee;
select* from clone_employee;
/* sql query to retrieve details of employee that joined the compNY ON JAN 2024  */

select* from employee where  year(joining_date)=2024 and month (joining_date)=1;

## to shoow employee that joining date was 2022 only ##

select* from employee where year (joining_date)=2022;



