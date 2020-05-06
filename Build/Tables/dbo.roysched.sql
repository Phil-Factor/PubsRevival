CREATE TABLE [dbo].[roysched]
(
[title_id] [dbo].[tid] NOT NULL,
[lorange] [int] NULL,
[hirange] [int] NULL,
[royalty] [int] NULL,
[roysched_id] [int] NOT NULL IDENTITY(1, 1)
)
GO
ALTER TABLE [dbo].[roysched] ADD CONSTRAINT [roysched_id] PRIMARY KEY CLUSTERED  ([roysched_id])
GO
CREATE NONCLUSTERED INDEX [titleidind] ON [dbo].[roysched] ([title_id])
GO
ALTER TABLE [dbo].[roysched] ADD FOREIGN KEY ([title_id]) REFERENCES [dbo].[titles] ([title_id])
GO
