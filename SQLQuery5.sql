USE [master]
GO
/****** Object:  Database [SurisChallenge]    Script Date: 9/1/2025 22:44:30 ******/
CREATE DATABASE [SurisChallenge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SurisChallenge', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SurisChallenge.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SurisChallenge_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SurisChallenge_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SurisChallenge] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SurisChallenge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SurisChallenge] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SurisChallenge] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SurisChallenge] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SurisChallenge] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SurisChallenge] SET ARITHABORT OFF 
GO
ALTER DATABASE [SurisChallenge] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SurisChallenge] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SurisChallenge] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SurisChallenge] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SurisChallenge] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SurisChallenge] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SurisChallenge] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SurisChallenge] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SurisChallenge] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SurisChallenge] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SurisChallenge] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SurisChallenge] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SurisChallenge] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SurisChallenge] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SurisChallenge] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SurisChallenge] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SurisChallenge] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SurisChallenge] SET RECOVERY FULL 
GO
ALTER DATABASE [SurisChallenge] SET  MULTI_USER 
GO
ALTER DATABASE [SurisChallenge] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SurisChallenge] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SurisChallenge] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SurisChallenge] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SurisChallenge] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SurisChallenge] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SurisChallenge', N'ON'
GO
ALTER DATABASE [SurisChallenge] SET QUERY_STORE = ON
GO
ALTER DATABASE [SurisChallenge] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SurisChallenge]
GO
/****** Object:  User [SurisUser]    Script Date: 9/1/2025 22:44:30 ******/
CREATE USER [SurisUser] FOR LOGIN [SurisUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [SurisDemo]    Script Date: 9/1/2025 22:44:30 ******/
CREATE USER [SurisDemo] FOR LOGIN [SurisChallengeDemo] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SurisUser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SurisUser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SurisDemo]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SurisDemo]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 9/1/2025 22:44:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Client] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 9/1/2025 22:44:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (1, 1, CAST(N'2025-01-10T10:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T17:30:30.933' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (2, 1, CAST(N'2025-01-11T10:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T17:30:30.933' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (3, 1, CAST(N'2025-01-13T10:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T17:31:43.560' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (4, 1, CAST(N'2025-01-09T15:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T22:36:53.633' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (5, 1, CAST(N'2025-01-17T20:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T22:45:30.483' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (6, 3, CAST(N'2025-01-28T12:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T23:00:10.857' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (7, 7, CAST(N'2025-01-27T12:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-09T23:05:32.853' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (8, 6, CAST(N'2025-01-30T18:00:00.000' AS DateTime), N'Alejo Freyr', CAST(N'2025-01-09T23:38:07.940' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (9, 5, CAST(N'2025-01-21T12:00:00.000' AS DateTime), N'Alejo Freyr', CAST(N'2025-01-09T23:43:32.923' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (10, 3, CAST(N'2025-01-22T12:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-10T00:02:22.743' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (11, 4, CAST(N'2025-01-28T17:00:00.000' AS DateTime), N'Alejo Freyr', CAST(N'2025-01-10T00:05:16.567' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (12, 4, CAST(N'2025-01-30T19:00:00.000' AS DateTime), N'Santiago Espana', CAST(N'2025-01-10T00:06:17.147' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (13, 5, CAST(N'2025-01-22T12:00:00.000' AS DateTime), N'Alejo Freyr', CAST(N'2025-01-10T00:30:36.720' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (14, 6, CAST(N'2025-01-23T12:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-10T00:54:04.830' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (15, 4, CAST(N'2025-01-29T12:00:00.000' AS DateTime), N'Santiago Espana', CAST(N'2025-01-10T00:56:54.070' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (16, 7, CAST(N'2025-01-20T12:00:00.000' AS DateTime), N'Alejo Freyr', CAST(N'2025-01-10T00:57:43.557' AS DateTime))
GO
INSERT [dbo].[Reservations] ([Id], [ServiceId], [Date], [Client], [DateCreated]) VALUES (17, 4, CAST(N'2025-01-29T12:00:00.000' AS DateTime), N'Juan Perez', CAST(N'2025-01-10T00:59:32.440' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[Services] ON 
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (1, N'Minimum Viable Product')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (2, N'Migration To .NET 7.0')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (3, N'Turnkey Project')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (4, N'Staff Augmentation')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (5, N'Artificial Intelligence Implementation')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (6, N'Load Testing With JMeter')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (7, N'EndToEnd Testing With Cypress')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (8, N'Application Insights Implementation')
GO
INSERT [dbo].[Services] ([Id], [Name]) VALUES (9, N'Docker And Kubernetes Implementation')
GO
SET IDENTITY_INSERT [dbo].[Services] OFF
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Services] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Services] ([Id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Services]
GO
/****** Object:  StoredProcedure [dbo].[Reservations_Create]    Script Date: 9/1/2025 22:44:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Reservations_Create]
						@ServiceId INT,
						@Date DATETIME,
						@Client NVARCHAR(50)
AS
/*
	DECLARE  @ServiceId INT = 1,
			 @Date DATETIME = '2025-01-11T10:00:00',
			 @Client NVARCHAR(50) = 'Juan Perez'

	EXECUTE [Reservations_Create]
						@ServiceId,
						@Date,
						@Client

	SELECT * FROM [dbo].[Reservations]

*/

BEGIN

	IF NOT EXISTS (
        SELECT 1
        FROM [dbo].[Reservations] r
        INNER JOIN [dbo].[Services] s
            ON r.[ServiceId] = s.[Id]
        WHERE r.Client = @Client AND r.[Date] = @Date
    )

    BEGIN
		DECLARE @DateNow DATETIME = GETUTCDATE()

        INSERT INTO [dbo].[Reservations]
            ([ServiceId],
			[Date],
			[Client],
			[DateCreated])

        VALUES
            (@ServiceId,
			@Date,
			@Client,
			@DateNow)
    END

    ELSE
    BEGIN
        PRINT 'Ya existe una reserva con el mismo cliente y fecha.'
    END
END
GO
/****** Object:  StoredProcedure [dbo].[Reservations_GetAll]    Script Date: 9/1/2025 22:44:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Reservations_GetAll]
					
AS
/*
	EXECUTE dbo.Reservations_GetAll
*/

BEGIN

	  SELECT r.[Id],
		   r.[Client],
		   r.[Date],
		   s.[Id] AS ServiceId,
		   s.[Name] AS ServiceName
	FROM [dbo].[Reservations] r
	INNER JOIN [dbo].[Services] s
		ON r.[ServiceId] = s.[Id]

END
GO
/****** Object:  StoredProcedure [dbo].[Reservations_GetByClient]    Script Date: 9/1/2025 22:44:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Reservations_GetByClient]
													@Client NVARCHAR(50)
												
AS
/*
	DECLARE @Client NVARCHAR(50) = 'Juan Perez'

	EXECUTE [Reservations_GetByClient] @Client
*/

BEGIN

	  SELECT r.[Id],
		   r.[Date],
		   r.[Client],
		   s.[Id] AS ServiceId,
		   s.[Name] AS ServiceName
	FROM [dbo].[Reservations] r
	INNER JOIN [dbo].[Services] s
		ON r.[ServiceId] = s.[Id]
		WHERE r.Client = @Client 

END
GO
/****** Object:  StoredProcedure [dbo].[Services_GetAll]    Script Date: 9/1/2025 22:44:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Services_GetAll]
					
AS
/*
	EXECUTE dbo.Services_GetAll
*/

BEGIN

	SELECT [Id]
		  ,[Name]
	  FROM [dbo].[Services]

END
GO
USE [master]
GO
ALTER DATABASE [SurisChallenge] SET  READ_WRITE 
GO
