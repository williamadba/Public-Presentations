USE [master]
GO
/*

if (select LOGINPROPERTY('DenyPrincipal',null)) is not null
DROP LOGIN [DenyPrincipal] 
go
use securitydemo
go
if (select USER_ID('DenyPrincipal')) is not null
DROP USER [DenyPrincipal]
drop view if exists dbo.DenyTableview 
drop table if exists  dbo.DenyTable 
drop proc if exists dbo.DenyTablesproc
drop proc if exists dbo.DenyTablesproc_adhoc
drop function if exists dbo.DenyFunc


*/
use master
go
CREATE LOGIN [DenyPrincipal] WITH PASSWORD=N'deny', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
GRANT CONNECT SQL TO [DenyPrincipal]
ALTER LOGIN [DenyPrincipal] ENABLE
GO
use securitydemo
go
CREATE USER [DenyPrincipal] FOR LOGIN [DenyPrincipal]
GO



create table dbo.DenyTable (
id int identity(1,1) not null primary key,
text1 varchar(100)
)
go
insert into DenyTable (text1) values ('test')
go 3
go

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

deny select to [DenyPrincipal] --on the entire database!
go

revoke select to [DenyPrincipal]
go


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


CREATE FUNCTION dbo.DenyFunc ()
RETURNS TABLE
AS RETURN
	SELECT EXECFUNC = TEXT1 
	FROM dbo.DenyTable;
GO
GRANT SELECT ON dbo.DenyFunc TO [DenyPrincipal];
