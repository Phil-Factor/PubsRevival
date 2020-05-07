/*
Run this script on:

        pentlowMillServ.pubs    -  This database will be modified

to synchronize it with:

        pentlowMillServ.PubsBuild

You are recommended to back up your database before running this script

Script created by SQL Compare version 13.4.5.6953 from Red Gate Software Ltd at 07/05/2020 14:53:29

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
--inserted code
Declare @version varchar(25);
SELECT @version= Coalesce(Json_Value(
  ( SELECT Convert(NVARCHAR(3760), value) 
      FROM sys.extended_properties AS EP
      WHERE major_id = 0 AND minor_id = 0 
        AND name = 'Database_Info'),'$[0].Version'),'that was not recorded');
IF @version <> '2.1.6'
  BEGIN
  RAISERROR ('The Target was at version %s, not the correct version (2.1.6)',16,1,@version)
  SET NOEXEC ON;
  END
--end of inserted code
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[discounts]'
GO
ALTER TABLE [dbo].[discounts] DROP CONSTRAINT [FK__discounts__stor___173876EA]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[employee]'
GO
ALTER TABLE [dbo].[employee] DROP CONSTRAINT [FK__employee__pub_id__286302EC]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[pub_info]'
GO
ALTER TABLE [dbo].[pub_info] DROP CONSTRAINT [FK__pub_info__pub_id__20C1E124]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[titles]'
GO
ALTER TABLE [dbo].[titles] DROP CONSTRAINT [FK__titles__pub_id__08EA5793]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[sales]'
GO
ALTER TABLE [dbo].[sales] DROP CONSTRAINT [FK__sales__stor_id__1273C1CD]
GO
ALTER TABLE [dbo].[sales] DROP CONSTRAINT [FK__sales__title_id__1367E606]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[publishers]'
GO
ALTER TABLE [dbo].[publishers] DROP CONSTRAINT [CK__publisher__pub_i__0425A276]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[publishers]'
GO
ALTER TABLE [dbo].[publishers] DROP CONSTRAINT [UPKCL_pubind]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[publishers]'
GO
ALTER TABLE [dbo].[publishers] DROP CONSTRAINT [DF__publisher__count__0519C6AF]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[pub_info]'
GO
ALTER TABLE [dbo].[pub_info] DROP CONSTRAINT [UPKCL_pubinfo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[sales]'
GO
ALTER TABLE [dbo].[sales] DROP CONSTRAINT [UPKCL_sales]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[stores]'
GO
ALTER TABLE [dbo].[stores] DROP CONSTRAINT [UPK_storeid]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[employee]'
GO
ALTER TABLE [dbo].[employee] DROP CONSTRAINT [DF__employee__pub_id__276EDEB3]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[jobs]'
GO
ALTER TABLE [dbo].[jobs] DROP CONSTRAINT [DF__jobs__job_desc__1BFD2C07]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [aunmind] from [dbo].[authors]'
GO
DROP INDEX [aunmind] ON [dbo].[authors]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [titleind] from [dbo].[titles]'
GO
DROP INDEX [titleind] ON [dbo].[titles]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [employee_ind] from [dbo].[employee]'
GO
DROP INDEX [employee_ind] ON [dbo].[employee]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping trigger [dbo].[employee_insupd] from [dbo].[employee]'
GO
DROP TRIGGER [dbo].[employee_insupd]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[stores]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[stores] ALTER COLUMN [stor_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[stores] ALTER COLUMN [stor_name] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[stores] ALTER COLUMN [stor_address] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[stores] ALTER COLUMN [city] [nvarchar] (40) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [UPK_storeid] on [dbo].[stores]'
GO
ALTER TABLE [dbo].[stores] ADD CONSTRAINT [UPK_storeid] PRIMARY KEY CLUSTERED  ([stor_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[discounts]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[discounts] ALTER COLUMN [discounttype] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[discounts] ALTER COLUMN [stor_id] [char] (10) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[jobs]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[jobs] ALTER COLUMN [job_desc] [nvarchar] (200) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[employee]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[employee] ALTER COLUMN [fname] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[employee] ALTER COLUMN [lname] [nvarchar] (60) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[employee] ALTER COLUMN [pub_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [employee_ind] on [dbo].[employee]'
GO
CREATE CLUSTERED INDEX [employee_ind] ON [dbo].[employee] ([lname], [fname], [minit])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[publishers]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[publishers] ALTER COLUMN [pub_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[publishers] ALTER COLUMN [pub_name] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[publishers] ALTER COLUMN [city] [nvarchar] (40) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[publishers] ALTER COLUMN [country] [nvarchar] (60) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [UPKCL_pubind] on [dbo].[publishers]'
GO
ALTER TABLE [dbo].[publishers] ADD CONSTRAINT [UPKCL_pubind] PRIMARY KEY CLUSTERED  ([pub_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[pub_info]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[pub_info] ALTER COLUMN [pub_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [UPKCL_pubinfo] on [dbo].[pub_info]'
GO
ALTER TABLE [dbo].[pub_info] ADD CONSTRAINT [UPKCL_pubinfo] PRIMARY KEY CLUSTERED  ([pub_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[titles]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[titles] ALTER COLUMN [title] [nvarchar] (120) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[titles] ALTER COLUMN [pub_id] [char] (10) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[titles] ALTER COLUMN [notes] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [titleind] on [dbo].[titles]'
GO
CREATE NONCLUSTERED INDEX [titleind] ON [dbo].[titles] ([title])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[roysched]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[roysched] ADD
[roysched_id] [int] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [roysched_id] on [dbo].[roysched]'
GO
ALTER TABLE [dbo].[roysched] ADD CONSTRAINT [roysched_id] PRIMARY KEY CLUSTERED  ([roysched_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[sales]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[sales] ALTER COLUMN [stor_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[sales] ALTER COLUMN [ord_num] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[sales] ALTER COLUMN [payterms] [nvarchar] (24) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [UPKCL_sales] on [dbo].[sales]'
GO
ALTER TABLE [dbo].[sales] ADD CONSTRAINT [UPKCL_sales] PRIMARY KEY CLUSTERED  ([stor_id], [ord_num], [title_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[authors]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[authors] ALTER COLUMN [au_lname] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[authors] ALTER COLUMN [au_fname] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[authors] ALTER COLUMN [address] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[authors] ALTER COLUMN [city] [nvarchar] (40) COLLATE Latin1_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [aunmind] on [dbo].[authors]'
GO
CREATE NONCLUSTERED INDEX [aunmind] ON [dbo].[authors] ([au_lname], [au_fname])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Refreshing [dbo].[titleview]'
GO
EXEC sp_refreshview N'[dbo].[titleview]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[publishers]'
GO
ALTER TABLE [dbo].[publishers] ADD CHECK (([pub_id]='1756' OR [pub_id]='1622' OR [pub_id]='0877' OR [pub_id]='0736' OR [pub_id]='1389' OR [pub_id] like '99[0-9][0-9]'))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[employee]'
GO
ALTER TABLE [dbo].[employee] ADD CONSTRAINT [DF__employee__pub_id__4D94879B] DEFAULT ('9952') FOR [pub_id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[jobs]'
GO
ALTER TABLE [dbo].[jobs] ADD CONSTRAINT [DF__jobs__job_desc__4F7CD00D] DEFAULT ('New Position - title not formalized yet') FOR [job_desc]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[publishers]'
GO
ALTER TABLE [dbo].[publishers] ADD CONSTRAINT [DF__publisher__count__5070F446] DEFAULT ('USA') FOR [country]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[discounts]'
GO
ALTER TABLE [dbo].[discounts] ADD FOREIGN KEY ([stor_id]) REFERENCES [dbo].[stores] ([stor_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[employee]'
GO
ALTER TABLE [dbo].[employee] ADD FOREIGN KEY ([pub_id]) REFERENCES [dbo].[publishers] ([pub_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[pub_info]'
GO
ALTER TABLE [dbo].[pub_info] ADD FOREIGN KEY ([pub_id]) REFERENCES [dbo].[publishers] ([pub_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[titles]'
GO
ALTER TABLE [dbo].[titles] ADD FOREIGN KEY ([pub_id]) REFERENCES [dbo].[publishers] ([pub_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[sales]'
GO
ALTER TABLE [dbo].[sales] ADD FOREIGN KEY ([stor_id]) REFERENCES [dbo].[stores] ([stor_id])
GO
ALTER TABLE [dbo].[sales] ADD FOREIGN KEY ([title_id]) REFERENCES [dbo].[titles] ([title_id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering permissions on TYPE:: [dbo].[empid]'
GO
REVOKE REFERENCES ON TYPE:: [dbo].[empid] TO [public]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering permissions on TYPE:: [dbo].[id]'
GO
REVOKE REFERENCES ON TYPE:: [dbo].[id] TO [public]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering permissions on TYPE:: [dbo].[tid]'
GO
REVOKE REFERENCES ON TYPE:: [dbo].[tid] TO [public]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering extended properties'
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'Database_Info', N'[{"Name":"Pubs","Version":"2.1.7","Description":"The Pubs (publishing) Database supports a fictitious bookshop.","Modified":"2020-05-07","by":"PhilFactor"}]', NULL, NULL, NULL, NULL, NULL, NULL
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
