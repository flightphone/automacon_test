--Задача 5
/*
Покупатель имеет бонусную карту, привязанную только к его номеру телефона. 
Покупатель может заменить бонусную карту по причине утери, либо какой-то другой. 
При этом все данные со старой карты клонируются на новую, включая номер телефона, 
а старая очищается. После этого старая карта считается свободной для следующей выдачи 
либо замены (переноса данных). Поскольку покупатель всегда имеет право поменять 
номер телефона и перепривязать бонусную карту к нему, идентифицируем покупателя 
на текущий момент как владельца той или иной бонусной карты.
Один покупатель не имеет права осуществлять более 5 переносов с карты на карту в год 
(@limit = 5). 
Есть процедура замены, получающая на вход два номера карты – текущий (@old_card) 
и новый (@new_card).
Требуется написать скрипт для нее, определяющий, позволяется ли покупателю 
осуществить текущий перенос (достиг ли он лимита), если лимит достигнут, 
когда он сможет в следующий раз воспользоваться заменой карты. 
*/

--------------------------------------Данные--------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cards_transfer]') AND type in (N'U'))
DROP TABLE [dbo].[cards_transfer]
GO

create table cards_transfer
(old_card varchar(16),
 new_card varchar(16),
 dt date
)
go

insert into cards_transfer
values(
'111',
'555',
'2020-01-09'
)
insert into cards_transfer
values(
'222',
'223',
'2020-02-10'
)
insert into cards_transfer
values('333',
'334',
'2020-03-11'
)
insert into cards_transfer
values('444',
'222',
'2020-04-12'
)
insert into cards_transfer
values('555',
'666',
'2020-05-12'
)
insert into cards_transfer
values('666',
'777',
'2020-06-13'
)
insert into cards_transfer
values('777',
'888',
'2020-07-14'
)
insert into cards_transfer
values('888',
'000',
'2020-08-15'
)
insert into cards_transfer
values('999',
'333',
'2020-09-16'
)
insert into cards_transfer
values('223',
'111',
'2020-10-16')

GO

--------------------------------------Решение--------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[test_transfer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[test_transfer]
GO

create procedure test_transfer
	    @test_date date,
		@test_id varchar(16),
		@limit int
as		

declare @date date, 
		@i int,
		@id varchar(16),
		@tmp_date date,
		@tmp_id varchar(16)

select @date = @test_date, @id = @test_id, @i = 0


while (@id is not null and @i < @limit)
begin
	select @tmp_date = null, @tmp_id = null
	
	select top 1 @tmp_id = old_card, @tmp_date = dt from  cards_transfer
	where new_card = @id and dt < @date
	order by dt desc
	
	set @i = @i + 1
	select @date = @tmp_date, @id = @tmp_id
end

declare @result int  --1 - если карточку заменить можно, 0 - если карточку заменить нельзя
set @result = case when @id is null then 1
			  else 
			  case when @test_date >= dateadd(yy, 1, @date) then 1 else 0 end
			  end


select @test_date test_date, @test_id test_id,
	   @date dateDeepLimit, dateadd(yy, 1, @date) aviableDate, @result result	

go

/*
Для решения написана процедура test_transfer

Входные параметы:
	    @test_date  -   Дата на которую определяется доступность смены карточки,
				    	для тестирования текущего момента @test_date = getdate()
		@test_id  -     id карточки
		@limit int  -   лимит переходов в год
		
Процедура возвращает одну строку с полями:

test_date -      Дата на которую определяется доступность смены карточки

test_id  -       id карточки

dateDeepLimit -  Дата, когда была произведена 5-ая (@limit) смена карточки, 
				 отсчитывая в обратном порядке от последней замены карточки.
				 Если число замен за всю историю до @test_date меньше @limit возвращается NULL

aviableDate -    Дата dateDeepLimit плюс один год. Если число замен за всю историю до @test_date
			     меньше @limit возвращается NULL
			  
result -         1 - заменить карточку можно, 0 - заменить карточку нельзя


В предложенном решении предполагается, что одному пользователю нельзя 
произвести несколько замен карточек в течении одного дня (одного момента времени)

Если пользователь может произвести несколько замен в течении одного дня, а в поле dt 		
хранить только дату (без времени замены), то задача решения не имеет.
*/
			
--------------------------------------Тесты--------------------------------------			

exec test_transfer '2022-06-03', '000', 5
exec test_transfer '2021-01-08', '000', 5
exec test_transfer '2021-01-09', '000', 5
exec test_transfer '2021-01-09', '334', 5
