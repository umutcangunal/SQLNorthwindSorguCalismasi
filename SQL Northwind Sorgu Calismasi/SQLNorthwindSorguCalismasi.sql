--ÇALIÞANLARIN SAYISINI LÝSTELÝYELÝM


--Categories --> Kategoriler
--Customers --> Müþteriler
--Employees --> Çalýþanlar
--EmployeeTerritories --> Çalýþan Bölgeleri
--Order Details --> sipariþ detaylarý
--Orders --> Sipariþler
--Products --> Ürünler
--Region --> Bölge
--Shippers --> Nakliye/Kargo Þirketleri
--Suppliers--> Tedarikçiler
--Territories--> Bölgeler

--ÇALIÞAN SAYISINI BULALIM 
Select COUNT(*) [Calýsan Sayýsý] 
From Employees

--MÜÞTERÝ SAYISINI BULALIM
Select COUNT(*) [Müþteri Sayýsý] From Customers

--SÝPARÝÞ TOPLAM SAYISI
Select  * From Orders
Select COUNT(*)[Sipariþ Toplam Sayýsý] From Orders

--ÇALIÞANLARIN AD VE SOYADLARINI BULAN SORGU
--a
Select	FirstName,
		LastName
From	Employees
--b
Select  FirstName,
		LastName,
		FirstName + ' ' + LastName [Çalýþan Ýsim ]
From Employees

--PATRONU LÝSTELÝYELÝM VE ÇALIÞAN KADINLARI LÝSTELEYELÝM
Select * From Employees
Where TitleOfCourtesy ='Dr.'

--a
Select  * From Employees
Where TitleOfCourtesy IN ('Ms.','Mrs.')

--b
Select * 
From Employees
Where TitleOfCourtesy = 'Ms.'
OR TitleOfCourtesy = 'Mrs.'


--ÇALIÞAN ERKEKLERÝN SORGULARI

--a
Select  * From Employees
Where TitleOfCourtesy ='Mr.'
 
 --b ÝSÝMLERÝNÝDE YAZDIRALIM ERKEKLERÝN

 Select FirstName,
		LastName,
		TitleOfCourtesy
 From Employees
 Where TitleOfCourtesy ='Mr.'

 --ÇALIÞAN KADIN VE ERKEKLERÝN SAYILARINI BULALIM // Patronu yani Dr. olaný çalýþandan saymaz eklesek bile

--a
 Select COUNT(*) [Çalýþþan Kadýn ve Erkeklerin Sayýsý]
 From Employees
 Where TitleOfCourtesy IN ('Ms.','Mrs.','Mr.');

 --b AMAÇ AS KULLANIMINA DÝKKAT ÇEKMEK
 Select COUNT(*) AS CALISANSAYISI
 From Employees
 Where TitleOfCourtesy IN ('Ms.','Mrs.','Mr.');

 --C Ayrý ayrý hesaplayalým

 Select  COUNT(*) AS CALISANERKEK
 From Employees 
 Where TitleOfCourtesy = 'Mr.'

 Select  COUNT(*) AS CALISANKADIN
 From Employees 
 Where TitleOfCourtesy IN ('Ms.','Mrs.');


--ÇALIÞANLAR KAÇ FARKLI SEHÝRDE YAÞIYOR
--a
Select DISTINCT 
	City
From Employees

--b 
Select  DISTINCT 
	Country
From Employees

--DOÐUM TARÝHÝ 1960-05-29 DAN BÜYÜK OLANLAR	

Select  * 
From Employees
Where BirthDate > '1960-05-29'

--ADRESÝNÝN ÝÇÝNDE HOUSE GEÇEN KÝÞÝLERÝN SORGUSU 
Select  
		FirstName,
		LastName,
		Address
From	Employees
Where Address LIKE '%House%'

--ADRESÝNÝN ÝÇÝNDE OLD GEÇEN KÝSÝLERÝ BULALALIM
Select 
		FirstName,
		LastName,
		Address
From	Employees
Where Address LIKE '%OLD%'

--EXTENSION KOLUNU 3 HANELÝ OLANLARI LÝSTELÝYELÝM

Select  Extension
From	Employees
Where LEN(Extension) =3;

--EXTENSION KOLUNU 4 HANELÝ OLANLARI LÝSTELÝYELÝM
Select Extension
From Employees
Where LEN(Extension) = 4;

--ÇALIÞANLARIN YAÞLARINI BULALIM
Select 
	DATEDIFF(YEAR,BirthDate,GETDATE()) [YAS]
From Employees
 
 --ÇALIÞANLARIN ÝÞE KAÇ YAÞINDA BAÞLADIÐINI BULALIM

 Select DATEDIFF(YEAR, BirthDate, HireDate) [ÇALIÞANLARIN ÝÞE BAÞLAMA TARÝHÝ]
 From Employees;

--REGION KOLONU NULL OLANLARI YAZDIRALIM

 Select * From Employees
 Where Region IS NULL;

 --ÇALIÞANLARIN ADLARINI A'DAN Z'YE  VE Z'DEN A'YA DOÐRU SIRALAMA YAPALIM

 Select FirstName
 From	Employees
 ORDER BY FirstName ASC;

 Select	FirstName
 From	Employees
 ORDER BY FirstName DESC;

 -- --ÇALIÞANLARIN ADLARINI A'DAN Z'YE  SOYADLARINI Z'DEN A'YA DOÐRU SIRALAMA YAPALIM

 Select FirstName,
		LastName
 From	Employees
 Order BY FirstName ASC,
		  LastName DESC;

Select	FirstName
From	Employees
ORDER BY FirstName ASC;

Select	LastName
From	Employees
Order By LastName DESC;

---ÞÝRKET ÇALIÞANLARININ ORTALAMA YAÞI NEDÝR?

Select  
	AVG (DATEDIFF(YEAR,BirthDate,GETDATE())) AS ORTALAMAYAS
From Employees

--MÜÞTERÝ A ÝLE BAÞLAYAN ÞÝRKETLER	HANGÝLERÝDÝR?

Select	*
From Customers
Where CompanyName LIKE 'A%'

SELECT *
FROM dbo.Customers
WHERE CompanyName LIKE 'A%';

--FAX VE REGION KISIMLARI NULL OLAN MÜÞTERÝLER HANGÝLERÝDÝR
Select  * From Customers
WHERE Region IS NULL 
		AND Fax IS NULL;

--CUSTOMERID'SÝ AA ÝLE BÝTEN MÜÞTERÝRÝ SIRALAMA

Select * From Customers
WHERE CustomerID LIKE '%AA'

--ÜRÜNLERÝN KDV DAHÝL VE KDV HARÝÇ FÝYATLARINI EKRANA YAZDIRALIM

Select  
	UnitPrice AS KDVSIZ,
	(UnitPrice * 0.20 + UnitPrice) AS KDVLIFIYAT
From Products

--KDVSÝ 10 TL DEN DÜÞÜK OLANLARI YAZDIRMA

Select 
	(UnitPrice * 0.20)
From Products
Where (UnitPrice * 0.20) < 10

Select 
	(UnitPrice * 0.20)
From Products
Where (UnitPrice * 0.20) > 10

-- EN PAHALI 5 ÜRÜNÜN SORGUSU

SELECT TOP 5
       ProductName,
       (UnitPrice * 0.18 + UnitPrice) AS KDVDahil
FROM dbo.Products
ORDER BY KDVDahil DESC;

--EN UCUZ 5 ÜRÜNÜN ORTALAMASI NEDÝR


Select AVG(Tablo.UnitPrice) AS UMUT
From
(
select TOP 5
	UnitPrice
From Products
ORDER BY UnitPrice ASC

)AS Tablo;


--ÜRÜNLERÝN ADLARINI BÜYÜTEREK YAZAR

Select  UPPER(ProductName)
From Products 


--ÜRÜNLERÝN ADLARINI KÜÇÜLTEREK YAZAR

Select LOWER(ProductName)
From Products

--STOÐU OLMAYAN ÜRÜNLER

Select * From Products
Where UnitsInStock = 0;


--STOK ADETÝ 20 - 50 ARASINDA OLAN ÜRÜNLERÝ GETÝREN SORGUYU YAZALIM

Select	ProductName,
		UnitsInStock
From Products
Where UnitsInStock
BETWEEN 20 AND 50
ORDER BY UnitsInStock ASC;

--EN PAHALI ÜRÜNÜN FÝYATINI GETÝRELÝM

Select MAX (UnitPrice) AS ENPAHALIURUN
From Products

--EN UCUZ ÜRÜNÜN FÝYATINI GETÝRELÝM

Select MIN (UnitPrice) AS ENUCUZURUN
From Products

--KAÇ ÇEÞÝT ÜRÜN VAR
Select  COUNT(ProductID)
From Products

--Tüm müþterileri listeleyen sorgu
Select * From Customers 

--En pahalý ürünün adý nedir?

Select ProductName
From Products
Where UnitPrice = 
(
	Select MAX(UnitPrice)FROM Products
);

--faxs numarasý olan müþterilerin sorgusu

Select  * From Customers 
Where Fax is not null

--Manager unvanýna sahip tüm müþterilerin sorgusu
Select  * From Customers 
Where ContactTitle LIKE '%Manager'

--FR ile baþlayan 5 karakter uzunluðunda olan müþterileri sorgulayýnýz

Select * From Customers WHERE CustomerID LIKE 'FR___'

--(171) alan kodlu telefon numarasýna sahip müþterilerin sorgusu
Select * From Customers
Where Phone LIKE '(171)%'

--	KategoriID'si 3 olan ve birim fiyatý 10 dan küçük olan tüm ürünlerin sorgusu

Select * From Products
Where CategoryID =3 and UnitPrice <10


--Sehir bilgisi 'London' ve  'Seattle' olan tüm personelleri getiriniz.

--a
Select * From Employees 
Where City in ('London','Seattle')

--b
Select * From Employees
Where City = 'London'
or	City ='Seattle'

--3,5 ve 7 nolu katogorideki tüm ürünlerin sorgusu..
--a
Select * From Products
Where CategoryID in ('3','5','7')

--b
Select * From Products
Where CategoryID =3 or CategoryID = 5 or CategoryID =7


--6 ve 9 nolu kategorideki ürünlerin dýþýnda tüm ürünlerin gösteren sorgu..
--a
Select * From Products
Where CategoryID !=6 And CategoryID !=9

--b 
Select * From Products
Where  CategoryID not in(6,9)

--Birim fiyatý 10 ile 20 arasýnda olan tüm ürünleri gösteren sorgu..

--a
Select  * From Products
Where UnitPrice
BETWEEN 10 AND 20

--b
Select * From Products
Where UnitPrice >= 10 And UnitPrice <=20

--1996-07-16 ile 1996-07-30 arasýnda sevk edilen satýþlarý inceleyeniz

Select * From Orders
Where ShippedDate
BETWEEN '1996-07-16' AND '1996-07-30'


--Bölgesi tanýmlý olmayan müþteriler
Select * From Customers
Where Region is NULL


--Faks numarasý olan müþteriler gösteren sorgu...
Select * From Customers
Where Fax is not null

--Birim Miktar alanýnda boxes geçen tüm ürünleri gösteren sorgu..
Select * From Products
Where QuantityPerUnit LIKE '%boxes%'

--Birim fiyatý 10 un altýnda olanlarý gösteren sorgu..
Select * From Products
Where UnitPrice <10

--En düþük birim fiyatýna sahip 5 ürünü gösteren sorgu
Select TOP 5
	 UnitPrice
From Products
ORDER BY UnitPrice ASC

--En yüksek birim fiyatýna sahip 10 ürünü gösteren sorgu..
Select  TOP 10
	UnitPrice
From Products
ORDER BY UnitPrice DESC

--Personellerin ad,  soyad ve yaþ bilgilerini gösteren sorgusu...

Select 
	FirstName,
	LastName,
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS YAS
From Employees


--35 Gün içinde sevk edilemeyen satýþlarý gösteren sorgu..
Select * From Orders
Where DATEDIFF(dd, OrderDate, ShippedDate)>35

--Fransa ve almanyadaki müdürlerin(manager) adýný telefonu listeleyiz(Fax deðeri null olanlar hariç)
Select
	CompanyName,
	Phone,
	Fax
From Customers
Where Country in ('France','Germany') and ContactTitle LIKE '%Manager' and Fax is not Null

--Müþterileri ülke ve þehir bilgisine göre sýralama yapýnýz.
Select  * From Customers
ORDER BY City asc,
		Country asc


--Birim fiyatý en yüksek olan ürünün kategori adýný listeleyiniz (ALT SORGU)
Select CategoryName
From Categories
Where CategoryID= 
(
	Select TOP 1 CategoryID From Products
	ORDER BY UnitPrice DESC
)

--1996 yýlýnda yapýlan sipariþlerin listesi

--a
Select * From Orders
Where YEAR(OrderDate)=1996

--b
select * from Orders 
where DATEPART(yy,OrderDate)=1996


-- Her bir katagoride kaç ürün var listeleyeniz 
Select * From Categories
GROUP BY CategoryID

--Satýþý yapýlmayan ürün listesi
--a
Select	ProductName,	
		UnitsInStock,
		Discontinued
From Products
Where Discontinued ='1'

--b
Select 
		ProductName,	
		UnitsInStock
From Products
Where Discontinued = 1
AND	  Discontinued >0;


--Kaç farklý ülkeye ihracat yapýlmýþtýr
--a
Select DISTINCT Country AS ULKESAYISI
From Customers

--b
Select COUNT(DISTINCT Country) 
From Customers


--ALFKI CustomerID'sine sahip müþterilerin sipariþ sayýsý nedir?


Select COUNT(*) AS TOPLAM From Customers
Where CustomerID ='ALFKI'


--Butun nakliyecilerin listesi
Select * From Suppliers

--Berlinde olan nakliyecilerin listesi
Select* From Suppliers
Where City = 'Berlin'



--INNER JOINLER 

--INNER JOIN nedir?
--SQL inner join SQL Join türlerinden en çok kullanýlan tablo birleþtirme türüdür.
--SQL inner join iki veya daha fazla tablodaki iliþkili deðerleri seçmek/birleþtirmek için kullanýlýr.
--Özetle; SQL INNER JOIN ifadesi ortak deðere sahip tablolarý birleþtirmek için kullanýlýr.

--Her ürün hangi kategoridedir

Select  ProductName,
		CategoryName
From Products
INNER JOIN Categories
		ON Categories.CategoryID = Products.ProductID

--Hangi tedarikçi hangi ürünü saðlýyor 

Select * From Products
INNER JOIN Suppliers 
	ON Suppliers.SupplierID = Products.SupplierID;

--Ürünlerin karþýsýna kategori getirme

Select  * From Products
INNER JOIN Categories 
	ON Categories.CategoryID = Products.CategoryID

--Her kategoriden kaç ürün var?


Select 
	c.CategoryName,
	COUNT(p.ProductID) AS ToplamAdet
From  Products p
	INNER JOIN Categories c 
	  ON c.CategoryID = p.CategoryID
	  GROUP BY CategoryName;

