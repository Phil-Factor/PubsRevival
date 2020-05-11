
USE Pubs
/****** Object:  UserDefinedDataType [dbo].[empid]    Script Date: 07/05/2020 14:49:46 ******/
CREATE TYPE dbo.empid FROM char(9) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[id]    Script Date: 07/05/2020 14:49:46 ******/
CREATE TYPE dbo.id FROM varchar(11) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[tid]    Script Date: 07/05/2020 14:49:46 ******/
CREATE TYPE dbo.tid FROM varchar(6) NOT NULL
GO
/****** Object:  Table [dbo].[titles]    Script Date: 07/05/2020 14:49:46 ******/
SET ANSI_NULLS ON
GO
/****** Object:  Table [dbo].[titles]    Script Date: 06/05/2020 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.titles(
	title_id dbo.tid NOT NULL,
	title nvarchar(120) NOT NULL,
	pub_id char(10) NULL,
	price money NULL,
	advance money NULL,
	royalty int NULL,
	ytd_sales int NULL,
	notes nvarchar(max) NULL,
	pubdate datetime NOT NULL,
 CONSTRAINT UPKCL_titleidind PRIMARY KEY CLUSTERED 
(
	title_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagName]    Script Date: 06/05/2020 15:10:31 ******/
CREATE TABLE TagName (TagName_ID INT IDENTITY(1, 1) PRIMARY KEY, Tag VARCHAR(20) NOT NULL UNIQUE);

go
/****** Object:  Table [dbo].[TagTitle]    Script Date: 06/05/2020 15:10:31 ******/
CREATE TABLE TagTitle
  (
  TagTitle_ID INT IDENTITY(1, 1),
  title_id dbo.tid NOT NULL REFERENCES titles (title_id),
  Is_Primary BIT NOT NULL DEFAULT 0,
  TagName_ID INT NOT NULL REFERENCES TagName (TagName_ID),
  CONSTRAINT PK_TagNameTitle PRIMARY KEY CLUSTERED (title_id ASC, TagName_ID) ON [PRIMARY]
  );
/****** Object:  Table [dbo].[titleauthor]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.titleauthor(
	au_id dbo.id NOT NULL,
	title_id dbo.tid NOT NULL,
	au_ord tinyint NULL,
	royaltyper int NULL,
 CONSTRAINT UPKCL_taind PRIMARY KEY CLUSTERED 
(
	au_id ASC,
	title_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[authors]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.authors(
	au_id dbo.id NOT NULL,
	au_lname nvarchar(80) NOT NULL,
	au_fname nvarchar(40) NOT NULL,
	phone char(12) NOT NULL,
	address nvarchar(80) NULL,
	city nvarchar(40) NULL,
	state char(2) NULL,
	zip char(5) NULL,
	contract bit NOT NULL,
 CONSTRAINT UPKCL_auidind PRIMARY KEY CLUSTERED 
(
	au_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[titleview]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.titleview
AS
select title, au_ord, au_lname, price, ytd_sales, pub_id
from authors, titles, titleauthor
where authors.au_id = titleauthor.au_id
   AND titles.title_id = titleauthor.title_id

GO
/****** Object:  Table [dbo].[discounts]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.discounts(
	discounttype nvarchar(80) NOT NULL,
	stor_id char(10) NULL,
	lowqty smallint NULL,
	highqty smallint NULL,
	discount decimal(4, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.employee(
	emp_id dbo.empid NOT NULL,
	fname nvarchar(40) NOT NULL,
	minit char(1) NULL,
	lname nvarchar(60) NOT NULL,
	job_id smallint NOT NULL,
	job_lvl tinyint NULL,
	pub_id char(10) NOT NULL,
	hire_date datetime NOT NULL,
 CONSTRAINT PK_emp_id PRIMARY KEY NONCLUSTERED 
(
	emp_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [employee_ind]    Script Date: 06/05/2020 15:10:31 ******/
CREATE CLUSTERED INDEX employee_ind ON dbo.employee
(
	lname ASC,
	fname ASC,
	minit ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobs]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.jobs(
	job_id smallint IDENTITY(1,1) NOT NULL,
	job_desc nvarchar(200) NOT NULL,
	min_lvl tinyint NOT NULL,
	max_lvl tinyint NOT NULL,
PRIMARY KEY CLUSTERED 
(
	job_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pub_info]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.pub_info(
	pub_id char(10) NOT NULL,
	logo varbinary(max) NULL,
	pr_info nvarchar(max) NULL,
 CONSTRAINT UPKCL_pubinfo PRIMARY KEY CLUSTERED 
(
	pub_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[publishers]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.publishers(
	pub_id char(10) NOT NULL,
	pub_name nvarchar(80) NULL,
	city nvarchar(40) NULL,
	state char(2) NULL,
	country nvarchar(60) NULL,
 CONSTRAINT UPKCL_pubind PRIMARY KEY CLUSTERED 
(
	pub_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roysched]    Script Date: 06/05/2020 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.roysched(
	title_id dbo.tid NOT NULL,
	lorange int NULL,
	hirange int NULL,
	royalty int NULL,
	roysched_id INT IDENTITY(1,1),
	CONSTRAINT roysched_id PRIMARY KEY CLUSTERED (
	roysched_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales]    Script Date: 06/05/2020 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.sales(
	stor_id char(10) NOT NULL,
	ord_num nvarchar(40) NOT NULL,
	ord_date datetime NOT NULL,
	qty smallint NOT NULL,
	payterms nvarchar(24) NOT NULL,
	title_id dbo.tid NOT NULL,
 CONSTRAINT UPKCL_sales PRIMARY KEY CLUSTERED 
(
	stor_id ASC,
	ord_num ASC,
	title_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stores]    Script Date: 06/05/2020 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.stores(
	stor_id char(10) NOT NULL,
	stor_name nvarchar(80) NULL,
	stor_address nvarchar(80) NULL,
	city nvarchar(40) NULL,
	state char(2) NULL,
	zip char(5) NULL,
 CONSTRAINT UPK_storeid PRIMARY KEY CLUSTERED 
(
	stor_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aunmind]    Script Date: 06/05/2020 15:10:32 ******/
CREATE NONCLUSTERED INDEX aunmind ON dbo.authors
(
	au_lname ASC,
	au_fname ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [titleidind]    Script Date: 06/05/2020 15:10:32 ******/
CREATE NONCLUSTERED INDEX titleidind ON dbo.roysched
(
	title_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [titleidind]    Script Date: 06/05/2020 15:10:32 ******/
CREATE NONCLUSTERED INDEX titleidind ON dbo.sales
(
	title_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [auidind]    Script Date: 06/05/2020 15:10:32 ******/
CREATE NONCLUSTERED INDEX auidind ON dbo.titleauthor
(
	au_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [titleidind]    Script Date: 06/05/2020 15:10:32 ******/
CREATE NONCLUSTERED INDEX titleidind ON dbo.titleauthor
(
	title_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [titleind]    Script Date: 06/05/2020 15:10:32 ******/
CREATE NONCLUSTERED INDEX titleind ON dbo.titles
(
	title ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.authors ADD  DEFAULT ('UNKNOWN') FOR phone
GO
ALTER TABLE dbo.employee ADD  DEFAULT ((1)) FOR job_id
GO
ALTER TABLE dbo.employee ADD  DEFAULT ((10)) FOR job_lvl
GO
ALTER TABLE dbo.employee ADD  DEFAULT ('9952') FOR pub_id
GO
ALTER TABLE dbo.employee ADD  DEFAULT (getdate()) FOR hire_date
GO
ALTER TABLE dbo.jobs ADD  DEFAULT ('New Position - title not formalized yet') FOR job_desc
GO
ALTER TABLE dbo.publishers ADD  DEFAULT ('USA') FOR country
GO
ALTER TABLE dbo.titles ADD  DEFAULT (getdate()) FOR pubdate
GO
ALTER TABLE dbo.discounts  WITH CHECK ADD FOREIGN KEY(stor_id)
REFERENCES dbo.stores (stor_id)
GO
ALTER TABLE dbo.employee  WITH CHECK ADD FOREIGN KEY(job_id)
REFERENCES dbo.jobs (job_id)
GO
ALTER TABLE dbo.employee  WITH CHECK ADD FOREIGN KEY(pub_id)
REFERENCES dbo.publishers (pub_id)
GO
ALTER TABLE dbo.pub_info  WITH CHECK ADD FOREIGN KEY(pub_id)
REFERENCES dbo.publishers (pub_id)
GO
ALTER TABLE dbo.roysched  WITH CHECK ADD FOREIGN KEY(title_id)
REFERENCES dbo.titles (title_id)
GO
ALTER TABLE dbo.sales  WITH CHECK ADD FOREIGN KEY(stor_id)
REFERENCES dbo.stores (stor_id)
GO
ALTER TABLE dbo.sales  WITH CHECK ADD FOREIGN KEY(title_id)
REFERENCES dbo.titles (title_id)
GO
ALTER TABLE dbo.titleauthor  WITH CHECK ADD FOREIGN KEY(au_id)
REFERENCES dbo.authors (au_id)
GO
ALTER TABLE dbo.titleauthor  WITH CHECK ADD FOREIGN KEY(title_id)
REFERENCES dbo.titles (title_id)
GO
ALTER TABLE dbo.titles  WITH CHECK ADD FOREIGN KEY(pub_id)
REFERENCES dbo.publishers (pub_id)
GO
ALTER TABLE dbo.authors  WITH CHECK ADD CHECK  ((au_id like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE dbo.authors  WITH CHECK ADD CHECK  ((zip like '[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE dbo.employee  WITH CHECK ADD  CONSTRAINT CK_emp_id CHECK  ((emp_id like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR emp_id like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'))
GO
ALTER TABLE dbo.employee CHECK CONSTRAINT CK_emp_id
GO
ALTER TABLE dbo.jobs  WITH CHECK ADD CHECK  ((max_lvl<=(250)))
GO
ALTER TABLE dbo.jobs  WITH CHECK ADD CHECK  ((min_lvl>=(10)))
GO
ALTER TABLE dbo.publishers  WITH CHECK ADD CHECK  ((pub_id='1756' OR pub_id='1622' OR pub_id='0877' OR pub_id='0736' OR pub_id='1389' OR pub_id like '99[0-9][0-9]'))
GO
/****** Object:  StoredProcedure [dbo].[byroyalty]    Script Date: 06/05/2020 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.byroyalty @percentage int
AS
select au_id from titleauthor
where titleauthor.royaltyper = @percentage

GO
/****** Object:  StoredProcedure [dbo].[reptq1]    Script Date: 06/05/2020 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.reptq1 AS
select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(price) as avg_price
from titles
where price is NOT NULL
group by pub_id with rollup
order by pub_id

GO
/****** Object:  StoredProcedure [dbo].[reptq2]    Script Date: 06/05/2020 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.reptq2 AS
select 
	case when grouping(TN.tag) = 1 then 'ALL' else TN.tag end as type, 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(ytd_sales) as avg_ytd_sales
from titles INNER JOIN tagtitle
ON TagTitle.title_id = titles.title_id
INNER JOIN dbo.TagName AS TN 
ON TN.TagName_ID = TagTitle.TagName_ID
where pub_id is NOT NULL AND is_primary=1
group by pub_id, TN.tag with rollup

GO
/****** Object:  StoredProcedure [dbo].[reptq3]    Script Date: 06/05/2020 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.reptq3 @lolimit money, @hilimit money,
@type char(12)
AS
select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	case when grouping(TN.tag) = 1 then 'ALL' else TN.tag end as type, 
	count(titles.title_id) as cnt
from titles INNER JOIN tagtitle
ON TagTitle.title_id = titles.title_id
INNER JOIN dbo.TagName AS TN 
ON TN.TagName_ID = TagTitle.TagName_ID
where price >@lolimit AND is_primary=1 AND price <@hilimit AND TN.tag = @type OR TN.tag LIKE '%cook%'

group by pub_id, TN.tag with rollup

GO
EXEC sys.sp_addextendedproperty @name=N'Database_Info', @value=N'[{"Name":"Pubs","Version":"2.1.8","Description":"The Pubs (publishing) Database supports a fictitious bookshop.","Modified":"2020-05-06T13:57:56.217","by":"sa"}]' 
GO
