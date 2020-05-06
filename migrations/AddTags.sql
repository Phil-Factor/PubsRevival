/*-- create dependent types --*/
/* make sure that we are on the right database */
IF NOT EXISTS (SELECT * FROM sys.types WHERE name LIKE 'tid')
OR Object_Id('Titles') IS NULL
  BEGIN
    RAISERROR('Error. this migration script needs a version of the PUBS Database', 16, 1);
  END;
/* we check to see whether this script has been accidentally re-run and the tagname table is already
created. No bother, we simply do nothing rather than scream and trigger an error */
IF Object_Id('TagName') IS NULL
  BEGIN
  PRINT 'creating the tagname table'
    CREATE TABLE TagName (
	  TagName_ID INT IDENTITY(1, 1) PRIMARY KEY, 
	  Tag VARCHAR(20) NOT NULL UNIQUE);
   
  END
ELSE --do nothing besides sending a message
	PRINT 'The TagName table already exists. Nothing to do.'
/* now we have to stock the TagName table, if it hasn't already been stocked. It could
be that the process crashed at this stage during a previous attempt. */
IF NOT EXISTS (SELECT * FROM tagname) --if there is nothing in the table
         /* ...and we insert into it all the tags from the list 
        (remembering to take out any leading spaces)
		 */
    INSERT INTO TagName (Tag)
      SELECT DISTINCT LTrim(x.y.value('.', 'Varchar(80)')) AS Tag
        FROM
          (
          SELECT Title_ID,
            Convert( XML, '<list><i>' + Replace(TypeList, ',', '</i><i>') + '</i></list>'
)           AS XMLkeywords
            FROM dbo.titles
          ) AS g
          CROSS APPLY XMLkeywords.nodes('/list/i/text()') AS x(y);
ELSE
	PRINT 'Tagname table already filled. To replace the data, truncate it first'

/* Now we create the TagTitle table that provides the many-to-many relationship between
the Title table and the Tag table.  */
IF Object_Id('TagTitle') IS NULL
  BEGIN
    PRINT 'creating the tagTitle table and index'
    CREATE TABLE TagTitle
      (
      TagTitle_ID INT IDENTITY(1, 1),
      title_id dbo.tid NOT NULL REFERENCES titles (Title_ID),
      TagName_ID INT NOT NULL REFERENCES TagName (TagName_ID) 
	  CONSTRAINT PK_TagNameTitle PRIMARY KEY CLUSTERED
         (title_id ASC,TagName_ID) ON [PRIMARY]
      );

    CREATE NONCLUSTERED INDEX idxTagName_ID ON TagTitle (TagName_ID) 
	   INCLUDE (TagTitle_ID, title_id);
  END;
ELSE
	PRINT 'TagTitle table is created already'

  /* ...and we now fill this with the tags for each title. Firstly we
  check to see if the data is already in the table  ... */
IF NOT EXISTS (SELECT * FROM TagTitle)
	/* only do the insertion if it hasn't already been done.*/
    INSERT INTO TagTitle (title_id, TagName_ID)
      SELECT DISTINCT title_id, TagName_ID
        FROM
          (
          SELECT title_id,
            Convert(XML , '<list><i>' 
			              + Replace(TypeList, ',', '</i><i>') + '</i></list>'
)           AS XMLkeywords
            FROM dbo.titles
          ) AS g
          CROSS APPLY XMLkeywords.nodes('/list/i/text()') AS x(y)
          INNER JOIN TagName
            ON TagName.Tag = LTrim(x.y.value('.', 'Varchar(80)'));
ELSE
	PRINT 'TagTitle table already filled. To replace the data, truncate it first'
/* all done. The original typeList table will be removed in the synchronization */
