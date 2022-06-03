--«адача 1
/*
≈сли инструкци€ SELECT возвращает более одного значени€, 
переменной присваиваетс€ последнее возвращенное значение.

≈сли инструкци€ SELECT не возвращает ни одной строки, 
переменна€ сохран€ет свое текущее значение. 
≈сли аргумент expression €вл€етс€ скал€рным вложенным запросом, 
который не возвращает значений, переменна€ принимает значение NULL.
*/

--------------------------------------ƒанные--------------------------------------
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

--------------------------------------–ешение--------------------------------------
 -- a
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 0
print @name
go
--ќтвет: XXXX
-- b
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 1
print @name
go
--ќтвет:  AAA
-- c
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 2
print @name
go
--ќтвет: CCC

-- d
declare @name varchar(10); select @name = 'XXXX'
set @name = (select name from A where id = 0)
print @name
go
--ќтвет: пуста€ строка, @name = null
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
ќтвет:
—ообщение 512, уровень 16, состо€ние 1, строка 2
¬ложенный запрос вернул больше одного значени€. Ёто запрещено, когда вложенный запрос следует после =, !=, <, <=, >, >= или используетс€ в качестве выражени€.
XXXX
*/


