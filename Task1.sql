--Задача 1
/*
Если инструкция SELECT возвращает более одного значения, 
переменной присваивается последнее возвращенное значение.

Если инструкция SELECT не возвращает ни одной строки, 
переменная сохраняет свое текущее значение. 
Если аргумент expression является скалярным вложенным запросом, 
который не возвращает значений, переменная принимает значение NULL.
*/

--------------------------------------Данные--------------------------------------
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

--------------------------------------Решение--------------------------------------
 -- a
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 0
print @name
go
--Ответ: XXXX
-- b
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 1
print @name
go
--Ответ:  AAA
-- c
declare @name varchar(10); select @name = 'XXXX'
select @name = name from A where id = 2
print @name
go
--Ответ: CCC

-- d
declare @name varchar(10); select @name = 'XXXX'
set @name = (select name from A where id = 0)
print @name
go
--Ответ: пустая строка, @name = null
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
Ответ:
Сообщение 512, уровень 16, состояние 1, строка 2
Вложенный запрос вернул больше одного значения. Это запрещено, когда вложенный запрос следует после =, !=, <, <=, >, >= или используется в качестве выражения.
XXXX
*/


