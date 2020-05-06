CREATE TABLE [dbo].[discounts]
(
[discounttype] [varchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[stor_id] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[lowqty] [smallint] NULL,
[highqty] [smallint] NULL,
[discount] [decimal] (4, 2) NOT NULL
)
GO
ALTER TABLE [dbo].[discounts] ADD CONSTRAINT [PK_discounts] PRIMARY KEY CLUSTERED  ([discounttype])
GO
ALTER TABLE [dbo].[discounts] ADD FOREIGN KEY ([stor_id]) REFERENCES [dbo].[stores] ([stor_id])
GO
