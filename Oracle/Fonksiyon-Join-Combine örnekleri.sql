
/* ####### JOIN �RNEKLER� ####### */

--�RNEK 1 Yay�nc� firmalar�n ��kard��� oyun say�s� s�ralamas�
select p.publisher_name,count(gl.game_id) as sayi from gamelist.game_list gl
inner join gamelist.publisher p on p.publisher_id= gl.publisher_id
group by p.publisher_name
order by count(gl.game_id) desc;

--�RNEK 2 Hangi platformda ka� adet oyun ��km��?
select p.platform_name,count(gl.game_id) from gamelist.platform p
inner join gamelist.platform_game_connection pgc on p.platform_id=pgc.platform_id
inner join gamelist.game_list gl on gl.game_id=pgc.game_id
group by p.platform_name;
--order by count(gl.game_id) desc;              istersek bu komutla s�ral� g�rebiliriz.

--�RNEK 3 Hangi oyunlar en �ok platforma ��km��?
select g.game_name,count(pgc.platform_id) from gamelist.game_list g
right join gamelist.platform_game_connection pgc 
on g.game_id=pgc.game_id
left join gamelist.platform p 
on p.platform_id=pgc.platform_id
group by g.game_name
order by count(pgc.platform_id) desc;

--�RNEK 4 Hangi platformda hangi yay�nc� firmalar oyun ��karm��?
select distinct p.platform_name,pu.publisher_name from gamelist.platform p 
inner join gamelist.platform_game_connection pgc 
on pgc.platform_id=p.platform_id
inner join gamelist.game_list g
on g.game_id=pgc.game_id
inner join gamelist.publisher pu 
on pu.publisher_id=g.publisher_id
order by p.platform_name,pu.publisher_name;

/* ####### COMBINE �RNEKLER� ####### */

--�RNEK 1  Union ile �a��r�nca oyun say�s� kadar id geliyor. Union all dedi�imizde �oklayan de�erler de geliyor
SELECT GAME_ID FROM GAMELIST.GAME_LIST
UNION ALL
SELECT GAME_ID FROM GAMELIST.PLATFORM_GAME_CONNECTION ORDER BY GAME_ID;

SELECT GAME_ID FROM GAMELIST.GAME_LIST
UNION 
SELECT GAME_ID FROM GAMELIST.PLATFORM_GAME_CONNECTION ORDER BY GAME_ID;

--�RNEK 2  �leti�im numaras� oldu�u halde m��teriler tablosunda olmayan ki�iler;
select customer_id from SALES.contacts
minus
select customer_id from sales.customers;

--�RNEK 3  Mobil kategorisi d���nda yay�nlanan oyunlar�n listesi;
select g.game_name,p.platform_name from gamelist.platform_game_connection pgc
left join gamelist.platform p on p.platform_id=pgc.platform_id
inner join gamelist.game_list g on g.game_id=pgc.game_id
minus
select g.game_name,p.platform_name from gamelist.platform_game_connection pgc
left join gamelist.platform p on p.platform_id=pgc.platform_id
inner join gamelist.game_list g on g.game_id=pgc.game_id
where p.category ='MOBILE';

--�RNEK 4  Haziran 2020'den �nce ��km�� ve Spor veya Aksiyon t�rlerinde ��km�� oyunlar�n kesi�imi;

select  game_name,release_date,genre from gamelist.game_list
where genre='Sports' or genre='Action'
�ntersect
select game_name,release_date,genre from gamelist.game_list
where release_date < '30.06.2020';


/* ####### FONKS�YON �RNEKLER� ####### */

--�RNEK 1  �smi 10 harften k�sa olan oyunlar
SELECT * FROM GAMELIST.GAME_LIST WHERE LENGTH(GAME_NAME ) <10;

--�RNEK 2  Genre2 ve genre3 s�tunlar�ndaki de�erlerin ba�lang�c�ndan bo�luk vard�. Bo�lu�u kald�rmak i�in 
--(trim �al��mad� ��nk� internet sitesinden kopyalad���m i�in bo�luklar� html kodu gibi g�r�yor);
select substr (genre2,2) from gamelist.game_list;

--�RNEK 3  Definitive Edition olan oyunlar�n listesi
select game_name from gamelist.game_list where instr(game_name,'Definitive') <> 0;

--�RNEK 4  Platfrom markalar�n�n�n soluna bo�luk koyarak ortalanm�� g�sterme;
select brand, lpad(brand,9,' ') as ortalanmis from gamelist.platform;

--�RNEK 5  Platformlar�n kategorisinde Mobile ve Console yaz�lar�n�n sonundaki e harfini kald�rmak i�in;
select trim(trailing 'E' from category) from gamelist.platform;

--�RNEK 6  Banka hesaplar�n�n ba��ndaki a kodunu kald�rmak i�in;
select trim(leading 'A' from account_id) from banking.accounts;

--�RNEK 7  Standard olan banka kartlar�ndan standard yaz�s�n� kald�rmak i�in;
select type,replace(type, 'Standard') from banking.cards;

--�RNEK 8  Oyun t�rlerini b�y�k harfle yazd�rmak i�in;
select upper(genre) from gamelist.game_list;

--�RNEK 9  Sat��lardaki adet fiyat� yuvarlayarak toplam fiyat� bulma;
select round(unit_price,1) as price_per_unit, quantity,quantity*round(unit_price) as total from sales.order_items;

--�RNEK 10  Kas�m ay�nda ��kan oyunlar;
select * from gamelist.game_list where to_char(release_date,'mm')='10' ;

--�RNEK 11  Sat�� DB i�in Elemanlar�n telefon numaras�n� number format�na �evirme;
select to_number(trim(replace(phone,'.'))) from SALES.employees;

--�RNEK 12  2021'de ��kacak oyunlar 1 ay ertelenmi� hali;
select game_name,release_date,add_months(release_date,1)  from gamelist.game_list where to_char(release_date, 'yyyy')='2021';

--�RNEK 13  2021'de b�t�n oyunlar ay�n son g�n� ��karsa;
select game_name,LAST_DAY(release_date) cikis_tarih from gamelist.game_list where to_char(release_date, 'yyyy')='2021';

--�RNEK 14  Hangi ay ka� oyun ��km��;
select extract(month from release_date),count(*) from gamelist.game_list group by extract(month from release_date) order by extract(month from release_date);

--�RNEK 15  Yorumlar bo� gelen de�erlere yorum yap�lmam�� yazd�rma;
select date_received,stars,NVL(REVIEWS, 'Yorum yap�lmam��')
from banking.crm_reviews where  REVIEWS IS NULL;