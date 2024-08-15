
--Covid 19 Data Exploration 

/*Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types*/

create database ProjetoPortfolio

select * from ProjetoPortfolio..MortesCovid
where continent is not null
order by 3, 4

select * from ProjetoPortfolio..VacinacaoCovid
order by 'LOCATION','DATE'


/*seleciona dados  que nós vamos estar usando - select data that we are going to be using*/

SELECT Location, date, total_cases, new_cases, total_deaths, population 
from ProjetoPortfolio..MortesCovid
where continent is not null
order by 'LOCATION','DATE'



/*Procurar total de casos x total de mortes - looking at total case x total death */
/* Mostrar probabilidade de mortes se você contrair covid em seu país -
--Shows likelihood of dying if you contract covid in your country*/
--PESQUISANDO NO BRASIL
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 as PercentualMorte
from ProjetoPortfolio..MortesCovid
where location like '%brazil%'
and continent is not null
order by 'LOCATION','DATE'
/* Mostrar probabilidade de mortes se você contrair covid em seu país -
--Shows likelihood of dying if you contract covid in your country*/
--PESQUISANDO NO Estados Unidos
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentualMorte
from ProjetoPortfolio..MortesCovid
where location like '%states%'
and continent is not null
order by 1, 2


/*procurar em total de casos x população*/
-- Mostrar qual porcentagem da população pegou covid /
--Show what porcentage of population got covid

SELECT Location, date, population, total_cases, (total_cases/population)*100 as  PercentualPopulacaoInfectada 
from ProjetoPortfolio..MortesCovid
where location like '%brazil%'
--and continent is not null
order by 'LOCATION','DATE'



/* procurar nos países com mais alta taxa de infeccão comparada a população */
-- Countries with Highest Infection Rate compared to Population

SELECT Location, Population, Max(total_cases) as ContagemTaxaMaisAltaInfeccao,
Max((total_cases/population))*100 as PercentualPopulacaoInectada
from ProjetoPortfolio..MortesCovid
--where location like '%states$'--
group by location, population
order by  3, 4 


/*
-- Countries with Highest Death Count per Population / paises com maior contagem de mortes por população*/

Select Location, MAX(cast(Total_deaths as int)) as ContagemTotalMorte
from ProjetoPortfolio..MortesCovid
--Where location like '%states%'
Where continent is not null 
Group by Location
order by ContagemTotalMorte desc


SELECT Location, Population, Max(total_cases) as ContagemMaisAltaInfeccao,
Max((total_cases/population))*100 as PercentualPopulacaoInfectada 
from ProjetoPortfolio..MortesCovid
--where location like '%states$'--
group by location, population
order by PercentualPopulacaoInfectada Desc

/* Mostrando paises com mais alta contagem de morte por populacao - Showin countries with highest death count per population*/

/*SELECT Location,population, MAX(total_deaths) as TotalContagemMorte from ProjetoPortfolio..MortesCovid
--where location like '%states$'--
group by location, population
order by TotalContagemMorte desc*/


/* usando o cast muito provavelmente por cusa do tipo de dado pois total de mortes(total_deaths) está como varchar*/
SELECT Location, Max(cast(total_deaths as int)) as TotalContagemMorte from ProjetoPortfolio..MortesCovid
--where location like '%states$'--
where continent is not null
group by Location
order by TotalContagemMorte desc




/*vamos dividir por continente -let's break thing down by continent */
--showing continents with the highest death count per population./Mostrando os continentes com mais alto numeros de mortes
SELECT continent, Max(cast(total_deaths as int)) as TotalContagemMorte
from ProjetoPortfolio..MortesCovid
--where location like '%states$'--
where continent is not null
group by continent
order by TotalContagemMorte desc





--Global numbers
--Numeros Global
SELECT SUM(new_cases) as TotalCasos, Sum(cast(new_deaths as int)) as TotalMortes ,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as PercentualMortes
 from ProjetoPortfolio..MortesCovid
--where location like '%states$'--
where continent is not null
--group by date
order by 1, 2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine/
--Mostra porcentagem da população que tenha recebido pelo menos uma vacina de covid 
Select moc.continent,moc.location, moc.date, moc.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by moc.Location Order by moc.location, moc.Date) as AndamentoPessoaVacinada
--, (RollingPeopleVaccinated/population)*100
From ProjetoPortfolio..MortesCovid moc
Join ProjetoPortfolio..VacinacaoCovid vac
	On moc.location = vac.location
	and moc.date = vac.date
where moc.continent is not null 
order by 2,3




-- Using CTE to perform Calculation on Partition By in previous query /
--Usando CTE para executar Calculos em Partição pela query anterior
with PopvsVac (continent, Location, Date, Population, New_Vaccinationns, AndamentoPessoaVacinada)
as
(
select moc.continent, moc.location, moc.date, moc.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) over (Partition by moc.Location order by moc.location, moc.date) as AndamentoPessoaVacinada
--,(RollingPeopleVacinated/Population)*100
from ProjetoPortfolio..MortesCovid moc
join ProjetoPortfolio..VacinacaoCovid vac
   on moc.location = vac.location
   and moc.date = vac.date
where moc.continent is not null
--order by 2,3
)
Select *,(AndamentoPessoaVacinada/population)*100 as PercentualPessoaVacinada
from PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query /
-- Usando Tabela Temporária para executar Calculos na Partiçao pelo query anterior
Drop Table if exists #PercentualPopulacaoVacinada
Create Table #PercentualPopulacaoVacinada
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
AndamentoPessoaVacinada numeric)

Insert into #PercentualPopulacaoVacinada
Select moc.continent, moc.location, moc.date, moc.population,
vac.new_vaccinations,
SUM(Convert( int, vac.new_vaccinations)) Over (Partition by moc.Location Order by moc.location, 
moc.Date) as AndamentoPessoaVacinada
from ProjetoPortfolio..MortesCovid moc
join ProjetoPortfolio..VacinacaoCovid vac
   on moc.location = vac.location
    and moc.date = vac.date
--where moc.continent is not null
--order by 2.3
Select *, (AndamentoPessoaVacinada/Population)*100 as PercentualPopulacaoVacinada from #PercentualPopulacaoVacinada
 


 -- Creating View to store data for later visualizations
 --Criando view para armazenar dados para mais tarde visualizá-los

 
Create View PercentualPopulacaoVacinada as
Select dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations,
SUM(Convert( int, vac.new_vaccinations)) Over (Partition by dea.Location Order by dea.location,
dea.Date) as AndamentoPessoaVacinada
from ProjetoPortfolio..MortesCovid dea
join ProjetoPortfolio..VacinaCaoCovid vac
   on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
--order by 2.3

Select * from PercentualPopulacaoVacinada



 /*Renomeando nome das Colunas  atualizadas para o nome original*/
 
  EXEC sp_rename 'ProjetoPortfolio.dbo.MoradiaNashiville.EnderecoDaPropriedadeDividido', 'EnderecoDaPropriedade', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[CidadeDaPropriedadeDividido]', 'CidadeDaPropriedade', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[EnderecoDoProprietarioDividido]', 'EnderecoDaProprietario', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[CidadeDoProprietarioDividido]', 'CidadeDoProprietario', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[EstadoDoProprietarioDividido]', 'EstadoDoProprietario', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[DataDaVendaConvertido]', 'DataDaVenda', 'COLUMN';
	   
 */