SET NUMERIC_ROUNDABORT OFF;
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON;
GO
SET XACT_ABORT ON;
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
GO
BEGIN TRANSACTION;
SET NOEXEC off
--inserted code
Declare @version varchar(25);
SELECT @version= Coalesce(Json_Value(
  ( SELECT Convert(NVARCHAR(3760), value) 
      FROM sys.extended_properties AS EP
      WHERE major_id = 0 AND minor_id = 0 
        AND name = 'Database_Info'),'$[0].Version'),'that was not recorded');
IF @version <> '2.1.5'
  BEGIN
  RAISERROR ('The Target was at version %s, not the correct version (2.1.5)',16,1,@version)
  SET NOEXEC ON;
  END
--end of inserted code
GO
IF @@Error <> 0 SET NOEXEC ON;
GO
PRINT N'Dropping constraints from [dbo].[discounts]';
GO
ALTER TABLE dbo.discounts DROP CONSTRAINT PK_discounts;
GO
IF @@Error <> 0 SET NOEXEC ON;
GO
PRINT N'Altering [dbo].[pub_info]';
GO
IF @@Error <> 0 SET NOEXEC ON;
GO
ALTER TABLE dbo.pub_info ALTER COLUMN logo VARBINARY(MAX) NULL;
GO
IF @@Error <> 0 SET NOEXEC ON;
GO
ALTER TABLE dbo.pub_info ALTER COLUMN pr_info NVARCHAR(MAX) COLLATE Latin1_General_CI_AS NULL;
GO
IF @@Error <> 0 SET NOEXEC ON;
GO
PRINT N'Altering extended properties'
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'Database_Info', N'[{"Name":"Pubs","Version":"2.1.6","Description":"The Pubs (publishing) Database supports a fictitious bookshop.","Modified":"2020-05-06T15:43:24.132","by":"PhilFactor"}]', NULL, NULL, NULL, NULL, NULL, NULL
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
COMMIT TRANSACTION;
GO
IF @@Error <> 0 SET NOEXEC ON;
GO
DECLARE @Success AS BIT;
SET @Success = 1;
SET NOEXEC OFF;
IF (@Success = 1) PRINT 'The database update succeeded';
ELSE BEGIN
	IF @@TranCount > 0 ROLLBACK TRANSACTION;
	PRINT 'The database update failed';
	END;
GO