create database [Bet�l Akmercan];
Go
Use [Bet�l Akmercan];

CREATE TABLE ALOMUSTERILERI(
MUSTERIID INT PRIMARY KEY,
MUSTERIAD VARCHAR(50),
MUSTERISOYAD VARCHAR(50),
MUSTERITELNO BIGINT UNIQUE,
MUSTERIMAIL VARCHAR(50) UNIQUE
);

CREATE TABLE PERSONELLER(
PERSONELID INT PRIMARY KEY,
PERSONELAD VARCHAR(50),
PERSONELSOYAD VARCHAR(50),
PERSONELGOREV VARCHAR(50)
);
  
CREATE TABLE MUDURLER(
MUDURID INT PRIMARY KEY,
MUDURAD VARCHAR(50),
MUDURSOYAD VARCHAR(50)
);

CREATE TABLE MENULER(
MENUID INT PRIMARY KEY,
MENUAD VARCHAR(20),
MENUADETI TINYINT,
MENUFIYAT MONEY
);

CREATE TABLE SERVISMUSTERILERI(
SERVISID INT PRIMARY KEY,
MENUID INT,
ODENENUCRET MONEY,
MENUOZELLIK VARCHAR(50),
FOREIGN KEY (MENUID) REFERENCES MENULER (MENUID)
);

CREATE TABLE ALOKURYELERI(
PAKETID INT PRIMARY KEY,
KURYETURU VARCHAR(11) CHECK (KURYETURU IN ('YEMEKSEPETI','GETIR')),
GELISSAATI TIME,
TAHMINIHAZIRLANMASURESI TIME,
PAKETTESLIMZAMANI TIME
);


CREATE TABLE KASALAR(
KASAID INT PRIMARY KEY,
PERSONELID INT UNIQUE,
GUNLUKKASAGELIRI MONEY,
FOREIGN KEY (PERSONELID) REFERENCES PERSONELLER (PERSONELID)
);

CREATE TABLE GUNLUKSATIS(
SATISID INT PRIMARY KEY,
MUSTERIID INT,
PERSONELID INT,
SERVISID INT,
MENUID INT,
MENUADET INT,
MENUUCRETI MONEY,
FOREIGN KEY (MUSTERIID) REFERENCES ALOMUSTERILERI (MUSTERIID),
FOREIGN KEY (PERSONELID) REFERENCES PERSONELLER (PERSONELID),
FOREIGN KEY (MENUID) REFERENCES MENULER (MENUID),
FOREIGN KEY (SERVISID) REFERENCES SERVISMUSTERILERI (SERVISID)
);

INSERT INTO ALOMUSTERILERI (MUSTERIID,MUSTERIAD,MUSTERISOYAD,MUSTERITELNO,MUSTERIMAIL)
VALUES(3,'�ZLEM','DEM�R',05384950112,'ozlemdemir.01@gmail.com'),
(4,'G�ZEM','ATA�',05320112255,'g�zematasss.s@gmail.com');
INSERT INTO PERSONELLER (PERSONELID,PERSONELAD,PERSONELSOYAD,PERSONELGOREV)
VALUES(1,'BEREN','�ZDEM�R','SERV�S'),
(2,'BATUHAN','ATE�','SERV�S'),
(3,'G�L','YILMAZ','KASA'),
(4,'EL�F','DEN�Z','KASA');
INSERT INTO MUDURLER (MUDURID,MUDURAD,MUDURSOYAD)
VALUES(1,'TU��E','BAYRAK�I'),
(2,'G�LS�M','TEK�N');
INSERT INTO MENULER (MENUID,MENUAD,MENUADETI,MENUFIYAT)
VALUES(1,'B�G MAC',120,220),
(2,'MC CHICKEN',150,195);
INSERT INTO SERVISMUSTERILERI(SERVISID,MENUID,ODENENUCRET,MENUOZELLIK)
VALUES(1,1,220,'TURSUSUZ'),
(2,2,195,'MAYONEZS�Z');
INSERT INTO ALOKURYELERI(PAKETID,KURYETURU,GELISSAATI,TAHMINIHAZIRLANMASURESI,PAKETTESLIMZAMANI)
VALUES(3,'GETIR','13:00:00','00:06:00','14:00:00'),
(4,'YEMEKSEPETI','13:30:00','00:10:00','14:00:00');
INSERT INTO KASALAR (KASAID,PERSONELID,GUNLUKKASAGELIRI)
VALUES (1,3,'17000'),
(2,4,'21050.5');
INSERT INTO GUNLUKSATIS (SATISID,MUSTERIID,PERSONELID,SERVISID,MENUID,MENUADET,MENUUCRETI)
VALUES(420,3,1,1,1,2,'220'),
(421,4,2,2,2,1,'195');

SELECT * FROM ALOMUSTERILERI
SELECT * FROM PERSONELLER
SELECT * FROM MUDURLER 
SELECT * FROM MENULER
SELECT * FROM SERVISMUSTERILERI
SELECT * FROM ALOKURYELERI
SELECT * FROM KASALAR
SELECT * FROM GUNLUKSATIS ORDER BY SATISID ASC 
GO
CREATE VIEW VWGUNLUKSATIS AS SELECT *,MENUADET*MENUUCRETI AS TUTAR FROM GUNLUKSATIS
GO
SELECT * FROM VWGUNLUKSATIS
GO
CREATE TRIGGER TAHMINIHAZIRLANMASURESIAZALT
ON ALOKURYELERI
AFTER INSERT
AS
SET NOCOUNT ON 
UPDATE ALOKURYELERI
SET TAHMINIHAZIRLANMASURESI=TAHMINIHAZIRLANMASURESI-'00:00:01'
FROM A.ALOKURYELERI INNER JOIN INSERTED I ON I.PAKETID=A.ALOKURYELERI.PAKETID
GO

CREATE TRIGGER MUSTERIDARTTIR
ON GUNLUKSATIS
AFTER INSERT
AS
SET NOCOUNT ON
UPDATE GUNLUKSATIS
SET MUSTERIID=MUSTERIID+1
FROM G.GUNLUKSATIS INNER JOIN INSERTED I ON I.SATISID=G.GUNLUKSATIS.SATISID












