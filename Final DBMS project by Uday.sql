/*
 ******************************************************************************
 ***                                                                        ***
 ***             Program Created by Group 4                                 ***
 ***         ************************************                           ***
 ***         !!!   Uday Kumar Sah        (NP000097)      !!!                ***
 ***         !!!   Amar Bahadur Bogati   (NP000077)      !!!                ***
 ***		 !!!   Abhishek Negi         (NP000075)      !!!                ***
 ***			                                                            ***
 ***                Course        :- B.Sc(Hons) IT                          ***
 ***                Semester      :- 2nd                                    ***
 ***                Subject       :- DBMS                                   ***
 ***                Intake Code   :- NP1F1609IT                             ***
 ***				College Name  :- Load Buddha Education Foundation       ***
 ***				                 Maitidevi-Kathmandu Nepal              ***
 ***	            ASIA PACIFIC UNIVERSITY OF TECHNOLOGY AND INNOVATION    ***
 ***				                                                        ***
 ******************************************************************************
 */

/*create database*/

create database E_bookstore
/*use created database*/
drop database E_bookstore
use E_bookstore
/*Create a Publisher Details Table Command */

create table publisher_details(publisher_id int not null primary key, publisher_name varchar(50) not null, publisher_address varchar(50) not null,
 publisher_phone varchar(10) unique not null, publisher_country varchar(30) not null)
 
 /*For Insert Value of Publisher Details Table */
 insert into publisher_details values(101,'Saraswati Stationary','Kathmandu','9804810249','Nepal')
 insert into publisher_details values(102,'Janta Stationary','janakpur','9813151321','Nepal')
 insert into publisher_details values(103,'Mamta Stationary','janakpur','9813151322','India')
 insert into publisher_details values(104,'Legendry Stationary','janakpur','9813151323','Chaina')
 insert into publisher_details values(105,'Kabita Stationary','janakpur','9813151324','Nepal')

 /*For View publisher_details Table Command*/

select *from publisher_details

/*For a New Book Details Table Command*/

 create table newbook_details(book_id int primary key, publisher_id int, book_category varchar(10),book_name varchar(50), book_rate money,
 book_author varchar(30), ISBN varchar(13),send_date date,foreign key(publisher_id) references publisher_details(publisher_id))

  /*For Insert Value of newbook_details Table */

 insert into newbook_details values(153,101,'Comedy','funckey',205,'Devil cal','1324567563456','6/7/2017')
 insert into newbook_details values(154,102,'Comedy','laungher',400,'Kabita','1324567563457','5/8/2017')
 insert into newbook_details values(155,103,'Horror','Evilreturns',700,'Sakya','1324567563458','4/9/2017')
 insert into newbook_details values(156,104,'Horror','BloodEvils',500,'Levnin','1324567563459','3/10/2017')
 insert into newbook_details values(157,105,'Science','Enviroment',500,'Darline','1324567563451','2/11/2017')

 /*For View newbook_details Table Command*/

 select * from newbook_details

 /*For a Customer Details Table Command*/

create table customer_details(customer_id int not null primary key,customer_FirstName varchar(20),customer_LastName varchar(15),
customer_Address varchar(30),Customer_ContactNo varchar(10),book_id int, invoice_id int not null, quantity int,Is_member varchar(8),
foreign key(book_id) references newbook_details(book_id))

ALTER TABLE customer_details WITH CHECK 
ADD check ( 
    (Is_member = 'member') 
    OR 
    (Is_member = 'customer') 
) 

 /*For Insert Value of customer_details Table */

insert into customer_details values(501,'Uday','Sah','Jadibuti','9813151323',153,1050,4,'member')
insert into customer_details values(502,'Abhushan','Chautat','Koteshwor','9813161323',154,1051,5,'customer')
insert into customer_details values(503,'Ranjit','Shrestha','Maitidevi','9813171323',155,1052,3,'customer')
insert into customer_details values(504,'Amar','Bhogati','Kalopul','9813181323',156,1053,2,'member')
insert into customer_details values(505,'Abhishek','Negi','Balkumari','9813191323',157,1054,2,'member')


 /*For View customer_details Table Command*/

select *from customer_details

/*For a Book Details Table Command*/

create table book_details(book_id int, publisher_id int, quantity int,book_category varchar(10),
foreign key(publisher_id) references publisher_details(publisher_id), foreign key(book_id) references newbook_details(book_id))

 /*For Insert Value of book_details Table */

insert into book_details values(153,101,6,'Comedy')
insert into book_details values(154,102,9,'Comedy')
insert into book_details values(155,103,4,'Horror')
insert into book_details values(156,104,3,'Horror')
insert into book_details values(157,105,3,'Science')

 /*For View book_details Table Command*/

select *from book_details

/*For a New Send Order Details Table Command*/

create table sendorder_details(book_id int,publisher_id int,quantity int,order_date date,invoice_id int not null primary key,
 foreign key(book_id) references newbook_details(book_id),foreign key(publisher_id) references publisher_details(publisher_id))

  /*For Insert Value of sendorder_details Table */

insert into sendorder_details values(153,'101','6','6/7/2017','1050')
insert into sendorder_details values(154,'102','9','5/8/2017','1051')
insert into sendorder_details values(155,'103','4','4/9/2017','1052')
insert into sendorder_details values(156,'104','3','3/10/2017','1053')
insert into sendorder_details values(157,'105','3','2/11/2017','1054')

 /*For View sendorder_details Table Command*/

select *from sendorder_details


/*For a Bill Details Table Command*/

create table bill_details(invoice_id int,publisher_id int,invoice_date date,Is_paid varchar(6),
 foreign key(invoice_id) references sendorder_details(invoice_id),foreign key(publisher_id) references publisher_details(publisher_id))

ALTER TABLE bill_details WITH CHECK 
ADD check ( 
    (Is_paid = 'paid') 
    OR 
    (Is_paid = 'unpaid') 
) 

 /*For Insert Value of bill_details Table */

 insert into bill_details values(1050,101,'6/7/2017','paid')
 insert into bill_details values(1051,102,'5/8/2017','unpaid')
 insert into bill_details values(1052,103,'4/9/2017','paid')
 insert into bill_details values(1053,104,'3/10/2017','paid')
 insert into bill_details values(1054,105,'2/11/2017','unpaid')


  /*For View bill_details Table Command*/

select *from bill_details

/*For a Sales information Table Command*/

create table sales_information(transaction_id int , invoice_id int, transaction_date date not null,
  Is_paid varchar(6) not null, payment_type varchar(4) not null,
  foreign key(invoice_id) references sendorder_details(invoice_id))

ALTER TABLE sales_information WITH CHECK 
ADD check ( 
    (Is_paid = 'paid') 
    OR 
    (Is_paid = 'unpaid') 
) 
ALTER TABLE sales_information WITH CHECK 
ADD check ( 
    (payment_type= 'visa') 
    OR 
    (payment_type= 'cash') 
)

 /*For Insert Value of sales_information Table */

insert into sales_information values(789,1050,'6/07/2017','paid','visa')
insert into sales_information values(790,1051,'5/06/2017','paid','visa')
insert into sales_information values(791,1052,'4/05/2017','paid','visa')
insert into sales_information values(792,1053,'3/04/2017','unpaid','cash')
insert into sales_information values(793,1054,'2/03/2017','unpaid','cash')


 /*For View sales_information Table Command*/

select *from sales_information


/*For a Delivery information Table Command*/

create table delivery_information(book_id int, customer_id int,quantity int,export_date date not null,
 export_status varchar(3), foreign key(book_id) references newbook_details(book_id),
 foreign key(customer_id) references customer_details(customer_id))

ALTER TABLE delivery_information WITH CHECK 
ADD check ( 
    (export_status='yes') 
    OR 
    (export_status='no') 
)

 /*For Insert Value of delivery_information Table */

insert into delivery_information values(153,501,4,'6/7/2017','yes')
insert into delivery_information values(154,502,5,'5/8/2017','yes')
insert into delivery_information values(155,503,3,'4/9/2017','no')
insert into delivery_information values(156,504,2,'3/10/2017','yes')
insert into delivery_information values(156,505,2,'2/11/2017','no')

 /*For View delivery_information Table Command*/

select *from delivery_information

/*For a opinion Details Table Command*/

create table opinion(customer_id int, book_id int, feedback varchar(200), rating varchar(2),
feedback_date date,foreign key(book_id) references newbook_details(book_id),
 foreign key(customer_id) references customer_details(customer_id))

 ALTER TABLE opinion WITH CHECK 
ADD check ( 
    (rating > 1) 
    OR 
    (rating >= 10) 
) 

 /*For Insert Value of opinion Details Table */

 insert into opinion values(501,153,'this is great book','8','6/7/2017')
 insert into opinion values(502,154,'this is nice book','5','5/8/2017')
 insert into opinion values(503,155,'this is good book','3','4/9/2017')
 insert into opinion values(504,156,'this is marvalus book','4','3/10/2017')
insert into  opinion values(505,157,'this is horror book','4','2/11/2017')

 /*For View opinion Table Command*/

select *from opinion

 /*For View Table Command*/

select *from publisher_details
select *from book_details
select *from newbook_details
select *from sendorder_details
select *from bill_details
select *from delivery_information
select *from customer_details
select *from sales_information
select *from opinion

/*For view Tables Details Command */
sp_help publisher_details
sp_help book_details
sp_help newbook_details
sp_help sendorder_details
sp_help bill_details
sp_help delivery_information
sp_help customer_details
sp_help sales_information
sp_help opinion

/* Question 1*/

select publisher_details.publisher_id,newbook_details.book_id,book_name,month=datename(MONTH,send_date)
from publisher_details,newbook_details where publisher_details.publisher_id=newbook_details.publisher_id

/*Question 2*/

select sendorder_details.publisher_id,publisher_details.publisher_name,newbook_details.book_id,
newbook_details.book_name,sendorder_details.quantity,newbook_details.book_rate,
sendorder_details.invoice_id,month=datename(MONTH,sendorder_details.order_date)
from sendorder_details
inner join newbook_details on sendorder_details.book_id=newbook_details.book_id
inner join publisher_details on sendorder_details.book_id=publisher_details.publisher_id

/*Question 3*/

select bill_details.invoice_id,bill_details.invoice_date,
publisher_details.publisher_name,publisher_details.publisher_address,
totalamount=(sendorder_details.quantity* newbook_details.book_rate)
from bill_details
inner join publisher_details on bill_details.publisher_id=publisher_details.publisher_id
inner join sendorder_details on sendorder_details.invoice_id=bill_details.invoice_id
inner join newbook_details on newbook_details.book_id=sendorder_details.book_id
where Is_paid='unpaid'

/*Question 4*/

select customer_id,customer_FirstName,customer_LastName,customer_address,
customer_ContactNo from customer_details where Is_member="Is_member"

/*Question 5*/

select delivery_information.customer_id,customer_details.customer_FirstName,customer_LastName,
customer_address,customer_ContactNo,delivery_information.book_id,newbook_details.book_name,delivery_information.export_date,
delivery_information.export_status
from customer_details
inner join delivery_information on customer_details.customer_id=delivery_information.customer_id
inner join newbook_details on delivery_information.book_id=newbook_details.book_id
where export_status="export_status"

/* Question 6*/

select newbook_details.book_category,sendorder_details.book_id,newbook_details.book_name,sendorder_details.quantity
from sendorder_details
inner join newbook_details on sendorder_details.book_id=newbook_details.book_id
where book_category='horror'

/*Question 7*/

select newbook_details.book_category,count(*) as TotalNo_of_Books from newbook_details 
 where book_id in (select distinct book_id from bill_details)group by newbook_details.book_category

/*Question 8*/

select SUM(sendorder_details.quantity) as TotalBooks,sum(sendorder_details.quantity*book_rate) as TotalPrice
from sendorder_details join newbook_details on newbook_details.book_id=sendorder_details.book_id

/*Question 9*/

select opinion.book_id,newbook_details.book_name,opinion.rating from opinion,book_details where opinion.book_id=book_details.book_id
order by rating asc
