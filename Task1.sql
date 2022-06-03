--������ 1
/*
���� ���������� SELECT ���������� ����� ������ ��������, 
���������� ������������� ��������� ������������ ��������.

���� ���������� SELECT �� ���������� �� ����� ������, 
���������� ��������� ���� ������� ��������. 
���� �������� expression �������� ��������� ��������� ��������, 
������� �� ���������� ��������, ���������� ��������� �������� NULL.
*/

--------------------------------------������--------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[A]') AND type in (N'U'))
DROP TABLE [dbo].[A]
GO

create table A
(id int , name varchar(10))
GO


insert into A
values (1, 'AAA')

insert into A
values (2, 'BBB')

insert into A
values (2, 'CCC')
GO

--------------------------------------�������--------------------------------------
 -- a
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 0
print @name
go
--�����: XXXX
-- b
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 1
print @name
go
--�����:  AAA
-- c
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 2
print @name
go
--�����: CCC

-- d
declare @name varchar(10); select @name = 'XXXX'
set @name = (select name from A where id = 0)
print @name
go
--�����: ������ ������, @name = null
declare @name varchar(10); select @name = 'XXXX'
set @name = (select name from A where id = 1)
print @name
go
--AAA

declare @name varchar(10); select @name = 'XXXX'
set @name = (select name from A where id = 2)
print @name
go
/*
�����:
��������� 512, ������� 16, ��������� 1, ������ 2
��������� ������ ������ ������ ������ ��������. ��� ���������, ����� ��������� ������ ������� ����� =, !=, <, <=, >, >= ��� ������������ � �������� ���������.
XXXX
*/


