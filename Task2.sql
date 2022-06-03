--������ 2
/*
    2. �������� ���� ������, ������� �� ������ ������ ������� A ������ ��������� ��������:
    a. ����������� �������� �� ������� amount;
    b. ������������ �������� �� ������� amount;
    c. ����� �� ������� amount;
    d. ����� ���� ������������� �������� amount;
    e. ����� ���� ������������� �������� amount;
    f. ����� ���������� �������� � ������� amount.
*/
--------------------------------------������--------------------------------------    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[A]') AND type in (N'U'))
DROP TABLE [dbo].[A]
GO

create table A
(id int , amount int)
GO

insert into A
select 1, 500
union all 
select 2, 300
union all 
select 3, 100
union all 
select 4, -200
union all 
select 5, 100
union all 
select 6, 300
union all 
select 7, -200
union all 
select 8, -100

GO

--------------------------------------�������--------------------------------------

select min(amount) min_amount, max(amount) max_amount,
	   sum(amount) sum_amount, sum(case when amount > 0 then amount else 0 end) positive,
	   sum(case when amount < 0 then amount else 0 end) negative, count(distinct amount) count_ammount	
from A	   
