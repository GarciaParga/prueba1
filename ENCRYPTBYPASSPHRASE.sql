
USE [caravanaEjercicios]
GO

drop table tarjeta
go

CREATE TABLE tarjeta
(id INT NOT NULL IDENTITY(1,1)
,Nombres VARCHAR(50) NOT NULL
,N_Tarjeta VARBINARY(128))
GO
--  insertamos un valor
INSERT INTO tarjeta (Nombres, N_Tarjeta)
VALUES ('Daniel', ENCRYPTBYPASSPHRASE('Abc123.','6513-2653-8435-8426'))
GO

SELECT *
FROM tarjeta
go

-- Intentamos hacer un select con una frase incorrecta
SELECT id, Nombres, CONVERT(VARCHAR(50),
DECRYPTBYPASSPHRASE('Abc123.',N_Tarjeta))
FROM tarjeta
go

--CodigoCliente	Nombres	(No column name)
--1				pepe	NULL


-- Ahora hacemos un select con la frase correcta
SELECT id, Nombres, CONVERT(VARCHAR(50), 
DECRYPTBYPASSPHRASE('contrasena',N_Tarjeta))
FROM tarjeta
go


DECLARE @v_Usuario SYSNAME
SET @v_Usuario = SYSTEM_USER
PRINT SYSTEM_USER
go

INSERT INTO tarjeta (Nombres, N_Tarjeta)
VALUES ('Juan', ENCRYPTBYPASSPHRASE('contrasena2','9845-2556-5115-8682'))
GO

-- Intentamos hacer un select convencional
SELECT *
FROM tarjeta
go


DECLARE @v_Usuario SYSNAME
SET @v_Usuario = 'Daniel'
SELECT id, Nombres, CONVERT(VARCHAR(50) , DECRYPTBYPASSPHRASE('contrasena',
N_Tarjeta,1,@v_Usuario))
FROM tarjeta
go

--CodigoCliente	Nombres	(No column name)
--1	pepe	NULL
--2	ana	2222-2222-2222-2222

--  Ahora hacemos un select con la frase correcta
--  y con el autenticador INCORRECTO

DECLARE @v_Usuario SYSNAME
SET @v_Usuario = 'Daniel'
SELECT id, Nombres, CONVERT(VARCHAR(50), DECRYPTBYPASSPHRASE('contrasena',
N_Tarjeta,0,@v_Usuario))
FROM tarjeta
go

--CodigoCliente	Nombres	(No column name)
--1				pepe	NULL
--2				ana		NULL