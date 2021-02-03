/*
--connect to your sample SQL Server, database 20201204-wda-elastice-job-agent-server.database.windows.net. This script is designed for Azure SQL DB or SQL Server partially contained databases.

if exists (select * from sys.database_principals where name = 'DenyPrincipal') 
DROP USER [DenyPrincipal]
drop view if exists dbo.DenyTableview 
drop table if exists  dbo.DenyTable 
drop proc if exists dbo.DenyTablesproc
drop proc if exists dbo.DenyTablesproc_adhoc
drop function if exists dbo.DenyFunc

*/
 
CREATE USER [DenyPrincipal] WITH PASSWORD=N'deny123!'
GO

CREATE TABLE dbo.DenyTable (
id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
text1 VARCHAR(100)
)
GO
INSERT INTO DenyTable (text1) VALUES ('test')
GO 3
GO

create view dbo.DenyTableview with schemabinding as
select selectview = text1 from dbo.DenyTable 
go
grant select on dbo.DenyTableview to [DenyPrincipal]
go

deny select on dbo.DenyTable to [DenyPrincipal]
go

create proc dbo.DenyTablesproc as
begin
select execsproc = text1 
from dbo.DenyTable 
end
GO
grant execute on dbo.DenyTablesproc to [DenyPrincipal]
GO

CREATE FUNCTION dbo.DenyFunc ()
RETURNS TABLE
AS RETURN
	SELECT EXECFUNC = TEXT1 
	FROM dbo.DenyTable;
GO
GRANT SELECT ON dbo.DenyFunc TO [DenyPrincipal];
GO

create proc dbo.DenyTablesproc_adhoc 
as
begin
declare @sql nvarchar(1000)
select @sql = 'select execsproc_adhoc = text1 from dbo.DenyTable'
exec sp_executesql @SQL
end
go
grant execute on dbo.DenyTablesproc_adhoc to [DenyPrincipal]
GO

