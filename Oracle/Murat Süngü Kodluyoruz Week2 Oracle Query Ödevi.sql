--Kodluyoruz SQL W2 �devi
--Murat S�ng�

--Banking sorular� cevaplar� 
--***************************

--Y�l�n 4. aylar�nda en �ok hangi ama�la kredi �ekilmi�tir? ----Banking �emas� i�in
SELECT PURPOSE,COUNT(*) FROM LOANS WHERE MONTH=4 GROUP BY PURPOSE;

-- Bankan�n 50 ve ya 51 ya��nda kad�n m��terilerinden ayn� isme sahip olan m��terisi/m��terileri var m�? Varsa isimleri neler?----Banking �emas� i�in
select count(*),first from clients where age in (50,51) and sex='Female' group by first order by count(*) desc;

--Hangi y�llarda ka� hesap a��lm��t�r?----Banking �emas� i�in
select count(*),year from accounts group by year order by year;

-- ��lemlerin tiplerine g�re toplam say�lar�n�n b�y�kten k����e s�ralamas� nedir?----Banking �emas� i�in
select count(*),operation from transactions group by operation order by count(*) desc;

-- ��lemlerin tiplerine g�re toplam tutarlar�n�n b�y�kten k����e s�ralamas� nedir?----Banking �emas� i�in
select sum(amount),operation from transactions group by operation order by sum(amount) desc;



--Sales sorular� cevaplar� 
--***************************

-- Birim fiyat� 150'den b�y�k olan order_itemlar� bulunuz. ----Sales �emas� i�in
select * from order_items where unit_price>150;

-- ��e al�m tarihi May�s 2016 olan �al��anlar� bulunuz. ----Sales �emas� i�in
select * from employees where hire_date between '01.05.2016' and '31.05.2016';

-- Ad� Charlie ya da Charlsie olan contactlar� bulunuz. ----Sales �emas� i�in
select * from contacts where first_name in ('Charlie','Charlsie');

-- Adet say�s� 10dan b�y�k 50den k���k envanterleri bulunuz. ----Sales �emas� i�in
select * from inventories where quantity<50 and quantity>10;

-- Bir sipari�te toplam 100.0000'den fazla �cret �deyen emirler nedir? ----Sales �emas� i�in
select * from order_items where quantity*unit_price>100000;

-- Manager'� olmayan �al��anlar hangileridir? ----Sales �emas� i�in
select * from employeEs where manager_id IS NULL;

-- State bilgisi bo� olan lokasyonlar� bulunuz.----Sales �emas� i�in
select * from locations where state is null;

-- Durumu iptal olan ve sat�c�lar� olmayan emirler hangileridir? ----Sales �emas� i�in
select * from orders where status='Canceled' and salesman_id is null;

-- Ocak 2016 ile Haziran 2016 aras�nda verilen sipari�ler hangileridir? ----Sales �emas� i�in
select * from orders where order_date between '01.01.2016' and '30.06.2016';

-- Unvan� 'S' ile ba�lamayan �al��anlar� bulunuz. ----Sales �emas� i�in
select * from employeEs where job_t�tle not like 'S%' ;

-- Herhangi bir �e�it Intel Xeon �r�nler hangileridir? ----Sales �emas� i�in
select * from products where product_name like 'Intel Xeon%';

-- �smi 'C' ile ba�layan kontaklar hangileridir? Soyad�na g�re alfabetik s�ra ile s�ralayal�m. ----Sales �emas� i�in
select * from contacts where f�rst_name like 'C%' order by last_name;

-- �r�n ad� 'Asus' ile ba�layan ve liste fiyat� standart �cretinden k���k olan �r�nleri bulunuz. ----Sales �emas� i�in
select * from products where product_name like 'Asus%' and standard_cost>list_price ;

-- 1,2,4,5 id'li kategorilerin bilgilerini bulunuz. ----Sales �emas� i�in
select * from product_categories where category_�d in (1,2,3,4,5);

-- Sipari� durumu 'Shipped'den farkl� olan m��terilerin bilgilerini bulunuz. ----Sales �emas� i�in
select * from customers join orders on orders.status not like 'Shipped' ;

-- Adet say�s� 100e e�it olan envanterlerin product bilgisini bulunuz. ----Sales �emas� i�in
select * from products join inventories on quantity=100 ;

-- Beijing (8 numaral� warehouse)'da ka� farkl� envanter vard�r? ----Sales �emas� i�in
select count(*) from inventories join warehouses on warehouses.warehouse_id=8 ;

-- Liste fiyati 1000 ile 3000 arasinda olan ka� product var?----Sales �emas� i�in
select count(*) from products where list_price between 1000 and 3000;





--Telco sorular� cevaplar� 
--***************************

-- Kotas� limitsiz olan �r�nler hangileridir? ----Telco �emas� i�in
SELECT PRODUCT_NAME FROM PRODUCT WHERE QUOTA='LIMITLESS';

-- Stat�s� 'Initial' olan m��terileri bulunuz. ----Telco �emas� i�in
SELECT CUSTOMER_NUM,NAME,surname FROM CUSTOMER WHERE STATUS='INITIAL';

-- �ehir bilgisi 'ISTANBUL' olan adresleri bulunuz. ----Telco �emas� i�in
SELECT * FROM address WHERE CITY='Istanbul' or c�ty='Istanbu';

-- Birincil ileti�im bilgisi olmayan telefon numaralar�n� bulunuz. ----Telco �emas� i�in
select cnt_value from contact where is_primary=0 and cnt_type='PHONE';

-- Hesap �deme �ekli nakit olmayan hesaplar hangileridir? ----Telco �emas� i�in
SELECT * FROM ACCOUNT WHERE payment_type NOT IN ('CASH');

-- Stat�s� deaktif olan m��terilerin ba�lant� kesim tarihleri nedir? ----Telco �emas� i�in
SELECT DISCONNECTION_DATE FROM CUSTOMER WHERE STATUS='DEACTIVE' ;

-- Hesap kapan�� tarihi dolu olan hesaplar� bulunuz. ----Telco �emas� i�in
SELECT * FROM ACCOUNT WHERE account_clos�ng_date IS NOT NULL;

-- Elektronik fatura mail adresi (E_bill_email) olan hesaplar hangileridir? ----Telco �emas� i�in
SELECT * FROM ACCOUNT WHERE b�ll_presentat�on_type='EBILL' ;

-- S�zle�me biti� tarihi 1 Ocak 2000'den b�y�k , 1 Ocak 2005'ten k���k olan s�zle�meleri bulunuz. ----Telco �emas� i�in
SELECT * FROM AGREEMENT WHERE comm�tment_end_date BETWEEN '01.01.2000' AND '01.01.2005';

-- 2005 y�l�ndan �nce yap�lan ve hala aktif olan subscriptionlar hangileridir? ----Telco �emas� i�in
SELECT * FROM SUBSCRIPTION WHERE create_date<'01.01.2005' AND STATUS='ACTIVE';

-- S�zle�me ba�lang�� tarihi Ocak 2010'dan b�y�k olan s�zle�meleri bulunuz. ----Telco �emas� i�in
SELECT * FROM AGREEMENT WHERE comm�tment_start_date>'31.01.2010' ;

-- �smi E ile ba�layan m��terileri bulunuz. ----Telco �emas� i�in
SELECT * FROM CUSTOMER WHERE NAME LIKE 'E%' ;

-- Product tipi 'DSL' ile biten �r�nleri bulunuz. ----Telco �emas� i�in
SELECT * FROM PRODUCT WHERE PRODUCT_TYPE LIKE '%DSL';

-- �sminde ya da soyisminde '�' harfi ge�en m��teriler hangileridir? ----Telco �emas� i�in
SELECT * FROM CUSTOMER WHERE NAME LIKE '%�%' OR SURNAME LIKE '%�%' ;

-- �lke kodu UK ve AU olan adresleri bulunuz.----Telco �emas� i�in
SELECT * FROM ADDRESS WHERE country_cd IN ('UK','AU');

-- Taahh�t s�resi 240 ve 120 ay olan b�t�n s�zle�meleri bulmak istiyoruz.----Telco �emas� i�in
SELECT * FROM AGREEMENT WHERE comm�tment_durat�on IN ('120 MONTHS','240 MONTHS');

-- S�zle�me alt tipi MAIN olan ka� tane s�zle�me vard�r?----Telco �emas� i�in
SELECT COUNT(*) FROM AGREEMENT WHERE SUBTYPE='MAIN';

-- Deaktif m��terilerin say�s�n� bulunuz.----Telco �emas� i�in
SELECT COUNT(*) FROM CUSTOMER WHERE status='DEACTIVE';

-- �leti�im tipi olarak email ve statusu kullan�mda olan ka� m��teri var?----Telco �emas� i�in
SELECT * FROM CUSTOMER JOIN contact ON contact.cnt_type='EMAIL' AND customer.status='ACTIVE';

















