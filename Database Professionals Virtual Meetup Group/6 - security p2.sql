--connect to your sample SQL Server, database test
--Log in with denyprincipal
/*

SELECT ORIGINAL_LOGIN(), CURRENT_USER;

*/

go
select * from dbo.DenyTable
go
select * from dbo.DenyTableview
go
exec dbo.DenyTablesproc
go
exec dbo.DenyTablesproc_adhoc
go
select * from dbo.DenyFunc()

