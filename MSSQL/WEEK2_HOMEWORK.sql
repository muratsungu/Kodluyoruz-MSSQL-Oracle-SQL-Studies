
-- �devimiz bir E-ticaret sitesi i�in basit bir db olu�turmakt�. �ncelikle database olu�turuyoruz;

CREATE DATABASE ECOMMERCE;

-- Sonras�nda i�erisine 5 adet tablo tan�mlamam�z istendi. �stenen tablolar a�a��daki gibidir;
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE customers(
	customer_id int primary key identity,
	customer_name varchar(50) not null,
	customer_surname varchar(50)not null,
	gender varchar(5) null,
	job varchar(50) null,
	birthdate date not null);

CREATE TABLE items(
	item_id int primary key identity,
	item_name varchar(150) not null,
	item_code varchar(50) not null,
	brand varchar(100)  null,
	category1 varchar(100) not null,
	category2 varchar(100)not null,
	price float not null);

CREATE TABLE addresses(
	id int primary key,
	customer_id int not null,
	city varchar(50) not null,
	district varchar(100) not null,
	address1 varchar(250) not null,
	address2 varchar(250) null,
	zip_code int null,
	constraint fk_cust_addr foreign key (customer_id) references customers(customer_id));
	--Veri b�t�nl��� i�in m��teriler tablosunu adres tablosuna ba�l�yoruz. 

CREATE TABLE orders(
order_id int primary key,
ficheno varchar(50) not null,
date_ date not null,
item_id int not null,
amount float not null,
price float not null,
total_price float not null,
customer_id int not null,
address_id int not null,
constraint fk_item_orders foreign key (item_id) references items(item_id),
constraint fk_cust_orders foreign key (customer_id) references customers(customer_id),
constraint fk_addr_orders foreign key (address_id) references addresses(id));
--Yine veri b�t�nl��� i�in sipari�ler tablomuzu �r�nler, m��teriler ve adresler tablolar�n� ba�lad�m.

CREATE TABLE order_status(
	id int primary key,
	order_id int not null,
	order_status int not null, --3 adet sipari� durumu varsa 0,1,2 �eklinde daha az yer kaplayan veriyle okutabiliriz.
	order_status_text varchar(50) not null,
	constraint fk_order_status foreign key (order_id) references orders(order_id));

-------------------------------------------------------------------------------------------------------------------------
--Tablolar�m�z� s�raki gibi tan�mlad�k. �imdi i�imize yarabileyece�ini d���nd���m 2 adet View tan�mlad�m.

-- M�hendis olan m��terilerimizi g�rmek i�in view olu�turdum.
CREATE VIEW customer_engineer as
select * from customers
where job like '%Engineer%';

--�temler i�inden �lker marka olanlar� getiren view olu�turdum.
CREATE VIEW ulker_items as 
select * from items
where brand like '%�lker%';

-------------------------------------------------------------------------------------------------------------------------
--�rnek viewleri de olu�turduktan sonra 2 adet store procedure olu�turdum.

-- �ehirlerin ciro s�ralamas�n� getiren procedure
CREATE PROCEDURE sehir_siralamasi as
select addresses.city as city, orders.sum(total_price) as ciro from addresses 
inner join orders on orders.address_id = addresses.id;

--Kargoda olan sipari�leri getiren procedure
CREATE PROCEDURE kargoda_olan as
select * from order_status
where order_status_text = 'Kargoya verildi.' ;


