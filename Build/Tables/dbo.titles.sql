CREATE TABLE [dbo].[titles]
(
[title_id] [dbo].[tid] NOT NULL,
[title] [nvarchar] (120) COLLATE Latin1_General_CI_AS NOT NULL,
[type] [char] (12) COLLATE Latin1_General_CI_AS NOT NULL DEFAULT ('UNDECIDED'),
[pub_id] [char] (10) COLLATE Latin1_General_CI_AS NULL,
[price] [money] NULL,
[advance] [money] NULL,
[royalty] [int] NULL,
[ytd_sales] [int] NULL,
[notes] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL,
[pubdate] [datetime] NOT NULL DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[titles] ADD CONSTRAINT [UPKCL_titleidind] PRIMARY KEY CLUSTERED  ([title_id])
GO
CREATE NONCLUSTERED INDEX [titleind] ON [dbo].[titles] ([title])
GO
ALTER TABLE [dbo].[titles] ADD FOREIGN KEY ([pub_id]) REFERENCES [dbo].[publishers] ([pub_id])
GO
