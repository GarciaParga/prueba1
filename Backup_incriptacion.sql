USE master
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'abc123.';
GO
CREATE CERTIFICATE certificadoBack
WITH SUBJECT = 'Certificado de backup';
GO
SELECT * FROM sys.certificates
GO
BACKUP CERTIFICATE certificadoBack TO FILE =
'C:\bd\Certificado\certificadoBack.cer'
WITH PRIVATE KEY
(FILE = 'C:\bd\Certificado\certificadoBack_key.pvk',
ENCRYPTION BY PASSWORD = 'abc123.'
);
Go
USE [autocaravanaEjemplos]
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE certificadoBack;
GO
ALTER DATABASE [autocaravanaEjemplos]
SET ENCRYPTION ON;
GO
USE master
GO
BACKUP DATABASE [autocaravanaEjemplos]
TO DISK = 'C:\bd\Certificado\Autocaravana.bak'
WITH ENCRYPTION
(ALGORITHM = AES_256,
SERVER CERTIFICATE = certificadoBack
),
STATS = 10,INIT
GO
RESTORE DATABASE [autocaravanaEjemplos] 
FROM DISK ='C:\bd\Certificado\Autocaravana.bak';
GO

SELECT * FROM sys.certificates
GO
