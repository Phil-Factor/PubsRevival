SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[reptq3] @lolimit money, @hilimit money,
@type char(12)
AS
select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	case when grouping(TN.tag) = 1 then 'ALL' else TN.tag end as type, 
	count(titles.title_id) as cnt
from titles INNER JOIN tagtitle
ON TagTitle.title_id = titles.title_id
INNER JOIN dbo.TagName AS TN 
ON TN.TagName_ID = TagTitle.TagName_ID
where price >@lolimit AND is_primary=1 AND price <@hilimit AND TN.tag = @type OR TN.tag LIKE '%cook%'

group by pub_id, TN.tag with rollup

GO
