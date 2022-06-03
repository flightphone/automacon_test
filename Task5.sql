--������ 5
/*
���������� ����� �������� �����, ����������� ������ � ��� ������ ��������. 
���������� ����� �������� �������� ����� �� ������� �����, ���� �����-�� ������. 
��� ���� ��� ������ �� ������ ����� ����������� �� �����, ������� ����� ��������, 
� ������ ���������. ����� ����� ������ ����� ��������� ��������� ��� ��������� ������ 
���� ������ (�������� ������). ��������� ���������� ������ ����� ����� �������� 
����� �������� � ������������� �������� ����� � ����, �������������� ���������� 
�� ������� ������ ��� ��������� ��� ��� ���� �������� �����.
���� ���������� �� ����� ����� ������������ ����� 5 ��������� � ����� �� ����� � ��� 
(@limit = 5). 
���� ��������� ������, ���������� �� ���� ��� ������ ����� � ������� (@old_card) 
� ����� (@new_card).
��������� �������� ������ ��� ���, ������������, ����������� �� ���������� 
����������� ������� ������� (������ �� �� ������), ���� ����� ���������, 
����� �� ������ � ��������� ��� ��������������� ������� �����. 
*/

--------------------------------------������--------------------------------------
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

--------------------------------------�������--------------------------------------
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

declare @result int  --1 - ���� �������� �������� �����, 0 - ���� �������� �������� ������
set @result = case when @id is null then 1
			  else 
			  case when @test_date >= dateadd(yy, 1, @date) then 1 else 0 end
			  end


select @test_date test_date, @test_id test_id,
	   @date dateDeepLimit, dateadd(yy, 1, @date) aviableDate, @result result	

go

/*
��� ������� �������� ��������� test_transfer

������� ��������:
	    @test_date  -   ���� �� ������� ������������ ����������� ����� ��������,
				    	��� ������������ �������� ������� @test_date = getdate()
		@test_id  -     id ��������
		@limit int  -   ����� ��������� � ���
		
��������� ���������� ���� ������ � ������:

test_date -      ���� �� ������� ������������ ����������� ����� ��������

test_id  -       id ��������

dateDeepLimit -  ����, ����� ���� ����������� 5-�� (@limit) ����� ��������, 
				 ���������� � �������� ������� �� ��������� ������ ��������.
				 ���� ����� ����� �� ��� ������� �� @test_date ������ @limit ������������ NULL

aviableDate -    ���� dateDeepLimit ���� ���� ���. ���� ����� ����� �� ��� ������� �� @test_date
			     ������ @limit ������������ NULL
			  
result -         1 - �������� �������� �����, 0 - �������� �������� ������


� ������������ ������� ��������������, ��� ������ ������������ ������ 
���������� ��������� ����� �������� � ������� ������ ��� (������ ������� �������)

���� ������������ ����� ���������� ��������� ����� � ������� ������ ���, � � ���� dt 		
������� ������ ���� (��� ������� ������), �� ������ ������� �� �����.
*/
			
--------------------------------------�����--------------------------------------			

exec test_transfer '2022-06-03', '000', 5
exec test_transfer '2021-01-08', '000', 5
exec test_transfer '2021-01-09', '000', 5
exec test_transfer '2021-01-09', '334', 5
