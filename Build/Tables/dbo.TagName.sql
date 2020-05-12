CREATE TABLE [dbo].[TagName]
(
[TagName_ID] [int] NOT NULL IDENTITY(1, 1),
[Tag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[TagName] ADD PRIMARY KEY CLUSTERED  ([TagName_ID])
GO
ALTER TABLE [dbo].[TagName] ADD UNIQUE NONCLUSTERED  ([Tag])
GO
