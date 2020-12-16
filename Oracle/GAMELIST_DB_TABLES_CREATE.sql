--Murat Süngü Kodluyoruz Week2 Oracle SQL DB Ödevi

/*
Bu þemada 2020 yýlýnda çýkmýþ ve 2021 yýlýnda çýkacak olan tüm oyunlar için bir DB oluþturdum. 
Publisher tablosunda oyunlarý çýkartan firmalarýn isimlerini içeriyor.
Game_list tablosunda 580 adet oyunun verisi bulunmakta, bu oyunlardan bir kaç tanesinin ismi ayný. Bunun sebebi ise bazý oyunlarýn farklý 
zamanlarda farklý platformlar için çýkmýþ olmasý. Tablo oyunun ismi, çýkýþ tarihi, oyunun türünü içeriyor
Platform tablosunda oyunlarýn çýktýðý platformlar, bu platformlarýn kategorisi ve markalarý yer almakta.

Oyunlar ve Platform kýsmý birbirine n-n tarzýnda baðlý olmasý gerektiðinden ara bir tablo oluþturdum. PLATFORM_GAME_CONNECTION tablosunda game_id ve platform_id
arasýnda bir baðlantý kurarak analizler çýkartmak mümkün oluyor. oyun tablosunda çoklayan verilerden de böylece kaçýnmýþ oluyorum.

Yayýncýlarýn olduðu tablo, id kýsmý ile oyun listesine baðlanmýþ durumda.

*/
-----------------------------
------ GAMELIST SCHEMA ------
-----------------------------

ALTER SESSION SET "_ORACLE_SCRIPT"=true;   
CREATE USER GAMELIST IDENTIFIED BY game123; 
GRANT CREATE SESSION TO GAMELIST;
GRANT CONNECT, RESOURCE, DBA TO GAMELIST;

---------CREATING TABLES-------------------
-------------------------------------------

CREATE TABLE PUBLISHER(
PUBLISHER_ID NUMBER PRIMARY KEY,
PUBLISHER_NAME VARCHAR2(250));

--------------------------------------------

CREATE TABLE GAME_LIST(
GAME_ID NUMBER PRIMARY KEY,
GAME_NAME NVARCHAR2(150),
RELEASE_DATE DATE,
GENRE VARCHAR2(50),
GENRE2 VARCHAR2(50),
GENRE3 VARCHAR2(50),
PUBLISHER_ID NUMBER,
CONSTRAINT FK_PUBLISHER_ID FOREIGN KEY(PUBLISHER_ID)
	REFERENCES PUBLISHER(PUBLISHER_ID));

-------------------------------------------

CREATE TABLE PLATFORM(
PLATFORM_ID NUMBER PRIMARY KEY,
PLATFORM_NAME VARCHAR2(50),
BRAND VARCHAR2(30),
CATEGORY VARCHAR2(30));

-------------------------------------------

CREATE TABLE PLATFORM_GAME_CONNECTION(
ID NUMBER PRIMARY KEY,
GAME_ID NUMBER, --FK
CONSTRAINT FK_GAME_ID FOREIGN KEY(GAME_ID)
	REFERENCES GAME_LIST(GAME_ID),
PLATFORM_ID NUMBER, --FK
CONSTRAINT FK_PLATFORM_ID FOREIGN KEY(PLATFORM_ID)
	REFERENCES PLATFORM(PLATFORM_ID));

--------------------------------------------

--GAME LIST tablosu için GAMES Synonym'i oluþturdum.
CREATE SYNONYM GAMES
    FOR GAMELIST.GAME_LIST;

--Kategorilere göre oyunlarý göstermek için(Konsol, Pc ve Mobil özelinde) bir View oluþturdum.
CREATE VIEW CATEGORIES AS
    SELECT PLATFORM.CATEGORY,PLATFORM_GAME_CONNECTION.ID
    FROM PLATFORM INNER JOIN PLATFORM_GAME_CONNECTION
    ON PLATFORM.PLATFORM_ID = PLATFORM_GAME_CONNECTION.PLATFORM_ID;
    
 --Aþaðýdaki kodla Hangi kategori için kaç oyun çýkmýþ onu görebiliyoruz. Sayýlarýn toplamý oyun sayýsýndan fazla çünkü 
 --genelde bir oyun birden fazla platform için çýkýyor.   
SELECT CATEGORY,COUNT(*) FROM CATEGORIES
GROUP BY CATEGORY;

