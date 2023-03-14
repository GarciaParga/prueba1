ALTER DATABASE [autocaravanaEjemplos]
ADD FILEGROUP part1
GO
ALTER DATABASE [autocaravanaEjemplos]
ADD FILEGROUP part2
GO
ALTER DATABASE [autocaravanaEjemplos]
ADD FILEGROUP part3
GO

ALTER DATABASE [autocaravanaEjemplos]
ADD FILE
(NAME = partion1,
FILENAME = 'C:\bd\particion\partion1.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)TO FILEGROUP part1;
ALTER DATABASE [autocaravanaEjemplos]
ADD FILE
(NAME = partion2,
FILENAME = 'C:\bd\particion\partion2.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)TO FILEGROUP part2;
ALTER DATABASE [autocaravanaEjemplos]
ADD FILE
(NAME = partion3,
FILENAME = 'C:\bd\particion\partion3.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)
TO FILEGROUP part3;

use autocaravanaEjemplos
go

SELECT * FROM sys.filegroups
GO
SELECT * FROM sys.database_files
GO