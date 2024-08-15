--CREATE DATABASE Alpinet

/*create table DadosFuncionario (
funcionarioID int,
primeironome varchar(50),
segundonome varchar(50),
idade int,
genero varchar(50)
)*/

/*create table SalarioFuncionario(
funcionarioId int,
titulocargo varchar(50),
salario int)*/

/*insert into DadosFuncionario Values
(1001, 'Alan', 'Santos', 44, 'Masculino'),
(1002, 'Anderson', 'Oliveira', 42, 'Masculino'),
(1003, 'Maria', 'Conceicao', 34, 'Feminino'),
(1004, 'Antonio', 'Jesus', 54, 'Masculino'),
(1005, 'Carlos', 'Pereira', 32, 'Masculino'),
(1006, 'Adriana', 'Mendes', 33, 'Feminino'),
(1007, 'Marcia', 'Menezes', 27, 'Feminino'),
(1008, 'Valter', 'Fagunde', 51, 'Masculino'),
(1009, 'Felipe', 'Abreu', 38, 'Masculino'),
(1010, 'Dara', 'Souza', 41, 'Feminino')
*/
/*CREATE TABLE dbo.doc_exy (column_a INT );  
GO  
INSERT INTO dbo.doc_exy (column_a) VALUES (10);  
GO  
ALTER TABLE dbo.doc_exy ALTER COLUMN column_a DECIMAL (5, 2);  
GO*/
--alter table SalarioFuncionario alter column salario Decimal (5,3)
/*insert into SalarioFuncionario Values
(1001, 'Analista de Dados',  6.000),
(1002, 'Contador', 4.200 ),
(1003, 'Analista Financeira', 3.400),
(1004, 'Gerente regional', 5.400),
(1005,  'Programador', 3.200),
(1006,  'Marketing', 3.300),
(1007, 'Analista de RH', 2.700),
(1008,  'Vendedor', 5.100),
(1009,  'Estoque', 3.800),
(1010,  'Atendente', 4.100)*/

--select * from SalarioFuncionario

/* select Statement
*, Top, Distinct, Count, As, Max, Min, Avg
*/

/*select Top 5 * from DadosFuncionario
Select Distinct(salario) from SalarioFuncionario
Select Count(salario) from SalarioFuncionario
select max(salario) from SalarioFuncionario
select min(salario) from SalarioFuncionario

select * from DadosFuncionario


select avg(salario)as mediasalarial from SalarioFuncionario 


select * from Alpinet.dbo.DadosFuncionario
*/


/*
Where Statement
= , <>, <, >, And, Or, like, Null, Not Null, In
*/
/*
select * from DadosFuncionario
where primeironome ='Alan'

select * from DadosFuncionario
where primeironome <>'Alan'

select * from DadosFuncionario
where idade >'30'

select * from DadosFuncionario
where idade >= '30'and genero ='masculino'


select * from DadosFuncionario
where idade >= '30'or genero ='masculino'





select * from DadosFuncionario
where segundonome Like 'S%' 
--#começa com S


select * from DadosFuncionario
where segundonome Like '%S%' 
/*tem S em todo lugar do campo*/

select * from DadosFuncionario
where segundonome Like 'S%o%'
--#começa com "S" e tem "o" em todo lugar 

select * from DadosFuncionario
where segundonome is Not Null

select * from DadosFuncionario
where primeironome in ('Alan', 'Dara')*/


/* Group By, Order By
*/
/*

select genero, Count(genero) from DadosFuncionario
Group By genero

select genero, Count(genero)  as CounterGender from DadosFuncionario
where idade > 31
Group By genero
order by 1 desc, 2 desc


select genero, Count(genero) as ContandoGenero from DadosFuncionario
--where idade > 31
Group By genero
Order By  genero desc, ContandoGenero desc


select genero, Count(genero) from DadosFuncionario
Group By genero
Order By 1 Desc, 2 Desc
*/
/*
Inner joins, Full/Left/Right Outer joins
*/

/*
select * from Alpinet.dbo.DadosFuncionario
Inner Join Alpinet.dbo.SalarioFuncionario
   On DadosFuncionario.funcionarioId = SalarioFuncionario.FuncionarioID


   select * from Alpinet.dbo.DadosFuncionario
Full Outer Join Alpinet.dbo.SalarioFuncionario
    On DadosFuncionario.funcionarioId = SalarioFuncionario.FuncionarioID


	select * from Alpinet.dbo.DadosFuncionario
left Outer Join Alpinet.dbo.SalarioFuncionario
   On DadosFuncionario.funcionarioId = SalarioFuncionario.FuncionarioID


   	select * from Alpinet.dbo.DadosFuncionario
right Outer Join Alpinet.dbo.SalarioFuncionario
   On DadosFuncionario.funcionarioId = SalarioFuncionario.FuncionarioID


   select titulocargo, AVG(salario) as mediasalario from Alpinet.dbo.DadosFuncionario
inner Join  Alpinet.dbo.SalarioFuncionario
    On DadosFuncionario.funcionarioId = SalarioFuncionario.FuncionarioID
where titulocargo ='contador'
group by titulocargo 
*/

/* Union , Union All */

/*
select * from Alpinet.dbo.DadosFuncionario
union all
select * from Alpinet.dbo.SalarioFuncionario
order by funcionarioID*/

/*funcioa quando tem colunas iguais e do mesmo tipo*/
/* Case Statement */
/*
Select primeironome, segundonome, idade,
Case
   when idade > 30 Then 'velho'
   when idade Between 27 and 30 Then 'jovem'
   else 'Baby'
End
From Alpinet.dbo.DadosFuncionario
Where idade is not null
order by idade



Select primeironome, segundonome, titulocargo, salario,
Case
   when titulocargo ='Programador' Then salario + (salario * .10)
   when titulocargo ='Contador' then salario + (salario* .05)
   when titulocargo ='Marketing' then salario + (salario * .000001)
else Salario + (Salario * .03)
End as SalarioAposAumento
From Alpinet.dbo.DadosFuncionario
inner Join  Alpinet.dbo.SalarioFuncionario
    On DadosFuncionario.funcionarioId = SalarioFuncionario.FuncionarioID


	*/

/* Having clause */
/*
select titulocargo, count(titulocargo) as quantidadecargo
from Alpinet.dbo.DadosFuncionario
Join  Alpinet.dbo.SalarioFuncionario
    on DadosFuncionario.funcionarioID = SalarioFuncionario.funcionarioID
Group by titulocargo
having Count(titulocargo) = 1


select titulocargo, avg(salario)
from Alpinet.dbo.DadosFuncionario
Join Alpinet.dbo.SalarioFuncionario
  on DadosFuncionario.funcionarioID = SalarioFuncionario.funcionarioID
  Group by titulocargo
having avg(salario) > 3.500
Order by avg(salario) 

select * from  Alpinet.dbo.SalarioFuncionario*/

/* update , delete clause */
/*
update Alpinet.dbo.DadosFuncionario
Set funcionarioId =1020
where primeironome ='Alan' and segundonome ='santos' 

 select * from Alpinet.dbo.DadosFuncionario

update Alpinet.dbo.DadosFuncionario
Set idade =31, genero ='feminino'
where funcionarioId =1010

Delete From Alpinet..SalarioFuncionario
where funcionarioId =1013

 select * from Alpinet..SalarioFuncionario

 */

 /* Aliasing */
/*sELECT Demo.funcionarioid, Sal.salario
From [Alpinet].[dbo].[DadosFuncionario] as Demo
Join [Alpinet].[dbo].[SalarioFuncionario] as Sal
on Demo.funcionarioID = Sal.funcionarioID

sELECT a.funcionarioid, a.primeironome, b.titulocargo, c.idade 
From [Alpinet].[dbo].[DadosFuncionario] a
left Join [Alpinet].[dbo].[SalarioFuncionario] b
   on a.funcionarioid = b.funcionarioid
left Join [Alpinet].[dbo].[DadosFuncionario] c 
   on a.funcionarioid = c.funcionarioid
   */

   
/* Partition by diferença com group by*/

/*
select primeironome, segundonome, genero, salario,
 count(genero) over (Partition By genero) as totalGender
From [Alpinet].[dbo].[DadosFuncionario] dem
Join [Alpinet].[dbo].[SalarioFuncionario] sal
    on dem.funcionarioid = sal.funcionarioid

select primeironome, segundonome, genero, salario
  , count(genero) 
From Alpinet..DadosFuncionario dem
Join Alpinet..SalarioFuncionario sal
    on dem.funcionarioid = sal.funcionarioid
group by primeironome, segundonome, genero, salario

select genero, count(genero) 
From Alpinet..DadosFuncionario dem
Join Alpinet..SalarioFuncionario sal
      on dem.funcionarioid = sal.funcionarioid
 group by genero
 */

/* CTEs */

/* WITH CTE_Func 
 AS
(
Select primeironome, segundonome, genero, salario,
 Count(genero) over (Partition by genero) as Totalgender,
 Avg(salario) over (partition by salario) as avgSalary
  from  Alpinet..DadosFuncionario emp
   Join Alpinet..SalarioFuncionario sal
     on emp.funcionarioid = sal.funcionarioid
   Where (salario > 4.500 )
 )
--Select primeironome, avgSalary from CTE_Func
   select * from CTE_Func
   */

   
/*Temp Tables*/
/*
Drop Table if Exists #Temp_Funcionario
CREATE TABLE #Temp_Funcionario(
funcionarioid int,
titulocargo varchar(50),
age int,
salario decimal(5,3))

insert into #Temp_Funcionario values(11,'Pogramador', 35, 8.000)

select titulocargo, count(titulocargo), avg(idade), avg(salario)
from Alpinet..DadosFuncionario daf
Join Alpinet..SalarioFuncionario sal
   on daf.funcionarioID = sal.funcionarioID
group by titulocargo

Alter table #Temp_Funcionario drop column age 
Alter table #Temp_Funcionario add idade int
--alter table SalarioFuncionario alter column age idade
select * from #Temp_Funcionario

update #Temp_Funcionario 
Set salario=8.000 
where funcionarioid =11
*/


/* String Functions - Trim, Ltrim, Rtrim, Replace, Sbstring, Upper, Lower

-- Drop TableEmployeeErrors;
*/
/*
create table EmployeeErros(
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
)
 
insert into EmployeeErros Values('1000  ', 'jimbo', 'halbert'),
('  1001', 'jimbo1', 'halbert1'),
('1002', 'jimbO2', 'halbert-2'),
('1020', 'Alan', ' santos ')

select *from EmployeeErros

-- using Trim, ltrim, rtrim

select EmployeeID, Trim(EmployeeID) as IDTRIM from EmployeeErros


select EmployeeID, lTrim(EmployeeID) as IDTRIM from EmployeeErros

select EmployeeID, rTrim(EmployeeID) as IDTRIM from EmployeeErros

--using replace

select LastName, replace(LastName, '-2', '-0') as lastnamefixed from EmployeeErros

--using substring

select substring(err.FirstName, 1,3), substring(dem.primeironome, 1,3) from EmployeeErros err
join DadosFuncionario dem
  on substring(err.FirstName, 1,3) = substring(dem.primeironome,1,3)

  select *from DadosFuncionario
-- using upper and lower

select firstname, lower(firstName) from EmployeeErros

select firstname, upper(firstName) from EmployeeErros
*/

/*
stored procedure
*/

 /* CREATE PROCEDURE testando
as 
 Begin
  select * from DadosFuncionario
  end;
exec testando;*/


create procedure tempfunc
as 
SELECT * from #Temp_Funcionario
exec tempfunc
drop table #Temp_Funcionario
drop procedure #Temp_Funcionario

Alter Procedure tempfunc
 @titulocargo nvarchar(50)
as
/*
CREATE TABLE #Temp_Funcionario(
funcionarioId int,
titulocargo varchar(50),
idade int,
salario decimal (5,3)
)*/
Begin

--insert into #Temp_Funcionario(titulocargo,idade, salario)
select titulocargo, idade, salario, count(titulocargo), avg(idade) , avg(salario)
from Alpinet..DadosFuncionario emp
Join Alpinet..SalarioFuncionario sal
   on emp.funcionarioId = sal.funcionarioId
where titulocargo = @titulocargo
group by titulocargo, idade,salario
end;
exec tempfunc @titulocargo = 'Programador'

SELECT * from #Temp_Funcionario

/* Subqueries (in the Select, From, and Where Statement)
*/


-- Subquery in select

Select funcionarioID, salario, (select avg(salario) from SalarioFuncionario) as allavgsalary
from SalarioFuncionario

-- how to do it with partition by

Select funcionarioID, salario, avg(salario) over () as allavgsalary
from SalarioFuncionario

-- why group by doesn't work

Select funcionarioID, salario, avg(salario)  as allavgsalary
from SalarioFuncionario
group by funcionarioID, salario
having avg(salario)> 3.000
order by 1,2;

-- subquery in from
select  a.funcionarioID, allavgsalary 
from (select funcionarioID, salario, AVG(salario) over () as allavgsalary from SalarioFuncionario) a


-- subquery in where
select funcionarioID, titulocargo, salario
from SalarioFuncionario
where funcionarioID in(
select * /*erro , pois tem que especificar colunas*/
from DadosFuncionario)


select funcionarioID, titulocargo, salario
from SalarioFuncionario
where funcionarioID in(
select funcionarioID
from DadosFuncionario
 where idade >30)

