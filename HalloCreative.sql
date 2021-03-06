-- Create a new database called 'HalloCreativeDB'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'HalloCreativeDB'
)
CREATE DATABASE HalloCreativeDB
GO


USE [HalloCreativeDB]
GO

CREATE SCHEMA [HalloCreatives]
GO




-- Create a new table called '[Services]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HalloCreatives].[Services]', 'U') IS NOT NULL
DROP TABLE [HalloCreatives].[Services]
GO
-- Create the table in the specified schema
CREATE TABLE [HalloCreatives].[Services]
(
        [Service Code] INT identity(1,1) NOT NULL,
        [Service Name] varchar(20) NOT NULL,
        [Service Description] varchar(45) NULL,
        [quantity] INT NOT NULL,
        [createdAt] DATETIME,
        [updatedAt] datetime,
        CONSTRAINT [PK_ServiceCODE] PRIMARY KEY ([Service Code])
);
GO


-- Create a new table called '[Orders]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HalloCreatives].[Orders]', 'U') IS NOT NULL
DROP TABLE [HalloCreatives].[Orders]
GO
-- Create the table in the specified schema
CREATE TABLE [HalloCreatives].[Orders]
(
        [Order Number] int identity(1,1) NOT NULL ,
        [Customer Number] int NOT NULL,
        [Service Code] int not null,
        [Employee Number] int null ,
        [Order Date] datetime NOT NULL,
        [Status] varchar(10) NOT NULL CHECK (Status IN('Paid','Part Paid','Not Paid')),
        [Amount] money not null,
        [Amount Paid] money null,
        [createdAt] DATETIME,
        [updatedAt] datetime,
        CONSTRAINT [PK_OrderNumber] PRIMARY KEY ([Order Number])
);
GO

-- Create a new table called '[Offices]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HalloCreatives].[Offices]', 'U') IS NOT NULL
DROP TABLE [HalloCreatives].[Offices]
GO
-- Create the table in the specified schema
CREATE TABLE [HalloCreatives].[Offices]
(
        [Office Code] int  identity(1,1) NOT NULL,
        [City] varchar(25) NULL,
        [Phone Number] varchar(15) NOT NULL,
        [Address Line 1] varchar(45) NOT NULL,
        [Address Line 2] varchar(45) NULL,
        [Country] varchar(25) NOT NULL,
        [State] varchar(30) NOT NULL,
        [createdAt] DATETIME,
        [updatedAt] datetime,
        CONSTRAINT [PK_OfficeCode] PRIMARY KEY ([Office Code])
);
GO

-- Create a new table called '[Employees]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HalloCreatives].[Employees]', 'U') IS NOT NULL
DROP TABLE [HalloCreatives].[Employees]
GO
-- Create the table in the specified schema
CREATE TABLE [HalloCreatives].[Employees]
(
        [Employee Number] int identity(1,1)  NOT NULL,
        [Office Code] int NOT NULL,
        [Last Name] varchar(30) NOT NULL,
        [First Name] varchar(30) NOT NULL,
        [Name Extension] varchar(5) NULL,
        [Email] varchar(30) NOT NULL,
        [Job Title] varchar(20) NOT NULL,
        [createdAt] DATETIME,
        [updatedAt] datetime,
        CONSTRAINT [PK_EmployeeNum] PRIMARY KEY ([Employee Number])
);
GO

-- Create a new table called '[Customers]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HalloCreatives].[Customers]', 'U') IS NOT NULL
DROP TABLE [HalloCreatives].[Customers]
GO
-- Create the table in the specified schema
CREATE TABLE [HalloCreatives].[Customers]
(
        [Customer Number] int  identity(1,1) NOT NULL,
        [Customer Name] varchar(30) NOT NULL,
        [Phone] varchar(15) NOT NULL,
        [Address Line 1] varchar(45) NOT NULL,
        [Address Line 2] varchar(45) NULL,
        [City] varchar(25) NOT NULL,
        [Country] varchar(25) NOT NULL,
        [createdAt] DATETIME,
        [updatedAt] datetime,
        CONSTRAINT [PK_customernum] PRIMARY KEY ([Customer Number])
);
GO



-- Create a new table called '[Payments]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HalloCreatives].[Payments]', 'U') IS NOT NULL
DROP TABLE [HalloCreatives].[Payments]
GO
-- Create the table in the specified schema
CREATE TABLE [HalloCreatives].[Payments]
(
        [Payment ID] int IDENTITY(1,1) not null,
        [Order Number] int NOT NULL,
        [Customer Number] int NOT NULL,
        [Payment Date] datetime NOT NULL,
        [Amount] money NOT NULL,
        [Status] VARCHAR(10) NOT NULL CHECK (Status IN('Successful','Not Sucessful')),
        CONSTRAINT [PK_paymentID] PRIMARY KEY ([Payment ID])
);
GO


/* ADD FORIEGN KEYS */



ALTER TABLE [HalloCreatives].[Orders]
ADD CONSTRAINT [FK_serviceCodeO] FOREIGN KEY ([Service Code]) REFERENCES [HalloCreatives].[Services]([Service Code]);
GO

ALTER TABLE [HalloCreatives].[Employees]
ADD CONSTRAINT [FK_officeCode] FOREIGN KEY ([Office Code]) REFERENCES [HalloCreatives].[Offices]([Office Code]);
GO

ALTER TABLE [HalloCreatives].[Orders]
ADD CONSTRAINT [FK_EmployeeNumO] FOREIGN KEY ([Employee Number]) REFERENCES [HalloCreatives].[Employees]([Employee Number]);
GO


ALTER TABLE [HalloCreatives].[Orders]
ADD CONSTRAINT [FK_customernumO] FOREIGN KEY ([Customer Number]) REFERENCES [HalloCreatives].[Customers]([Customer Number]);
GO

ALTER TABLE [HalloCreatives].[Payments]
ADD CONSTRAINT [FK_customernumP] FOREIGN KEY ([Customer Number]) REFERENCES [HalloCreatives].[Customers]([Customer Number]);
GO

ALTER TABLE [HalloCreatives].[Payments]
ADD CONSTRAINT [FK_OrdernumP] FOREIGN KEY ([Order Number]) REFERENCES [HalloCreatives].[Orders]([Order Number]);
GO
