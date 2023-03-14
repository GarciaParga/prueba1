USE [autocaravanaEjemplos]
GO
SELECT d.compatibility_level
FROM sys.databases as d
WHERE d.name = Db_Name();
GO
ALTER DATABASE [autocaravanaEjemplos]
SET COMPATIBILITY_LEVEL = 150;
GO
ALTER DATABASE [autocaravanaEjemplos]
SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON;
GO
ALTER DATABASE [autocaravanaEjemplos]
ADD FILEGROUP autocaravanaEjemplos_memoria CONTAINS MEMORY_OPTIMIZED_DATA;
GO
ALTER DATABASE [autocaravanaEjemplos]
ADD FILE
(name='autocaravanaEjemplos_memoria',filename='C:\bd\Memoria')
TO FILEGROUP GestionEspectaculosCopia_mem
GO

CREATE TABLE [dbo].[Modelo55](
	[Id] [varchar](50) PRIMARY KEY NONCLUSTERED,
	[Nombre] [varchar](50) NULL,
	[Ano] [int] NULL,
	[Nº_puerta] [int] NULL)
	WITH (MEMORY_OPTIMIZED = ON,
	DURABILITY = SCHEMA_AND_DATA);
	GO

