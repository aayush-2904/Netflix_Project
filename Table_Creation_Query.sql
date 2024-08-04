


Create TABLE [dbo].[netflix_raw](
	[show_id] [nvarchar](10) primary key,
	[type] [varchar](10) NULL,
	[title] [varchar](150) NULL,
	[director] [varchar](250) NULL,
	[cast] [varchar](800) NULL,
	[country] [varchar](150) NULL,
	[date_added] [varchar](max) NULL,
	[release_year] [int] NULL,
	[rating] [varchar](10) NULL,
	[duration] [varchar](20) NULL,
	[listed_in] [varchar](100) NULL,
	[description] [varchar](500) NULL
) ;

