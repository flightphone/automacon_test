--������ 4
/*
������� � �������� ��������� ����������� ������. 
�������� ������, ������� ������� ����� ������. 
�������� ������, ������� �������� ���������� �� �������� ������ (����������� ����������� �������, ������������� ������ ��������, 
�������������� � �.�.).
*/

--------------------------------------������--------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[A]') AND type in (N'U'))
DROP TABLE [dbo].[A]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[A_tmp]') AND type in (N'U'))
DROP TABLE [dbo].[A_tmp]
GO

create table A
(
id int,
Name varchar(16),
property int,
[date] date
)
go


insert into A
select
1,
'AAA',
2,
'2020-10-11'
union all select
2,
'BBB',
0,
'2020-10-10'
union all select
2,
'BBB',
0,
'2020-10-10'
union all select
3,
'CCC',
3,
'2020-10-12'
union all select
4,
'DDD',
1,
'2020-10-12'
union all select
4,
'DDD',
1,
'2020-10-12'
union all select
4,
'DDD',
1,
'2020-10-12'
union all select
5,
'EEE',
2,
'2020-10-11'
union all select
6,
'FFF',
1,
'2020-10-13'
GO

--------------------------------------������� 1--------------------------------------
--�� ��������
select * from A
GO

select distinct id, Name, property, [date] into A_tmp from A

truncate table A

insert into A
select * from A_tmp

drop table A_tmp
GO

--����� ��������
select * from A
GO

--------------------------------------������� 2--------------------------------------

alter table A
add pk int identity(1,1)
go

--�� ��������
select * from A
GO

delete from A where pk not in
(
select max(pk) from A
group by id, Name, property, [date]
)

GO
--����� ��������
select * from A
GO
