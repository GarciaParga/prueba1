CREATE PARTITION FUNCTION Tipos_garantia_part (int)
AS RANGE LEFT
FOR VALUES (0, 5)
GO

CREATE PARTITION SCHEME Tipos_garantia
AS PARTITION Tipos_garantia_part
TO (part1, part2, part3)
GO

DROP TABLE IF EXISTS [Garantia]
GO
CREATE TABLE [dbo].[Garantia](
	[Id] [varchar](50) NOT NULL,
	[Fecha_inicio] [date] NULL,
	[Fecha_fin] [date] NULL,
	[descripcion] [varchar](50) NULL,
	tipo int
) ON Tipos_garantia (tipo)
GO
INSERT INTO Garantia (Id, Fecha_inicio, Fecha_fin, descripcion,tipo)
VALUES ('GAR001', '2022-01-01', '2023-01-01', 'Garantía extendida por un año',1),
		('GAR002', '2022-03-15', '2023-03-15', 'Garantía por defectos de fabricación',2),
		('GAR003', '2022-05-01', '2023-05-01', 'Garantía por daños durante el envío',4),
	    ('GAR004', '2022-08-10', '2023-08-10', 'Garantía por fallos en el software',2),
	    ('GAR005', '2022-10-20', '2023-10-20', 'Garantía por desgaste natural del producto',3),
	    ('GAR006', '2022-12-01', '2023-12-01', 'Garantía por problemas de conectividad',3),
	    ('GAR007', '2023-02-14', '2024-02-14', 'Garantía por pérdida de datos',2);
select * from Garantia
	where (tipo > 0 and tipo <3)
	go
----------------------------
SELECT * FROM sys.partition_functions;
SELECT * FROM sys.partition_schemes;
go

select *
FROM sys.dm_db_partition_stats
WHERE object_id = OBJECT_ID('Garantia');
GO
SELECT partition_number,row_count
FROM sys.dm_db_partition_stats
WHERE object_id = OBJECT_ID('Garantia');
GO
------------------