USE [master]
GO
/****** Object:  Database [CityIncident]    Script Date: 16-05-2021 16:55:02 ******/
CREATE DATABASE [CityIncident]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CityIncident', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CityIncident.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CityIncident_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CityIncident_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CityIncident] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CityIncident].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CityIncident] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CityIncident] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CityIncident] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CityIncident] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CityIncident] SET ARITHABORT OFF 
GO
ALTER DATABASE [CityIncident] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CityIncident] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CityIncident] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CityIncident] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CityIncident] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CityIncident] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CityIncident] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CityIncident] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CityIncident] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CityIncident] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CityIncident] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CityIncident] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CityIncident] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CityIncident] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CityIncident] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CityIncident] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CityIncident] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CityIncident] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CityIncident] SET  MULTI_USER 
GO
ALTER DATABASE [CityIncident] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CityIncident] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CityIncident] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CityIncident] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CityIncident] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CityIncident] SET QUERY_STORE = OFF
GO
USE [CityIncident]
GO
/****** Object:  Table [dbo].[GoogleMap]    Script Date: 16-05-2021 16:55:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoogleMap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](50) NULL,
	[Latitude] [numeric](18, 0) NULL,
	[Longitude] [numeric](18, 0) NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_GoogleMap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Incident]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Incident](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IncidentNo]  AS ('INC_'+CONVERT([varchar](10),[ID])) PERSISTED,
	[Title] [varchar](max) NOT NULL,
	[Description] [varchar](max) NULL,
	[IncidentDate] [datetime] NOT NULL,
	[IncidentType] [bigint] NOT NULL,
	[MapId] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[County] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[PinCode] [varchar](50) NULL,
 CONSTRAINT [PK_Incident] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncidentType]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncidentType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_IncidentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Incident] ADD  CONSTRAINT [DF_Incident_IncidentDate]  DEFAULT (getdate()) FOR [IncidentDate]
GO
ALTER TABLE [dbo].[Incident]  WITH CHECK ADD  CONSTRAINT [FK_Incident_GoogleMap] FOREIGN KEY([MapId])
REFERENCES [dbo].[GoogleMap] ([ID])
GO
ALTER TABLE [dbo].[Incident] CHECK CONSTRAINT [FK_Incident_GoogleMap]
GO
ALTER TABLE [dbo].[Incident]  WITH CHECK ADD  CONSTRAINT [FK_Incident_IncidentType] FOREIGN KEY([IncidentType])
REFERENCES [dbo].[IncidentType] ([Id])
GO
ALTER TABLE [dbo].[Incident] CHECK CONSTRAINT [FK_Incident_IncidentType]
GO
/****** Object:  StoredProcedure [dbo].[spAddIncident]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spAddIncident]
(  
		   @Title varchar(max),
           @Description varchar(max),
           @IncidentDate datetime,
           @IncidentType bigint,
		   @Address varchar(max),
           @County varchar(50),
           @State varchar(50),
           @City varchar(50),
           @PinCode varchar(50),
		   @Latitude numeric(18,0),
		   @Longitude numeric(18,0)
)  
as  
begin
	Declare @MapId int
	set nocount on;
	begin tran;
		insert into [dbo].[GoogleMap](CityName,Latitude,Longitude,Description)  
		values(@City,@Latitude,@Longitude,@Description)

		select @MapId = convert(int, SCOPE_IDENTITY());

		INSERT INTO [dbo].[Incident]
			   ([Title]
			   ,[Description]
			   ,[IncidentDate]
			   ,[IncidentType]
			   ,[MapId]
			   ,[Address]
			   ,[County]
			   ,[State]
			   ,[City]
			   ,[PinCode])
		 VALUES
			   (@Title,
			   @Description,
			   @IncidentDate,
			   @IncidentType,
			   @MapId,
			   @Address,
			   @County ,
			   @State ,
			   @City,
			   @PinCode)
	commit tran;
end  
  
GO
/****** Object:  StoredProcedure [dbo].[spAddNewLocation]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spAddNewLocation]  
(  
@CityName nvarchar(50),  
@Latitude numeric(18, 0),  
@Longitude numeric(18, 0),  
@Description nvarchar(100)  
)  
as  
begin  
insert into [dbo].[GoogleMap](CityName,Latitude,Longitude,Description)  
values(@CityName,@Latitude,@Longitude,@Description)  
end  
  
GO
/****** Object:  StoredProcedure [dbo].[spGetAllIncident]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[spGetAllIncident]  
as  
begin  
SELECT i.IncidentNo
	  ,i.[Title]
      ,i.[Description]
      ,i.[IncidentDate]
      ,it.Name as IncidentType
	  ,CONCAT(i.[Address], ', ', i.[City] ,', ', i.[State] ,', ', i.[County] ,' ', i.[PinCode]) as [Address]
  FROM [dbo].[Incident] i with(nolock) 
  INNER JOIN IncidentType it
  ON i.IncidentType = it.Id
end
GO
/****** Object:  StoredProcedure [dbo].[spGetIncidentType]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[spGetIncidentType]  
as  
begin  
select Id,[Name] from [dbo].[IncidentType]  
end
GO
/****** Object:  StoredProcedure [dbo].[spGetMap]    Script Date: 16-05-2021 16:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spGetMap]  
as  
begin  
select CityName,Latitude,Longitude,Description from [dbo].[GoogleMap]  
end
GO
USE [master]
GO
ALTER DATABASE [CityIncident] SET  READ_WRITE 
GO
