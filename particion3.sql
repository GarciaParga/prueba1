ALTER PARTITION FUNCTION Tipos_garantia_part()
MERGE RANGE (3);
GO
SELECT partition_number,row_count
FROM sys.dm_db_partition_stats
WHERE object_id = OBJECT_ID('dbo.Garantia');
GO
ALTER PARTITION FUNCTION Tipos_garantia_part()
MERGE RANGE (3);
GO
ALTER PARTITION FUNCTION Tipos_garantia_part()
split RANGE (3);
GO
CREATE TABLE [dbo].[Garantia2](
	[Id] [varchar](50) NOT NULL,
	[Fecha_inicio] [date] NULL,
	[Fecha_fin] [date] NULL,
	[descripcion] [varchar](50) NULL,
	tipo int
) ON Tipos_garantia (tipo)
GO
ALTER TABLE Garantia
SWITCH PARTITION 1 TO Garantia2 PARTITION 1;