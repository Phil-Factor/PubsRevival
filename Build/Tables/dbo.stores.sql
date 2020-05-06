CREATE TABLE [dbo].[stores]
(
[stor_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[stor_name] [nvarchar] (40) COLLATE Latin1_General_CI_AS NULL,
[stor_address] [nvarchar] (40) COLLATE Latin1_General_CI_AS NULL,
[city] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[state] [char] (2) COLLATE Latin1_General_CI_AS NULL,
[zip] [char] (5) COLLATE Latin1_General_CI_AS NULL
)
GO
ALTER TABLE [dbo].[stores] ADD CONSTRAINT [UPK_storeid] PRIMARY KEY CLUSTERED  ([stor_id])
GO
