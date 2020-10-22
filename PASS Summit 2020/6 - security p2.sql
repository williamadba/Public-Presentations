--connect to your sample SQL Server, database summit2020
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

