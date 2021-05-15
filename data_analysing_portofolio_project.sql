use portofolioproject ;
show tables ;


# Geting infection spred from higest to lowest for countries 
select location, sum(  new_cases ) as total_cases_per_country,  population, ( sum(  new_cases ) / population ) * 100 as infected_percent
from coviddeaths 
where location not like "" && location not like "location" && continent not like "" 
group by location 
having infected_percent >= 1
order by 1, 4 desc ;

# Getting data for Albania
select location, date, new_cases,  population from coviddeaths 
where location like "Albania" 
&& new_cases > 0 
order by 2;

# Getting trend data for Albania
select location, date, total_cases,  population from coviddeaths 
where location like "Albania" && new_cases > 0 
order by 2;






# Geting icu_patients vs total_cases  ratio spred from higest to lowest for countries 
select location,  sum( icu_patients ) as icu_patients_per_country,  max( total_cases ) as total_cases , (  sum( icu_patients)  / max( total_cases ) ) * 100 as total_icu_patients
from coviddeaths 
where location not like "location" && continent not like "" 
group by location 
having total_icu_patients >= 1
order by 1, 4 desc ;


# Getting trend data for icu_patients in Albania
select location, date, icu_patients,  new_cases , (   icu_patients / new_cases ) * 100 as icu_patients_new_infections_ratio  from coviddeaths 
where location like "Albania" 
order by 2 ;

# Geting deth vs total_cases_per_country from higest to lowest for countries 
select location, sum(  new_cases ) as total_cases_per_country,  max(total_deaths) as total_deaths_country  , ( max(  total_deaths ) / sum(  new_cases ) ) * 100 as death_inection_ratio_percent
from coviddeaths 
where location not like "" && location not like "location" && continent not like "" && total_deaths > 0 
group by location 
having death_inection_ratio_percent >= 1
order by 1, 4 desc ;


create view temptable as 
select location,   new_cases ,  new_deaths  , (   new_deaths  /   new_cases  ) * 100 as death_infection_ratio_percent from coviddeaths where new_deaths > 0 ;


# Geting deth vs new_cases from higest to lowest for countries 
select location,   new_cases ,  new_deaths  ,  death_infection_ratio_percent
from temptable
where location  like "Albania" && new_deaths > 0 &&  death_infection_ratio_percent > 0
order by 1, 4 desc ;


select v.date , d.location, v.new_tests, d.new_cases, (d.new_cases/ v.new_tests ) * 100 as infection_spread_rate 
from covidvaccinations as v 
inner join coviddeaths as d on v.location = d.location && d.date = v.date 
where d.location like "Albania" && d.new_cases > 0 
order by 1 asc , 2 ;

select d.date, d.location, v.new_tests, v.new_vaccinations, d.new_deaths, d.new_cases
from covidvaccinations as v 
inner join coviddeaths as d on v.location = d.location && d.date = v.date 
where d.location like "Albania" && d.new_deaths > 0 && d.new_cases > 0 && v.new_vaccinations > 0
order by 1 asc ;




 select location, ( max(total_deaths) / population ) * 100 as deaths_per_country_percent
 from coviddeaths
 where continent like 'Europe' 
 group by location 
 order by 2 asc ;

