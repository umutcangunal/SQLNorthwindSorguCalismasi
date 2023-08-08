--�ALI�ANLARIN SAYISINI L�STEL�YEL�M


--Categories --> Kategoriler
--Customers --> M��teriler
--Employees --> �al��anlar
--EmployeeTerritories --> �al��an B�lgeleri
--Order Details --> sipari� detaylar�
--Orders --> Sipari�ler
--Products --> �r�nler
--Region --> B�lge
--Shippers --> Nakliye/Kargo �irketleri
--Suppliers--> Tedarik�iler
--Territories--> B�lgeler

--�ALI�AN SAYISINI BULALIM 
Select COUNT(*) [Cal�san Say�s�] 
From Employees

--M��TER� SAYISINI BULALIM
Select COUNT(*) [M��teri Say�s�] From Customers

--S�PAR�� TOPLAM SAYISI
Select  * From Orders
Select COUNT(*)[Sipari� Toplam Say�s�] From Orders

--�ALI�ANLARIN AD VE SOYADLARINI BULAN SORGU
--a
Select	FirstName,
		LastName
From	Employees
--b
Select  FirstName,
		LastName,
		FirstName + ' ' + LastName [�al��an �sim ]
From Employees

--PATRONU L�STEL�YEL�M VE �ALI�AN KADINLARI L�STELEYEL�M
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


--�ALI�AN ERKEKLER�N SORGULARI

--a
Select  * From Employees
Where TitleOfCourtesy ='Mr.'
 
 --b �S�MLER�N�DE YAZDIRALIM ERKEKLER�N

 Select FirstName,
		LastName,
		TitleOfCourtesy
 From Employees
 Where TitleOfCourtesy ='Mr.'

 --�ALI�AN KADIN VE ERKEKLER�N SAYILARINI BULALIM // Patronu yani Dr. olan� �al��andan saymaz eklesek bile

--a
 Select COUNT(*) [�al���an Kad�n ve Erkeklerin Say�s�]
 From Employees
 Where TitleOfCourtesy IN ('Ms.','Mrs.','Mr.');

 --b AMA� AS KULLANIMINA D�KKAT �EKMEK
 Select COUNT(*) AS CALISANSAYISI
 From Employees
 Where TitleOfCourtesy IN ('Ms.','Mrs.','Mr.');

 --C Ayr� ayr� hesaplayal�m

 Select  COUNT(*) AS CALISANERKEK
 From Employees 
 Where TitleOfCourtesy = 'Mr.'

 Select  COUNT(*) AS CALISANKADIN
 From Employees 
 Where TitleOfCourtesy IN ('Ms.','Mrs.');


--�ALI�ANLAR KA� FARKLI SEH�RDE YA�IYOR
--a
Select DISTINCT 
	City
From Employees

--b 
Select  DISTINCT 
	Country
From Employees

--DO�UM TAR�H� 1960-05-29 DAN B�Y�K OLANLAR	

Select  * 
From Employees
Where BirthDate > '1960-05-29'

--ADRES�N�N ���NDE HOUSE GE�EN K���LER�N SORGUSU 
Select  
		FirstName,
		LastName,
		Address
From	Employees
Where Address LIKE '%House%'

--ADRES�N�N ���NDE OLD GE�EN K�S�LER� BULALALIM
Select 
		FirstName,
		LastName,
		Address
From	Employees
Where Address LIKE '%OLD%'

--EXTENSION KOLUNU 3 HANEL� OLANLARI L�STEL�YEL�M

Select  Extension
From	Employees
Where LEN(Extension) =3;

--EXTENSION KOLUNU 4 HANEL� OLANLARI L�STEL�YEL�M
Select Extension
From Employees
Where LEN(Extension) = 4;

--�ALI�ANLARIN YA�LARINI BULALIM
Select 
	DATEDIFF(YEAR,BirthDate,GETDATE()) [YAS]
From Employees
 
 --�ALI�ANLARIN ��E KA� YA�INDA BA�LADI�INI BULALIM

 Select DATEDIFF(YEAR, BirthDate, HireDate) [�ALI�ANLARIN ��E BA�LAMA TAR�H�]
 From Employees;

--REGION KOLONU NULL OLANLARI YAZDIRALIM

 Select * From Employees
 Where Region IS NULL;

 --�ALI�ANLARIN ADLARINI A'DAN Z'YE  VE Z'DEN A'YA DO�RU SIRALAMA YAPALIM

 Select FirstName
 From	Employees
 ORDER BY FirstName ASC;

 Select	FirstName
 From	Employees
 ORDER BY FirstName DESC;

 -- --�ALI�ANLARIN ADLARINI A'DAN Z'YE  SOYADLARINI Z'DEN A'YA DO�RU SIRALAMA YAPALIM

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

---��RKET �ALI�ANLARININ ORTALAMA YA�I NED�R?

Select  
	AVG (DATEDIFF(YEAR,BirthDate,GETDATE())) AS ORTALAMAYAS
From Employees

--M��TER� A �LE BA�LAYAN ��RKETLER	HANG�LER�D�R?

Select	*
From Customers
Where CompanyName LIKE 'A%'

SELECT *
FROM dbo.Customers
WHERE CompanyName LIKE 'A%';

--FAX VE REGION KISIMLARI NULL OLAN M��TER�LER HANG�LER�D�R
Select  * From Customers
WHERE Region IS NULL 
		AND Fax IS NULL;

--CUSTOMERID'S� AA �LE B�TEN M��TER�R� SIRALAMA

Select * From Customers
WHERE CustomerID LIKE '%AA'

--�R�NLER�N KDV DAH�L VE KDV HAR�� F�YATLARINI EKRANA YAZDIRALIM

Select  
	UnitPrice AS KDVSIZ,
	(UnitPrice * 0.20 + UnitPrice) AS KDVLIFIYAT
From Products

--KDVS� 10 TL DEN D���K OLANLARI YAZDIRMA

Select 
	(UnitPrice * 0.20)
From Products
Where (UnitPrice * 0.20) < 10

Select 
	(UnitPrice * 0.20)
From Products
Where (UnitPrice * 0.20) > 10

-- EN PAHALI 5 �R�N�N SORGUSU

SELECT TOP 5
       ProductName,
       (UnitPrice * 0.18 + UnitPrice) AS KDVDahil
FROM dbo.Products
ORDER BY KDVDahil DESC;

--EN UCUZ 5 �R�N�N ORTALAMASI NED�R


Select AVG(Tablo.UnitPrice) AS UMUT
From
(
select TOP 5
	UnitPrice
From Products
ORDER BY UnitPrice ASC

)AS Tablo;


--�R�NLER�N ADLARINI B�Y�TEREK YAZAR

Select  UPPER(ProductName)
From Products 


--�R�NLER�N ADLARINI K���LTEREK YAZAR

Select LOWER(ProductName)
From Products

--STO�U OLMAYAN �R�NLER

Select * From Products
Where UnitsInStock = 0;


--STOK ADET� 20 - 50 ARASINDA OLAN �R�NLER� GET�REN SORGUYU YAZALIM

Select	ProductName,
		UnitsInStock
From Products
Where UnitsInStock
BETWEEN 20 AND 50
ORDER BY UnitsInStock ASC;

--EN PAHALI �R�N�N F�YATINI GET�REL�M

Select MAX (UnitPrice) AS ENPAHALIURUN
From Products

--EN UCUZ �R�N�N F�YATINI GET�REL�M

Select MIN (UnitPrice) AS ENUCUZURUN
From Products

--KA� �E��T �R�N VAR
Select  COUNT(ProductID)
From Products

--T�m m��terileri listeleyen sorgu
Select * From Customers 

--En pahal� �r�n�n ad� nedir?

Select ProductName
From Products
Where UnitPrice = 
(
	Select MAX(UnitPrice)FROM Products
);

--faxs numaras� olan m��terilerin sorgusu

Select  * From Customers 
Where Fax is not null

--Manager unvan�na sahip t�m m��terilerin sorgusu
Select  * From Customers 
Where ContactTitle LIKE '%Manager'

--FR ile ba�layan 5 karakter uzunlu�unda olan m��terileri sorgulay�n�z

Select * From Customers WHERE CustomerID LIKE 'FR___'

--(171) alan kodlu telefon numaras�na sahip m��terilerin sorgusu
Select * From Customers
Where Phone LIKE '(171)%'

--	KategoriID'si 3 olan ve birim fiyat� 10 dan k���k olan t�m �r�nlerin sorgusu

Select * From Products
Where CategoryID =3 and UnitPrice <10


--Sehir bilgisi 'London' ve  'Seattle' olan t�m personelleri getiriniz.

--a
Select * From Employees 
Where City in ('London','Seattle')

--b
Select * From Employees
Where City = 'London'
or	City ='Seattle'

--3,5 ve 7 nolu katogorideki t�m �r�nlerin sorgusu..
--a
Select * From Products
Where CategoryID in ('3','5','7')

--b
Select * From Products
Where CategoryID =3 or CategoryID = 5 or CategoryID =7


--6 ve 9 nolu kategorideki �r�nlerin d���nda t�m �r�nlerin g�steren sorgu..
--a
Select * From Products
Where CategoryID !=6 And CategoryID !=9

--b 
Select * From Products
Where  CategoryID not in(6,9)

--Birim fiyat� 10 ile 20 aras�nda olan t�m �r�nleri g�steren sorgu..

--a
Select  * From Products
Where UnitPrice
BETWEEN 10 AND 20

--b
Select * From Products
Where UnitPrice >= 10 And UnitPrice <=20

--1996-07-16 ile 1996-07-30 aras�nda sevk edilen sat��lar� inceleyeniz

Select * From Orders
Where ShippedDate
BETWEEN '1996-07-16' AND '1996-07-30'


--B�lgesi tan�ml� olmayan m��teriler
Select * From Customers
Where Region is NULL


--Faks numaras� olan m��teriler g�steren sorgu...
Select * From Customers
Where Fax is not null

--Birim Miktar alan�nda boxes ge�en t�m �r�nleri g�steren sorgu..
Select * From Products
Where QuantityPerUnit LIKE '%boxes%'

--Birim fiyat� 10 un alt�nda olanlar� g�steren sorgu..
Select * From Products
Where UnitPrice <10

--En d���k birim fiyat�na sahip 5 �r�n� g�steren sorgu
Select TOP 5
	 UnitPrice
From Products
ORDER BY UnitPrice ASC

--En y�ksek birim fiyat�na sahip 10 �r�n� g�steren sorgu..
Select  TOP 10
	UnitPrice
From Products
ORDER BY UnitPrice DESC

--Personellerin ad,  soyad ve ya� bilgilerini g�steren sorgusu...

Select 
	FirstName,
	LastName,
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS YAS
From Employees


--35 G�n i�inde sevk edilemeyen sat��lar� g�steren sorgu..
Select * From Orders
Where DATEDIFF(dd, OrderDate, ShippedDate)>35

--Fransa ve almanyadaki m�d�rlerin(manager) ad�n� telefonu listeleyiz(Fax de�eri null olanlar hari�)
Select
	CompanyName,
	Phone,
	Fax
From Customers
Where Country in ('France','Germany') and ContactTitle LIKE '%Manager' and Fax is not Null

--M��terileri �lke ve �ehir bilgisine g�re s�ralama yap�n�z.
Select  * From Customers
ORDER BY City asc,
		Country asc


--Birim fiyat� en y�ksek olan �r�n�n kategori ad�n� listeleyiniz (ALT SORGU)
Select CategoryName
From Categories
Where CategoryID= 
(
	Select TOP 1 CategoryID From Products
	ORDER BY UnitPrice DESC
)

--1996 y�l�nda yap�lan sipari�lerin listesi

--a
Select * From Orders
Where YEAR(OrderDate)=1996

--b
select * from Orders 
where DATEPART(yy,OrderDate)=1996


-- Her bir katagoride ka� �r�n var listeleyeniz 
Select * From Categories
GROUP BY CategoryID

--Sat��� yap�lmayan �r�n listesi
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


--Ka� farkl� �lkeye ihracat yap�lm��t�r
--a
Select DISTINCT Country AS ULKESAYISI
From Customers

--b
Select COUNT(DISTINCT Country) 
From Customers


--ALFKI CustomerID'sine sahip m��terilerin sipari� say�s� nedir?


Select COUNT(*) AS TOPLAM From Customers
Where CustomerID ='ALFKI'


--Butun nakliyecilerin listesi
Select * From Suppliers

--Berlinde olan nakliyecilerin listesi
Select* From Suppliers
Where City = 'Berlin'



--INNER JOINLER 

--INNER JOIN nedir?
--SQL inner join SQL Join t�rlerinden en �ok kullan�lan tablo birle�tirme t�r�d�r.
--SQL inner join iki veya daha fazla tablodaki ili�kili de�erleri se�mek/birle�tirmek i�in kullan�l�r.
--�zetle; SQL INNER JOIN ifadesi ortak de�ere sahip tablolar� birle�tirmek i�in kullan�l�r.

--Her �r�n hangi kategoridedir

Select  ProductName,
		CategoryName
From Products
INNER JOIN Categories
		ON Categories.CategoryID = Products.ProductID

--Hangi tedarik�i hangi �r�n� sa�l�yor 

Select * From Products
INNER JOIN Suppliers 
	ON Suppliers.SupplierID = Products.SupplierID;

--�r�nlerin kar��s�na kategori getirme

Select  * From Products
INNER JOIN Categories 
	ON Categories.CategoryID = Products.CategoryID

--Her kategoriden ka� �r�n var?


Select 
	c.CategoryName,
	COUNT(p.ProductID) AS ToplamAdet
From  Products p
	INNER JOIN Categories c 
	  ON c.CategoryID = p.CategoryID
	  GROUP BY CategoryName;

