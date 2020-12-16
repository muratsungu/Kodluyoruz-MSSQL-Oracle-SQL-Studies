
-- 1.Ürünlerin ürün adý, ürün kodunu ve KDV dahil satýþ fiyatýný listeleyiniz.
SELECT urunAd, urunKod, (listeFiyat*(1+KDVoran)) Kdvdahilfiyat FROM tblurun;


-- 2.En yüksek toplam fiyata sahip faturaya dahil ürünleri ve faturayý sipariþ veren müþterinin adýný soyadýný listeyen SQL kodunu yazýnýz.
SELECT DISTINCT 
k.isim+' '+k.soyad AdSoyad, s.faturaKod,  u.urunAd FROM tblKullanici k
JOIN tblSiparis s ON s.kullaniciKod=k.kullaniciKod
JOIN tblSiparisDetay sd ON sd.faturaKod=s.faturaKod
JOIN tblUrun u ON u.urunKod=sd.urunKod
WHERE s.toplam = (
	SELECT MAX(s.toplam) FROM tblSiparis s);


--3.Hiç sipariþ vermeyen müþterilerin mesleklerini listeleyiniz.
SELECT m.meslek FROM tblMeslek m
JOIN tblKullanici k ON
m.meslekKod=k.meslekKod
LEFT JOIN tblSiparis s ON
k.kullaniciKod=s.kullaniciKod
WHERE s.toplam IS NULL;


--4. 01.02.2007 - 05.03.2014 tarihleri arasýnda hangi üründen kaç adet sipariþ edildiðini bulan SQL kodunu yazýnýz.
SELECT u.urunAd, COUNT(u.Barkod) adet FROM tblUrun u
LEFT JOIN tblSiparisDetay sd ON  u.urunKod=sd.urunKod
JOIN tblSiparis s ON s.faturaKod=sd.faturaKod
WHERE s.siparisTarih BETWEEN '01.02.2007' AND '05.03.2014'
GROUP BY u.urunAd;


-- 5.Ýptal edilen sipariþlerde bulunan ürünleri listeyiniz.
SELECT sd.faturaKod, u.urunAd,sdu.aciklama FROM tblSiparisDurum sdu
JOIN tblSiparis s ON s.siparisDurumKod=sdu.siparisDurumKod
JOIN tblSiparisDetay sd ON sd.faturaKod=s.faturaKod
JOIN tblUrun u ON u.urunKod=sd.urunKod
WHERE sdu.siparisDurumKod=10
ORDER BY sd.faturaKod


-- 6.En fazla sipariþ veren meslek grubunu bulunuz.
SELECT top 1 m.meslek,COUNT(s.faturaKod) sayý FROM tblMeslek m
LEFT JOIN tblKullanici k ON k.meslekKod=m.meslekKod
LEFT JOIN tblSiparis s ON s.kullaniciKod=k.kullaniciKod
GROUP BY m.meslek
ORDER BY COUNT(s.faturaKod) DESC


/*  7. 3297 numaralý ürünü en fazla sipariþ veren þehri bulunuz.

update  tblkullanici      kullanýcý tablosunda sehir kodu yerine kocaeli yazan satýr vardý
set sehir=53
where sehir='Kocaeli'  
komutunu çalýþtýrmamýz gerekir.  */

SELECT TOP 1 se.Isim, COUNT(sd.SatirNo) sayi FROM tblSehir se
LEFT JOIN tblKullanici k ON k.sehir=se.Id
JOIN tblSiparis s ON s.kullaniciKod=k.kullaniciKod
JOIN tblSiparisDetay sd ON sd.faturaKod=s.faturaKod
WHERE sd.urunKod = 3297
GROUP BY se.Isim
ORDER BY COUNT(sd.SatirNo) DESC


-- 8. Adý A ile baþlayýp soyadýnda ak geçen müþterilerden en fazla sipariþ vereni bulunuz.
SELECT TOP 1 k.isim+' '+k.soyad [Ad Soyad], COUNT(*) sayi FROM tblKullanici k
JOIN tblSiparis s ON s.kullaniciKod=k.kullaniciKod
WHERE k.isim LIKE 'A%' and k.soyad LIKE '%AK%'
GROUP BY k.isim,k.soyad
ORDER BY COUNT(*) DESC