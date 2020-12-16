
/* ####### JOIN ÖRNEKLERÝ ####### */

--ÖRNEK 1 Yayýncý firmalarýn çýkardýðý oyun sayýsý sýralamasý
select p.publisher_name,count(gl.game_id) as sayi from gamelist.game_list gl
inner join gamelist.publisher p on p.publisher_id= gl.publisher_id
group by p.publisher_name
order by count(gl.game_id) desc;

--ÖRNEK 2 Hangi platformda kaç adet oyun çýkmýþ?
select p.platform_name,count(gl.game_id) from gamelist.platform p
inner join gamelist.platform_game_connection pgc on p.platform_id=pgc.platform_id
inner join gamelist.game_list gl on gl.game_id=pgc.game_id
group by p.platform_name;
--order by count(gl.game_id) desc;              istersek bu komutla sýralý görebiliriz.

--ÖRNEK 3 Hangi oyunlar en çok platforma çýkmýþ?
select g.game_name,count(pgc.platform_id) from gamelist.game_list g
right join gamelist.platform_game_connection pgc 
on g.game_id=pgc.game_id
left join gamelist.platform p 
on p.platform_id=pgc.platform_id
group by g.game_name
order by count(pgc.platform_id) desc;

--ÖRNEK 4 Hangi platformda hangi yayýncý firmalar oyun çýkarmýþ?
select distinct p.platform_name,pu.publisher_name from gamelist.platform p 
inner join gamelist.platform_game_connection pgc 
on pgc.platform_id=p.platform_id
inner join gamelist.game_list g
on g.game_id=pgc.game_id
inner join gamelist.publisher pu 
on pu.publisher_id=g.publisher_id
order by p.platform_name,pu.publisher_name;

/* ####### COMBINE ÖRNEKLERÝ ####### */

--ÖRNEK 1  Union ile çaðýrýnca oyun sayýsý kadar id geliyor. Union all dediðimizde çoklayan deðerler de geliyor
SELECT GAME_ID FROM GAMELIST.GAME_LIST
UNION ALL
SELECT GAME_ID FROM GAMELIST.PLATFORM_GAME_CONNECTION ORDER BY GAME_ID;

SELECT GAME_ID FROM GAMELIST.GAME_LIST
UNION 
SELECT GAME_ID FROM GAMELIST.PLATFORM_GAME_CONNECTION ORDER BY GAME_ID;

--ÖRNEK 2  Ýletiþim numarasý olduðu halde müþteriler tablosunda olmayan kiþiler;
select customer_id from SALES.contacts
minus
select customer_id from sales.customers;

--ÖRNEK 3  Mobil kategorisi dýþýnda yayýnlanan oyunlarýn listesi;
select g.game_name,p.platform_name from gamelist.platform_game_connection pgc
left join gamelist.platform p on p.platform_id=pgc.platform_id
inner join gamelist.game_list g on g.game_id=pgc.game_id
minus
select g.game_name,p.platform_name from gamelist.platform_game_connection pgc
left join gamelist.platform p on p.platform_id=pgc.platform_id
inner join gamelist.game_list g on g.game_id=pgc.game_id
where p.category ='MOBILE';

--ÖRNEK 4  Haziran 2020'den önce çýkmýþ ve Spor veya Aksiyon türlerinde çýkmýþ oyunlarýn kesiþimi;

select  game_name,release_date,genre from gamelist.game_list
where genre='Sports' or genre='Action'
ýntersect
select game_name,release_date,genre from gamelist.game_list
where release_date < '30.06.2020';


/* ####### FONKSÝYON ÖRNEKLERÝ ####### */

--ÖRNEK 1  Ýsmi 10 harften kýsa olan oyunlar
SELECT * FROM GAMELIST.GAME_LIST WHERE LENGTH(GAME_NAME ) <10;

--ÖRNEK 2  Genre2 ve genre3 sütunlarýndaki deðerlerin baþlangýcýndan boþluk vardý. Boþluðu kaldýrmak için 
--(trim çalýþmadý çünkü internet sitesinden kopyaladýðým için boþluklarý html kodu gibi görüyor);
select substr (genre2,2) from gamelist.game_list;

--ÖRNEK 3  Definitive Edition olan oyunlarýn listesi
select game_name from gamelist.game_list where instr(game_name,'Definitive') <> 0;

--ÖRNEK 4  Platfrom markalarýnýnýn soluna boþluk koyarak ortalanmýþ gösterme;
select brand, lpad(brand,9,' ') as ortalanmis from gamelist.platform;

--ÖRNEK 5  Platformlarýn kategorisinde Mobile ve Console yazýlarýnýn sonundaki e harfini kaldýrmak için;
select trim(trailing 'E' from category) from gamelist.platform;

--ÖRNEK 6  Banka hesaplarýnýn baþýndaki a kodunu kaldýrmak için;
select trim(leading 'A' from account_id) from banking.accounts;

--ÖRNEK 7  Standard olan banka kartlarýndan standard yazýsýný kaldýrmak için;
select type,replace(type, 'Standard') from banking.cards;

--ÖRNEK 8  Oyun türlerini büyük harfle yazdýrmak için;
select upper(genre) from gamelist.game_list;

--ÖRNEK 9  Satýþlardaki adet fiyatý yuvarlayarak toplam fiyatý bulma;
select round(unit_price,1) as price_per_unit, quantity,quantity*round(unit_price) as total from sales.order_items;

--ÖRNEK 10  Kasým ayýnda çýkan oyunlar;
select * from gamelist.game_list where to_char(release_date,'mm')='10' ;

--ÖRNEK 11  Satýþ DB için Elemanlarýn telefon numarasýný number formatýna çevirme;
select to_number(trim(replace(phone,'.'))) from SALES.employees;

--ÖRNEK 12  2021'de çýkacak oyunlar 1 ay ertelenmiþ hali;
select game_name,release_date,add_months(release_date,1)  from gamelist.game_list where to_char(release_date, 'yyyy')='2021';

--ÖRNEK 13  2021'de bütün oyunlar ayýn son günü çýkarsa;
select game_name,LAST_DAY(release_date) cikis_tarih from gamelist.game_list where to_char(release_date, 'yyyy')='2021';

--ÖRNEK 14  Hangi ay kaç oyun çýkmýþ;
select extract(month from release_date),count(*) from gamelist.game_list group by extract(month from release_date) order by extract(month from release_date);

--ÖRNEK 15  Yorumlar boþ gelen deðerlere yorum yapýlmamýþ yazdýrma;
select date_received,stars,NVL(REVIEWS, 'Yorum yapýlmamýþ')
from banking.crm_reviews where  REVIEWS IS NULL;