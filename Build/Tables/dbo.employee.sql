CREATE TABLE [dbo].[employee]
(
[emp_id] [dbo].[empid] NOT NULL,
[fname] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[minit] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[lname] [nvarchar] (60) COLLATE Latin1_General_CI_AS NOT NULL,
[job_id] [smallint] NOT NULL DEFAULT ((1)),
[job_lvl] [tinyint] NULL DEFAULT ((10)),
[pub_id] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL DEFAULT ('9952'),
[hire_date] [datetime] NOT NULL DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[employee] ADD CONSTRAINT [CK_emp_id] CHECK (([emp_id] like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR [emp_id] like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'))
GO
ALTER TABLE [dbo].[employee] ADD CONSTRAINT [PK_emp_id] PRIMARY KEY NONCLUSTERED  ([emp_id])
GO
CREATE CLUSTERED INDEX [employee_ind] ON [dbo].[employee] ([lname], [fname], [minit])
GO
ALTER TABLE [dbo].[employee] ADD FOREIGN KEY ([job_id]) REFERENCES [dbo].[jobs] ([job_id])
GO
ALTER TABLE [dbo].[employee] ADD FOREIGN KEY ([pub_id]) REFERENCES [dbo].[publishers] ([pub_id])
GO
