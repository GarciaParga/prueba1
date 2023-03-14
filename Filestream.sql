use master
go

EXEC sp_configure filestream_access_level, 2
RECONFIGURE
GO
use [autocaravanaEjemplos]
go
ALTER DATABASE [autocaravanaEjemplos] 
	ADD FILEGROUP logos_fs CONTAINS FILESTREAM 
GO
ALTER DATABASE [autocaravanaEjemplos]
       ADD FILE (
             NAME = 'Logo_filestream',
             FILENAME = 'C:\BD\filestream'
       )
       TO FILEGROUP logos_fs
GO

alter table marca
alter column logo varbinary(8000) FILESTREAM FILEGROUP logos_fs
GO
DROP TABLE IF EXISTS [Marca]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marca2](
	[Id] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
	[Nombre] [varchar](50) NULL,
	[logo] [varbinary](MAX) FILESTREAM NULL UNIQUE NONCLUSTERED
(Id ASC),

 CONSTRAINT [Marca_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- FOLDER C:\Fotos_Actores\

INSERT INTO Marca2(Id,nombre,logo)
VALUES(NEWID(), 'Knaus', 
(SELECT BulkColumn FROM OPENROWSET(BULK 'C:\bd\Fotos_logo\Knaus.png', SINGLE_BLOB) as f));

INSERT INTO Marca2(Id,nombre,logo)
VALUES(NEWID(), 'adria', 
(SELECT BulkColumn FROM OPENROWSET(BULK 'C:\bd\Fotos_logo\adria.jpg', SINGLE_BLOB) as f));

INSERT INTO Marca2(Id,nombre,logo)
VALUES(NEWID(), 'Tabbert', 
(SELECT BulkColumn FROM OPENROWSET(BULK 'C:\bd\Fotos_logo\Tabbert.jpg', SINGLE_BLOB) as f));

SELECT *
FROM Marca2;
GO