CREATE TABLE [dbo].[Pago2](
	[Id] [varchar](50)  primary key,
	[cantidad] [int] NULL,
	[fecha] [date] NULL,
	[tipo] [varchar](50) NULL,
	InicioTiempo datetime2 generated always as row start not null,
	FinTiempo datetime2 generated always as row end not null,
	period for System_time (InicioTiempo,FinTiempo) )
	with (System_Versioning = ON (History_Table = dbo.pago_historico))
go
INSERT INTO [dbo].[Pago2] ([Id], [cantidad], [fecha], [tipo])
VALUES
('P001', 1000, '2022-01-01', 'Efectivo'),
('P002', 500, '2022-02-15', 'Tarjeta'),
('P003', 750, '2022-03-21', 'Transferencia'),
('P004', 1300, '2022-01-01', 'Efectivo'),
('P005', 2500, '2022-02-15', 'Tarjeta'),
('P006', 1750, '2022-03-21', 'Transferencia');

select *
from Pago2
select*
from pago_historico
go

UPDATE Pago2
	set cantidad = 600
	where tipo = 'Efectivo'
go
select *
from Pago2
select*
from pago_historico
go

UPDATE Pago2
	set cantidad = 1000
	where tipo = 'Transferencia'
go
