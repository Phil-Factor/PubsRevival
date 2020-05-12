SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[reptq2] AS
select 
	case when grouping(TN.tag) = 1 then 'ALL' else TN.tag end as type, 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(ytd_sales) as avg_ytd_sales
from titles INNER JOIN tagtitle
ON TagTitle.title_id = titles.title_id
INNER JOIN dbo.TagName AS TN 
ON TN.TagName_ID = TagTitle.TagName_ID
where pub_id is NOT NULL AND is_primary=1
group by pub_id, TN.tag with rollup

GO
