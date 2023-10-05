create database Unit;
use Unit;

create table Worker(Worker_ID int primary key,
First_Name varchar(20),
Last_Name varchar(20),
Salary int,
Joining_Date varchar(20),
Department varchar(20));

insert into Worker(Worker_ID, First_Name, Last_Name, Salary, Joining_Date, Department)
values 
(1, 'Monika', 'Arora', 100000, '2/20/2014 9:00', 'HR'),
(2, 'Niharika', 'Verma', 80000, '6/11/2014 9:00', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2/20/2014 9:00', 'HR'),
(4, 'Amitabh', 'Singh', 500000, '2/20/2014 9:00', 'Admin'),
(5, 'Vivek', 'Bhati', 500000, '6/11/2014 9:00', 'Admin'),
(6, 'Vipul', 'Diwan', 200000, '6/11/2014 9:00', 'Account'),
(7, 'Satish', 'Kumar', 75000, '1/20/2014 9:00', 'Account'),
(8, 'Geetika', 'Chauhan', 90000, '4/11/2014 9:00', 'Admin');

-- Question 1 -- 
select*from Worker order by First_Name asc;
select*from Worker order by Department desc;
 
-- Question 2 -- 
select*from Worker where First_Name = 'Vipul' or First_Name = 'Satish';

-- Question 3 -- 
select*from Worker
where First_Name like '_____h';

-- Question 4 --  
select*from Worker
where Salary between 100000 and 500000;

-- Question 5 --
select Joining_Date, Department, count(*) as Duplicates from Worker group by Joining_Date, Department having Count(*)>1;

-- Question 6 --
select* from Worker limit 6;

-- Question 7 -- 
select Department from Worker group by Department having count(Worker_ID)<5;

-- Question 8 --
select Department, count(Worker_ID) as People from Worker group by Department;

-- Question 9 --
select First_Name, Department
from Worker
where Salary in (select MAX(Salary) from Worker group by Department);


create database School;
use School;

create table STUDENT(StdID int primary key,
StdName varchar(20),
Sex varchar(10),
Percentage int,
Class int,
Sec varchar(10),
Stream varchar(10),
DOB varchar(20));

insert into STUDENT(StdID, StdName, Sex, Percentage, Class, Sec, Stream, DOB)
values
(1001, 'Surekha Joshi', 'Female', 82, 12, 'A', 'Science', '3/8/1998'),
(1002, 'MAAHI AGARWAL', 'Female', 56, 11, 'C', 'Commerce', '11/23/2008'),
(1003, 'Sanam Verma', 'Male', 59, 12, 'C', 'Commerce', '6/29/2006'),
(1004, 'Ronit Kumar', 'Male', 63, 11, 'C', 'Commerce', '11/5/1997'),
(1005, 'Dipesh Pulkit', 'Male', 78, 11, 'B', 'Science', '14/9/2003'),
(1006, 'JAHANVI Puri', 'Female', 60, 11, 'B', 'Commerce', '11/7/2008'),
(1007, 'Sanam Kumar', 'Male', 23, 12, 'F', 'Commerce', '3/8/1998'),
(1008, 'SAHIL SARAS', 'Male', 56, 11, 'C', 'Commerce', '11/7/2008'),
(1009, 'AKSHRA AGRAWAL', 'Female', 72, 12, 'B', 'Commerce', '10/1/1996'),
(1010, 'STUTI MISHRA', 'Female', 39, 11, 'F', 'Science', '11/23/2008'),
(1011, 'HARSH AGRAWAL', 'Male', 42, 11, 'C', 'Science', '3/8/1998'),
(1012, 'NIKUNJ AGRAWAL', 'Male', 49, 12, 'C', 'Commerce', '28/06/1998'),
(1013, 'AKRITI SAXENA', 'Female', 89, 12, 'A', 'Science', '11/23/2008'),
(1014, 'TANI RASTOGI', 'Female', 82, 12, 'A', 'Science', '11/23/2008');

-- 1. --
select*from STUDENT;

-- 2. --
select StdName, DOB from STUDENT;

-- 3. --
select*from STUDENT where Percentage>=80;

-- 4. --
select StdName, Stream, Percentage from STUDENT where Percentage > 80;

-- 5. --
Select*from STUDENT where Stream = 'Science' and Percentage > 75;