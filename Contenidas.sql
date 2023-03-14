USE MASTER
GO
EXEC SP_CONFIGURE 'show advanced options', 1
GO
EXEC SP_CONFIGURE 'contained database authentication', 1
GO
RECONFIGURE
GO

EXEC sp_configure

DROP DATABASE IF EXISTS Alquiler
GO
CREATE DATABASE Alquiler
CONTAINMENT=PARTIAL
GO
use Alquiler
go
select * into Alquiler
from [autocaravanaEjemplos].[dbo].[Cliente]
GO

-- Creo usuario juan, asocio esquema dbo
DROP USER IF EXISTS juan
GO
CREATE USER juan 
	WITH PASSWORD='abcd1234.',
	DEFAULT_SCHEMA=[dbo]
go
-- A�adimos el usuario juan el rol dbo_owner
-- Deprecated
EXEC sp_addrolemember 'db_owner', 'juan'
GO
-- New
ALTER ROLE db_owner
ADD MEMBER juan
GO

GRANT CONNECT TO JUAN
GO



CREATE TABLE [dbo].[TablaContenida](
	[Codigo] [nchar](10) NULL,
	[Nombre] [nchar](10) NULL
) ON [PRIMARY]
GO


