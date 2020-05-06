CREATE TABLE [dbo].[discounts]
(
[discounttype] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[stor_id] [char] (10) COLLATE Latin1_General_CI_AS NULL,
[lowqty] [smallint] NULL,
[highqty] [smallint] NULL,
[discount] [decimal] (4, 2) NOT NULL
)
GO
ALTER TABLE [dbo].[discounts] ADD FOREIGN KEY ([stor_id]) REFERENCES [dbo].[stores] ([stor_id])
GO
