--connect to your sample SQL Server, database 20201204-wda-elastice-job-agent-server.database.windows.net
--Log in with denyprincipal
/*

SELECT ORIGINAL_LOGIN();

*/

go
select * from dbo.DenyTable
go
select * from dbo.DenyTableview
go
exec dbo.DenyTablesproc
go
select * from dbo.DenyFunc()
go
exec dbo.DenyTablesproc_adhoc


