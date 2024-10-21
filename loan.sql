create database loan;
use loan;
CREATE TABLE loan_card_master
(
loan_id varchar(6) PRIMARY KEY,
loan_type varchar(15),
duration_in_years int(2)
);
CREATE TABLE employee_master
(
employee_id varchar(6) PRIMARY KEY,
employee_name varchar(20),
designation varchar(25),
department varchar(25),
gender char(1),
date_of_birth date,
date_of_joining date
);
CREATE TABLE item_master
(
item_id varchar(6) PRIMARY KEY,
item_description varchar(25),
issue_status char(1),
item_make varchar(25),
item_category varchar(20),
item_valuation int(6)
);
CREATE TABLE employee_card_details
(
employee_id varchar(6) REFERENCES employee_master,
loan_id varchar(6) REFERENCES loan_card_master,
card_issue_date date
);
CREATE TABLE employee_issue_details
(
issue_id varchar(6) PRIMARY KEY,
employee_id varchar(6) REFERENCES employee_master,
item_id varchar(6) REFERENCES item_master,
issue_date date,
return_date date
);

insert into loan_card_master values('L00001','Furniture',5);
insert into loan_card_master values('L00002','Stationary',0);
insert into loan_card_master values('L00003','Crockery',1);

insert into employee_issue_details values('ISS001','E00001','I00001','2012-02-03','2014-02-03');
insert into employee_issue_details values('ISS002','E00001','I00004','2012-02-03','2020-02-03');
insert into employee_issue_details values('ISS003','E00002','I00005','2013-01-03','2015-01-03');
insert into employee_issue_details values('ISS004','E00003','I00007','2010-07-04','2012-07-04');
insert into employee_issue_details values('ISS005','E00003','I00008','2010-07-04','2012-08-05');
insert into employee_issue_details values('ISS006','E00003','I00010','2012-03-14','2012-06-15');
insert into employee_issue_details values('ISS007','E00004','I00012','2013-04-14','2016-04-14');
insert into employee_issue_details values('ISS008','E00006','I00018','2012-08-18','2019-04-17');
insert into employee_issue_details values('ISS009','E00004','I00018','2013-04-18','2013-05-18');

insert into employee_master values('E00001','Ram','Manager','Finance','M','1973-12-01','2000-01-01');
insert into employee_master values('E00002','Abhay','Assistant Manager','Finance','M','1976-01-01','2006-12-01');
insert into employee_master values('E00003','Anita','Senior Executive','Marketing','F','1977-05-12','2007-03-21');
insert into employee_master values('E00004','Zuben','Manager','Marketing','M','1974-10-12','2003-07-23');
insert into employee_master values('E00005','Radhica','Manager','HR','F','1976-07-22','2004-01-23');
insert into employee_master values('E00006','John','Executive','HR','M','1983-11-08','2010-05-17');

insert into employee_card_details values('E00001','L00001','2000-01-01');
insert into employee_card_details values('E00001','L00002','2000-01-01');
insert into employee_card_details values('E00001','L00003','2002-12-14');
insert into employee_card_details values('E00002','L00001','2007-02-01');
insert into employee_card_details values('E00002','L00002','2007-03-11');
insert into employee_card_details values('E00003','L00001','2007-04-15');
insert into employee_card_details values('E00003','L00002','2007-04-15');
insert into employee_card_details values('E00003','L00003','2007-04-15');

INSERT INTO item_master VALUES ('I00001','Tea Table','Y','Wooden','Furniture',5000);
INSERT INTO item_master VALUES ('I00002','Dinning Table','N','Wooden','Furniture',15000);
INSERT INTO item_master VALUES ('I00003','Tea Table','N','Steel','Furniture',6000);
INSERT INTO item_master VALUES ('I00004','Side Table','Y','Wooden','Furniture',2000);
INSERT INTO item_master VALUES ('I00005','Side Table','Y','Steel','Furniture',1500);
INSERT INTO item_master VALUES ('I00006','Tea Table','N','Steel','Furniture',7000);
INSERT INTO item_master VALUES ('I00007','Dinning Chair','Y','Wooden','Furniture',1500);
INSERT INTO item_master VALUES ('I00008','Tea Table','Y','Wooden','Furniture',4000);
INSERT INTO item_master VALUES ('I00009','Sofa','N','Wooden','Furniture',18000);
INSERT INTO item_master VALUES ('I00010','Cupboard','Y','Steel','Furniture',10000);
INSERT INTO item_master VALUES ('I00011','Cupboard','N','Steel','Furniture',14000);
INSERT INTO item_master VALUES ('I00012','Double Bed','Y','Wooden','Furniture',21000);
INSERT INTO item_master VALUES ('I00013','Double Bed','Y','Wooden','Furniture',20000);
INSERT INTO item_master VALUES ('I00014','Single Bed','Y','Steel','Furniture',10000);
INSERT INTO item_master VALUES ('I00015','Single Bed','N','Steel','Furniture',10000);
INSERT INTO item_master VALUES ('I00016','Tea Set','Y','Glass','Crockery',3000);
INSERT INTO item_master VALUES ('I00017','Tea Set','Y','Bonechina','Crockery',4000);
INSERT INTO item_master VALUES ('I00018','Dinning Set','Y','Glass','Crockery',4500);
INSERT INTO item_master VALUES ('I00019','Dinning Set','N','Bonechina','Crockery',5000);
INSERT INTO item_master VALUES ('I00020','Pencil','Y','Wooden','Stationary',5);
INSERT INTO item_master VALUES ('I00021','Pen','Y','Plastic','Stationary',100);
INSERT INTO item_master VALUES ('I00022','Pen','N','Plastic','Stationary',200);

select item_category, count(item_id) as Count_category from item_master
group by item_category
order by Count_category desc;

select count(*) as No_of_employee from employee_master
where department = 'HR';

select m.employee_id,m.employee_name,m.designation,m.department from employee_master m
left join employee_issue_details d using (employee_id)
where d.issue_id is null
order by m.employee_id;

select employee_id,employee_name from employee_master
where employee_id in (select employee_id from employee_issue_details
where item_id in (select item_id from item_master
where item_valuation = (select max(item_valuation) from item_master
join employee_issue_details using (item_id))));

select i.issue_id,e.employee_id,e.employee_name from employee_master e
join employee_issue_details i using (employee_id)
order by i.issue_id;

select employee_id,employee_name from employee_master
where employee_id not in (select employee_id from employee_card_details)
order by employee_id;

select count(c.employee_id) as No_of_Cards from employee_card_details c
left join employee_master m using (employee_id)
where m.employee_name like "Ram";

select count(employee_id) as Count_Stationary from employee_card_details
where loan_id in (select loan_id from loan_card_master where loan_type = "stationary");

select i.employee_id,m.employee_name,count(i.employee_id) as Count from employee_issue_details i
join employee_master m using (employee_id)
group by i.employee_id
order by Count desc;

select employee_id,employee_name from employee_master
where employee_id in (select employee_id from employee_issue_details
where item_id in (select item_id from item_master
where item_valuation=(select min(item_valuation) from item_master
join employee_issue_details using (item_id))));

select i.employee_id,e.employee_name,sum(m.item_valuation) from employee_master e
right join employee_issue_details i using (employee_id)
join item_master m using (item_id)
group by i.employee_id;

select distinct i.employee_id,m.employee_name from employee_issue_details i
join employee_master m using (employee_id)
where datediff(return_date,issue_date)>365
order by i.employee_id;

select d.employee_id,m.employee_name, count(d.item_id) as Count_Item from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
where i.item_category = "furniture"
group by d.employee_id
having Count_Item>1
order by d.employee_id;

select gender, count(*) from employee_master
group by gender;

select employee_id, employee_name from employee_master
where year(date_of_joining)>2005
order by employee_id;

select item_category, item_make, item_description, count(item_id) from item_master
group by item_category, item_make, item_description
order by item_category, item_make, item_description;

select d.employee_id,m.employee_name,d.item_id,i.item_description from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
where month(d.issue_date)=1 and year(d.issue_date)=2013
order by d.employee_id,d.item_id;

select d.employee_id,m.employee_name,count(distinct i.item_category) as Count_Category from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
group by d.employee_id
having Count_Category>1
order by d.employee_id;

select item_id,item_description from item_master
where item_id not in (select item_id from employee_issue_details)
order by item_id;

select d.employee_id,m.employee_name,sum(i.item_valuation) as Total_Valuation from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
group by d.employee_id
having sum(i.item_valuation)<= all (select sum(i.item_valuation) from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
group by d.employee_id);

select e.employee_id,m.employee_name,e.card_issue_date,
case
	when l.duration_in_years>0 then date_add(e.card_issue_date,interval l.duration_in_years year)
    when l.duration_in_years=0 then "No Validity Date"
end as CARD_VALID_DATE from employee_master m
join employee_card_details e using (employee_id)
join loan_card_master l using (loan_id)
order by m.employee_name, CARD_VALID_DATE;

select distinct m.employee_id,m.employee_name from employee_master m
join employee_issue_details i using (employee_id)
where m.employee_id not in (select employee_id from employee_issue_details where year(issue_date)=2013)
order by m.employee_id;

select d.employee_id,m.employee_name,sum(i.item_valuation) from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
group by d.employee_id
having sum(i.item_valuation)>=all(select sum(i.item_valuation) from employee_master m
join employee_issue_details d using (employee_id)
join item_master i using (item_id)
group by d.employee_id);