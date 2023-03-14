-- Inicio Encriptar una columna 


CREATE LOGIN logintarjeta WITH PASSWORD='abcd1234.'
GO
CREATE USER usertarjeta FOR LOGIN logintarjeta
GO

CREATE TABLE tarjeta
(id INT NOT NULL IDENTITY(1,1)
,Nombres VARCHAR(50) NOT NULL
,N_Tarjeta VARBINARY(128))
GO

CREATE TABLE Customers
	(customer_id INT PRIMARY KEY,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	social_security_number varbinary(100) NOT NULL)
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON tarjeta TO usertarjeta
GO

CREATE SYMMETRIC KEY usertarjeta_key
AUTHORIZATION logintarjeta
WITH ALGORITHM=AES_256 
ENCRYPTION BY PASSWORD='abcd1234.'
GO

REVERT
EXECUTE AS USER='usertarjeta'
GO
OPEN SYMMETRIC KEY usertarjeta_key DECRYPTION BY PASSWORD='abcd1234.'
GO

INSERT INTO tarjeta VALUES ('Howard',EncryptByKey(Key_GUID('BankManager_User_Key'),'4892167890'))
INSERT INTO tarjeta VALUES ('Donald',EncryptByKey(Key_GUID('BankManager_User_Key'),'7653091285'))
INSERT INTO tarjeta VALUES ('Bill',EncryptByKey(Key_GUID('BankManager_User_Key'),'1276540983'))
GO
-- Comprobar Encriptado
select * from dbo.tarjeta
go

-- Resultados

--customer_id	first_name	last_name	social_security_number
--1	Howard	Stern	0x0059FB12933E0040B8D7BEE21562886601000000E5F0AB62B6AF9320994029D7D290D4B4A649E7BB9CCFEC558854D88F1464B728
--2	Donald	Trump	0x0059FB12933E0040B8D7BEE21562886601000000F43686C69F2F636D6DE225774DEF99A000D40C13538479E41EBAA5D0BE9863B3
--3	Bill	Gates	0x0059FB12933E0040B8D7BEE21562886601000000C8EEE60368DD73A7B083B0B1F0447F276FD2CA97A00EDE6791912C5EDD34D15B

CLOSE ALL SYMMETRIC KEYS
GO

-- Vamos a Desencriptar

OPEN SYMMETRIC KEY [BankManager_User_Key] DECRYPTION BY PASSWORD='abcd1234.'
GO

SELECT customer_id,first_name + ' ' + last_name AS [Nombre Cliente],
CONVERT(VARCHAR,DecryptByKey(social_security_number)) as 'Número Seguridad Social'
FROM Customers
GO

-- Resultados despues de Desencriptar

--customer_id	Name	Social Security Number
--1	Howard Stern	042-32-1324
--2	Donald Trump	035-13-6564
--3	Bill Gates	533-13-5784

CLOSE ALL SYMMETRIC KEYS
GO
REVERT
GO
DROP DATABASE MiBanco
GO

-- Fin Encriptar una columna 
