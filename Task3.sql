--������ 3
/*
� ������� A (������� id � integer identity primary key) ���� 2 ������. ��� ���������� ���������� �������

insert A(name) values('���C')
print @@identity
insert A(name) values('DDDD')
print @@identity
go

��������� ���������:

3
2

���������, ��� �� ����� ���� ������, � ��� �������� ����������� ���������� (4) �� ������ ������?
*/

/*
�����: ������� @@identity ���������� ��������� ����������� IDENTITY � ����. 
��������� �������� ���������, ���� � ������� A ��������� �������, ������� ��������� ������ �
������� B , ���� � ������� A ����������� �������� 'DDDD'. ��� ���� � ������� B ���� ���� IDENTITY
� ���� ������ @@IDENTITY ������ ����������� �������� �� ������ IDENTITY � ������� B.

��� ����, ����� �������������� �������� �������� �� ������� A ����� ������������ 
SCOPE_IDENTITY() ��� IDENT_CURRENT('A')
*/


