/****** Object:  UserDefinedDataType [dbo].[empid]    Script Date: 15/05/2020 12:41:22 ******/
CREATE TYPE dbo.empid FROM CHAR(9) NOT NULL;
GO
/****** Object:  UserDefinedDataType [dbo].[id]    Script Date: 15/05/2020 12:41:22 ******/
CREATE TYPE dbo.id FROM VARCHAR(11) NOT NULL;
GO
/****** Object:  UserDefinedDataType [dbo].[tid]    Script Date: 15/05/2020 12:41:22 ******/
CREATE TYPE dbo.tid FROM VARCHAR(6) NOT NULL;
GO
/****** Object:  Table [dbo].[titles]    Script Date: 15/05/2020 12:41:22 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.titles
  (
  title_id dbo.tid NOT NULL,
  title VARCHAR(80) NOT NULL,
  type CHAR(12) NOT NULL,
  pub_id CHAR(4) NULL,
  price MONEY NULL,
  advance MONEY NULL,
  royalty INT NULL,
  ytd_sales INT NULL,
  notes VARCHAR(200) NULL,
  pubdate DATETIME NOT NULL,
  CONSTRAINT UPKCL_titleidind PRIMARY KEY CLUSTERED (title_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[titleauthor]    Script Date: 15/05/2020 12:41:22 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.titleauthor
  (
  au_id dbo.id NOT NULL,
  title_id dbo.tid NOT NULL,
  au_ord TINYINT NULL,
  royaltyper INT NULL,
  CONSTRAINT UPKCL_taind PRIMARY KEY CLUSTERED (au_id ASC, title_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[authors]    Script Date: 15/05/2020 12:41:22 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.authors
  (
  au_id dbo.id NOT NULL,
  au_lname VARCHAR(40) NOT NULL,
  au_fname VARCHAR(20) NOT NULL,
  phone CHAR(12) NOT NULL,
  address VARCHAR(40) NULL,
  city VARCHAR(20) NULL,
  state CHAR(2) NULL,
  zip CHAR(5) NULL,
  contract BIT NOT NULL,
  CONSTRAINT UPKCL_auidind PRIMARY KEY CLUSTERED (au_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
/****** Object:  View [dbo].[titleview]    Script Date: 15/05/2020 12:41:22 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.titleview
AS
SELECT title, au_ord, au_lname, price, ytd_sales, pub_id
  FROM authors, titles, titleauthor
  WHERE authors.au_id = titleauthor.au_id
    AND titles.title_id = titleauthor.title_id;

GO
/****** Object:  Table [dbo].[discounts]    Script Date: 15/05/2020 12:41:22 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.discounts
  (
  discounttype VARCHAR(40) NOT NULL,
  stor_id CHAR(4) NULL,
  lowqty SMALLINT NULL,
  highqty SMALLINT NULL,
  discount DECIMAL(4, 2) NOT NULL
  ) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[employee]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.employee
  (
  emp_id dbo.empid NOT NULL,
  fname VARCHAR(20) NOT NULL,
  minit CHAR(1) NULL,
  lname VARCHAR(30) NOT NULL,
  job_id SMALLINT NOT NULL,
  job_lvl TINYINT NULL,
  pub_id CHAR(4) NOT NULL,
  hire_date DATETIME NOT NULL,
  CONSTRAINT PK_emp_id PRIMARY KEY NONCLUSTERED (emp_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [employee_ind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE CLUSTERED INDEX employee_ind
ON dbo.employee (lname ASC, fname ASC, minit ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
/****** Object:  Table [dbo].[jobs]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.jobs
  (
  job_id SMALLINT IDENTITY(1, 1) NOT NULL,
  job_desc VARCHAR(50) NOT NULL,
  min_lvl TINYINT NOT NULL,
  max_lvl TINYINT NOT NULL,
  PRIMARY KEY CLUSTERED (job_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[pub_info]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.pub_info
  (
  pub_id CHAR(4) NOT NULL,
  logo IMAGE NULL,
  pr_info TEXT NULL,
  CONSTRAINT UPKCL_pubinfo PRIMARY KEY CLUSTERED (pub_id ASC) ON [PRIMARY]
  ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
/****** Object:  Table [dbo].[publishers]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.publishers
  (
  pub_id CHAR(4) NOT NULL,
  pub_name VARCHAR(40) NULL,
  city VARCHAR(20) NULL,
  state CHAR(2) NULL,
  country VARCHAR(30) NULL,
  CONSTRAINT UPKCL_pubind PRIMARY KEY CLUSTERED (pub_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[roysched]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.roysched (title_id dbo.tid NOT NULL, lorange INT NULL, hirange INT NULL, royalty INT NULL) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[sales]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.sales
  (
  stor_id CHAR(4) NOT NULL,
  ord_num VARCHAR(20) NOT NULL,
  ord_date DATETIME NOT NULL,
  qty SMALLINT NOT NULL,
  payterms VARCHAR(12) NOT NULL,
  title_id dbo.tid NOT NULL,
  CONSTRAINT UPKCL_sales PRIMARY KEY CLUSTERED
    (stor_id ASC, ord_num ASC, title_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
/****** Object:  Table [dbo].[stores]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE dbo.stores
  (
  stor_id CHAR(4) NOT NULL,
  stor_name VARCHAR(40) NULL,
  stor_address VARCHAR(40) NULL,
  city VARCHAR(20) NULL,
  state CHAR(2) NULL,
  zip CHAR(5) NULL,
  CONSTRAINT UPK_storeid PRIMARY KEY CLUSTERED (stor_id ASC) ON [PRIMARY]
  ) ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [aunmind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE NONCLUSTERED INDEX aunmind
ON dbo.authors (au_lname ASC, au_fname ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [titleidind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE NONCLUSTERED INDEX titleidind
ON dbo.roysched (title_id ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [titleidind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE NONCLUSTERED INDEX titleidind
ON dbo.sales (title_id ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [auidind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE NONCLUSTERED INDEX auidind
ON dbo.titleauthor (au_id ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [titleidind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE NONCLUSTERED INDEX titleidind
ON dbo.titleauthor (title_id ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO
/****** Object:  Index [titleind]    Script Date: 15/05/2020 12:41:23 ******/
CREATE NONCLUSTERED INDEX titleind
ON dbo.titles (title ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
     DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
     ALLOW_PAGE_LOCKS = ON
     )
ON [PRIMARY];
GO
ALTER TABLE dbo.authors ADD DEFAULT ('UNKNOWN') FOR phone;
GO
ALTER TABLE dbo.employee ADD DEFAULT ((1)) FOR job_id;
GO
ALTER TABLE dbo.employee ADD DEFAULT ((10)) FOR job_lvl;
GO
ALTER TABLE dbo.employee ADD DEFAULT ('9952') FOR pub_id;
GO
ALTER TABLE dbo.employee ADD DEFAULT (GetDate()) FOR hire_date;
GO
ALTER TABLE dbo.jobs ADD DEFAULT ('New Position - title not formalized yet') FOR job_desc;
GO
ALTER TABLE dbo.publishers ADD DEFAULT ('USA') FOR country;
GO
ALTER TABLE dbo.titles ADD DEFAULT ('UNDECIDED') FOR type;
GO
ALTER TABLE dbo.titles ADD DEFAULT (GetDate()) FOR pubdate;
GO
ALTER TABLE dbo.discounts WITH CHECK ADD FOREIGN KEY (stor_id) REFERENCES dbo.stores
(stor_id);
GO
ALTER TABLE dbo.employee WITH CHECK ADD FOREIGN KEY (job_id) REFERENCES dbo.jobs
(job_id);
GO
ALTER TABLE dbo.employee WITH CHECK ADD FOREIGN KEY (pub_id) REFERENCES dbo.publishers
(pub_id);
GO
ALTER TABLE dbo.pub_info WITH CHECK ADD FOREIGN KEY (pub_id) REFERENCES dbo.publishers
(pub_id);
GO
ALTER TABLE dbo.roysched WITH CHECK ADD FOREIGN KEY (title_id) REFERENCES dbo.titles
(title_id);
GO
ALTER TABLE dbo.sales WITH CHECK ADD FOREIGN KEY (stor_id) REFERENCES dbo.stores
(stor_id);
GO
ALTER TABLE dbo.sales WITH CHECK ADD FOREIGN KEY (title_id) REFERENCES dbo.titles
(title_id);
GO
ALTER TABLE dbo.titleauthor WITH CHECK ADD FOREIGN KEY (au_id) REFERENCES dbo.authors
(au_id);
GO
ALTER TABLE dbo.titleauthor WITH CHECK
ADD FOREIGN KEY (title_id) REFERENCES dbo.titles (title_id);
GO
ALTER TABLE dbo.titles WITH CHECK ADD FOREIGN KEY (pub_id) REFERENCES dbo.publishers
(pub_id);
GO
ALTER TABLE dbo.authors WITH CHECK
ADD CHECK ((au_id LIKE '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]'));
GO
ALTER TABLE dbo.authors WITH CHECK ADD CHECK ((zip LIKE '[0-9][0-9][0-9][0-9][0-9]'));
GO
ALTER TABLE dbo.employee WITH CHECK
ADD CONSTRAINT CK_emp_id CHECK ((
                               emp_id LIKE '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]'
                            OR emp_id LIKE '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'
                               ));
GO
ALTER TABLE dbo.employee CHECK CONSTRAINT CK_emp_id;
GO
ALTER TABLE dbo.jobs WITH CHECK ADD CHECK ((max_lvl <= (250)));
GO
ALTER TABLE dbo.jobs WITH CHECK ADD CHECK ((min_lvl >= (10)));
GO
ALTER TABLE dbo.publishers WITH CHECK
ADD CHECK ((
          pub_id = '1756'
       OR pub_id = '1622'
       OR pub_id = '0877'
       OR pub_id = '0736'
       OR pub_id = '1389'
       OR pub_id LIKE '99[0-9][0-9]'
          ));
GO
/****** Object:  StoredProcedure [dbo].[byroyalty]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE dbo.byroyalty @percentage INT
AS
SELECT au_id FROM titleauthor WHERE titleauthor.royaltyper = @percentage;

GO
/****** Object:  StoredProcedure [dbo].[reptq1]    Script Date: 15/05/2020 12:41:23 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE dbo.reptq1
AS
SELECT CASE WHEN Grouping(pub_id) = 1 THEN 'ALL' ELSE pub_id END AS pub_id,
  Avg(price) AS avg_price
  FROM titles
  WHERE price IS NOT NULL
  GROUP BY pub_id WITH ROLLUP
  ORDER BY pub_id;

GO
/****** Object:  StoredProcedure [dbo].[reptq2]    Script Date: 15/05/2020 12:41:23 ******/
CREATE PROCEDURE dbo.reptq2
AS
SELECT CASE WHEN Grouping(type) = 1 THEN 'ALL' ELSE type END AS type,
  CASE WHEN Grouping(pub_id) = 1 THEN 'ALL' ELSE pub_id END AS pub_id,
  Avg(ytd_sales) AS avg_ytd_sales
  FROM titles
  WHERE pub_id IS NOT NULL
  GROUP BY pub_id, type WITH ROLLUP;

GO
/****** Object:  StoredProcedure [dbo].[reptq3]    Script Date: 15/05/2020 12:41:23 ******/
CREATE PROCEDURE dbo.reptq3 @lolimit MONEY, @hilimit MONEY, @type CHAR(12)
AS
SELECT CASE WHEN Grouping(pub_id) = 1 THEN 'ALL' ELSE pub_id END AS pub_id,
  CASE WHEN Grouping(type) = 1 THEN 'ALL' ELSE type END AS type,
  Count(title_id) AS cnt
  FROM titles
  WHERE price > @lolimit
    AND price < @hilimit
    AND type = @type
     OR type LIKE '%cook%'
  GROUP BY pub_id, type WITH ROLLUP;

GO

EXEC sp_Addextendedproperty N'Database_Info', N'[{"Name":"Pubs","Version":"2.1.5","Description":"The Pubs (publishing) Database supports a fictitious bookshop.","Modified":"2020-05-06T15:43:24.132","by":"PhilFactor"}]', NULL, NULL, NULL, NULL, NULL, NULL


