/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions,
Aggregate Functions, Creating Views, Converting Data Types

*/

/*
CovidDeath Dataset
*/
--select all the countries not the continent
select * from portfolioproject..CovidDeaths
where continent is not null
order by 3,4



--looking for Total cases vs total death and know the percentage of it 

select location,date,total_cases,total_deaths,((total_cases/population)*100) as Deathpercentage , population
from portfolioproject..CovidDeaths
where continent is not null
order by 1,2



--looking at countries with highest infection cases rate it compare to population

select location,population,MAX(total_cases) as HighestInfection ,  MAX(total_cases/Population)*100 as PercentpopulationInfection
from portfolioproject..CovidDeaths
where continent is not null
Group by location ,population
order by HighestInfection desc

-- looking at countries with highest Death count  per population

select location,population,MAX(cast(total_deaths as int)) as TotalDeathcount 
from portfolioproject..CovidDeaths
where continent is not null
Group by location ,population
order by TotalDeathcount desc



-- select the continents with hightest covid death
select location,MAX(cast(total_deaths as int)) as TotalDeathcount 
from portfolioproject..CovidDeaths
where continent is  null 
Group by location
order by TotalDeathcount desc

-- select the continents with hightest covid cases
select location,MAX(cast(total_cases as int)) as Totalcases 
from portfolioproject..CovidDeaths
where continent is  null 
Group by location
order by Totalcases desc

-- Gloabal Numbers 

select  date,sum(cast(new_cases as int)) as totalcases,SUM(cast(new_deaths as int))as totaldeaths
, sum(cast(new_deaths as int))/SUM(new_cases)*100 as deathprecentage
from portfolioproject..CovidDeaths
where continent is not null
group by date
order by 1


select  sum(cast(new_cases as int)) as totalcases,SUM(cast(new_deaths as int))as totaldeaths
, sum(cast(new_deaths as int))/SUM(new_cases)*100 as deathprecentage
from portfolioproject..CovidDeaths
where continent is not null
--group by date
order by 1,2



----------------------------------------------------------------------------------
-- covidvaccination

select * from portfolioproject..CovidVaccinations



--total death vs vaccination vs population

select da.continent, da.location,da.population,da.total_deaths, dv.new_vaccinations
from portfolioproject..CovidVaccinations as dv
join portfolioproject..CovidDeaths as da
on dv.location = da.location
and da.date=dv.date
where da.continent is not null
order by 2,3

--looking at the sum of the new vaccination per day and location

select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(Convert(int,cv.new_vaccinations) )over (partition by cd.location order by cd.location, cd.date) as new_vaccination_per_day_and_location
from portfolioproject..CovidDeaths as cd
join portfolioproject..CovidVaccinations as cv
on cd.date = cv.date and
cd.location  = cv.location
where cd.continent is not null
 


 --use CTE 
 --to take the percentage of the people that are vaccinations from population
 -- replace the null with isnull function to 0.

 with Nvacperday (continent, location , date, population,new_vaccinations,new_vaccination_per_day_and_location)
 as (
	 select cd.continent,cd.location,cd.date,cd.population,isnull(cv.new_vaccinations,0),
	sum(Convert(int,isnull(cv.new_vaccinations,0)) )over (partition by cd.location order by cd.location, cd.date) as new_vaccination_per_day_and_location
	from portfolioproject..CovidDeaths as cd
	join portfolioproject..CovidVaccinations as cv
	on cd.date = cv.date and
	cd.location  = cv.location
	where cd.continent is not null
	--order by 2,3
 ) 
 select *,(new_vaccination_per_day_and_location/population)*100 as percentageOfvaccination
 from Nvacperday

 --temporary table for percentage POP vaccination

 drop table if exists #percentagePOPvaccinationforcountries
 create table #percentagePOPvaccinationforcountries
 (
 continent nvarchar(255),
 location nvarchar(255),
 date datetime,
 population numeric,
 new_vaccinations numeric,
 new_vaccination_per_day_and_location numeric
 )


 insert into #percentagePOPvaccinationforcountries
 select cd.continent,cd.location,cd.date,cd.population,isnull(cv.new_vaccinations,0),
	sum(Convert(int,isnull(cv.new_vaccinations,0)) )over (partition by cd.location order by cd.location, cd.date) as new_vaccination_per_day_and_location
	from portfolioproject..CovidDeaths as cd
	join portfolioproject..CovidVaccinations as cv
	on cd.date = cv.date and
	cd.location  = cv.location
	where cd.continent is not null

 select *,(new_vaccination_per_day_and_location/population)*100 as percentageOfvaccination
 from #percentagePOPvaccinationforcountries




 create view percentagePOPvaccination
 as 
  select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
	sum(Convert(int,isnull(cv.new_vaccinations,0)) )over (partition by cd.location order by cd.location, cd.date) as new_vaccination_per_day_and_location
	from portfolioproject..CovidDeaths as cd
	join portfolioproject..CovidVaccinations as cv
	on cd.date = cv.date and
	cd.location  = cv.location 
	where cd.continent is not null

select continent,location,date,population,isnull(new_vaccinations,0) 
as new_vaccinations ,new_vaccination_per_day_and_location
from percentagePOPvaccination


