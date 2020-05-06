/* this is a script for reversing out of a migration change where we re-engineer a list
of types of a publication. */ 
/* make sure that we are on the right database */
IF NOT EXISTS (SELECT * FROM sys.types WHERE name LIKE 'tid')
OR Object_Id('Titles') IS NULL
  BEGIN
    RAISERROR('Error. this migration script needs a version of the PUBS Database', 16, 1);
  END;

IF NOT EXISTS -- only run if the column does not exist
    (
    SELECT *  FROM sys.columns
    WHERE name LIKE 'typelist'
        AND object_id = Object_Id('dbo.titles')
    )
	BEGIN
	PRINT 'Adding TypeList column as a NULLable column and adding data'
	ALTER TABLE titles ADD TypeList varchar(100) NULL
	end
ELSE
	SET NOexec On
GO
--now we fill the typelist from the tagTitle and Tag columns
--this will only be executed if we've just created the column
-- because otherwise we've set NOEXEC on for the spid.
UPDATE titles SET typelist = 
            Coalesce(Stuff(( SELECT ', '+tag
            FROM tagname INNER JOIN Tagtitle 
			  ON TagTitle.TagName_ID = TagName.TagName_ID
               WHERE Titles.title_id = TagTitle.title_id
            ORDER BY tag
            FOR XML PATH(''), TYPE).value(N'(./text())[1]',N'Nvarchar(1000)'),1,2,''),'')
IF @@RowCount >= 10000 --we assume every title has at least one type category
  BEGIN
    ALTER TABLE Titles ALTER COLUMN TypeList VARCHAR(100) NOT NULL;
    IF Object_Id('TagTitle') IS NOT NULL DROP TABLE TagTitle; 
	  --only executed if we've just created the Typelist column
    IF Object_Id('TagName') IS not NULL DROP TABLE TagName; 
	  --only executed if we've just created the Typelist column

  END;
SET NOEXEC OFF;
