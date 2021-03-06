/*
Run this script on :
Script created by SQL Compare version 13.4.5.6953 from Red Gate Software Ltd at 12/05/2020 09:35:47

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
--inserted code
Declare @version varchar(25);
SELECT @version= Coalesce(Json_Value(
  ( SELECT Convert(NVARCHAR(3760), value) 
      FROM sys.extended_properties AS EP
      WHERE major_id = 0 AND minor_id = 0 
        AND name = 'Database_Info'),'$[0].Version'),'that was not recorded');
IF @version <> '2.1.7'
  BEGIN
  RAISERROR ('The Target was at version %s, not the correct version (2.1.7)',16,1,@version)
  SET NOEXEC ON
  END
go
PRINT N'Saving TITLES table to temporary table'
SELECT titles.title_id, titles.title, titles.type, titles.pub_id, titles.price,
       titles.advance, titles.royalty, titles.ytd_sales, titles.notes,
       titles.pubdate
   INTO #titles
   FROM [dbo].[titles];
IF @@ERROR <> 0 SET NOEXEC ON
GO
--end of inserted code
PRINT N'Dropping constraints from [dbo].[titles]'
GO
ALTER TABLE [dbo].[titles] DROP CONSTRAINT [DF__titles__type__07F6335A]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[titles]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[titles] DROP
COLUMN [type]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TagName]'
GO
CREATE TABLE [dbo].[TagName]
(
[TagName_ID] [int] NOT NULL IDENTITY(1, 1),
[Tag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__TagName__3109E9F88C8DE0AD] on [dbo].[TagName]'
GO
ALTER TABLE [dbo].[TagName] ADD PRIMARY KEY CLUSTERED  ([TagName_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[TagName]'
GO
ALTER TABLE [dbo].[TagName] ADD UNIQUE NONCLUSTERED  ([Tag])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TagTitle]'
GO
CREATE TABLE [dbo].[TagTitle]
(
[TagTitle_ID] [int] NOT NULL IDENTITY(1, 1),
[title_id] [dbo].[tid] NOT NULL,
[Is_Primary] [bit] NOT NULL DEFAULT ((0)),
[TagName_ID] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TagNameTitle] on [dbo].[TagTitle]'
GO
ALTER TABLE [dbo].[TagTitle] ADD CONSTRAINT [PK_TagNameTitle] PRIMARY KEY CLUSTERED  ([title_id], [TagName_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[reptq2]'
GO

ALTER PROCEDURE [dbo].[reptq2] AS
select 
	case when grouping(TN.tag) = 1 then 'ALL' else TN.tag end as type, 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(ytd_sales) as avg_ytd_sales
 FROM titles INNER JOIN tagtitle
ON TagTitle.title_id = titles.title_id
INNER JOIN dbo.TagName AS TN 
ON TN.TagName_ID = TagTitle.TagName_ID
where pub_id is NOT NULL AND is_primary=1
group by pub_id, TN.tag with rollup

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[reptq3]'
GO

ALTER PROCEDURE [dbo].[reptq3] @lolimit money, @hilimit money,
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[TagTitle]'
GO
ALTER TABLE [dbo].[TagTitle] ADD FOREIGN KEY ([TagName_ID]) REFERENCES [dbo].[TagName] ([TagName_ID])
GO
ALTER TABLE [dbo].[TagTitle] ADD FOREIGN KEY ([title_id]) REFERENCES [dbo].[titles] ([title_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering extended properties'
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'Database_Info', N'[{"Name":"Pubs","Version":"2.1.8","Description":"The Pubs (publishing) Database supports a fictitious bookshop.","Modified":"2020-05-06T13:57:56.217","by":"PhilFactor"}]', NULL, NULL, NULL, NULL, NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
--inserted code
INSERT INTO TagName (Tag) SELECT DISTINCT type FROM #titles;
IF @@ERROR <> 0 SET NOEXEC ON
INSERT INTO TagTitle (title_id,Is_Primary,TagName_ID)
  SELECT title_id, 1, TagName_ID FROM #titles 
    INNER JOIN TagName ON #titles.type = TagName.Tag;
IF @@ERROR <> 0 SET NOEXEC ON
DROP  TABLE #titles
go
--end of inserted code
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
