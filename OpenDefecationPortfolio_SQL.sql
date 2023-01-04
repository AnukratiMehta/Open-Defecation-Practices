select * from Cholera
where Year like 2000

select * from Mortality
where Year like 2000
order by Year, Country

select * from ODP
where Year like 2000 or year like 2020

INSERT INTO Mortality(Year, Country, Sex, [Mortality rate])
VALUES (2000, 'India', 'Both sexes', 91.76777);

Select DISTINCT
Country, year, SUM([Population Percentage]) OVER (partition by country) as sum
from ODP
where Year like 2016

-- Used for Tableau [Open Defecation & Mortality Rate of Children < 5 (2000)]
SELECT Cholera.Country, Cholera.[Number of Reported Deaths] as 'Reported Cholera Deaths', SUM(ODP.[Population Percentage]) as 'Openly Defecating Population', Mortality.[Mortality rate] as 'Mortality Rate', Mortality.Sex
from Cholera
inner join ODP
on Cholera.Country = odp.Country and Cholera.Year = odp.Year
inner join Mortality
on Cholera.Country = Mortality.Country and Cholera.Year = Mortality.Year
where Cholera.year like 2000
group by Cholera.Country, Cholera.Year, Cholera.[Number of Reported Deaths], Mortality.[Mortality rate], Mortality.Sex


-- Used for Tableau [Cholera (1993 to 2000)] Part 1
SELECT * FROM Cholera
WHERE year IN (
  SELECT year
  FROM Cholera
  GROUP BY year
  HAVING COUNT(DISTINCT country) = (SELECT COUNT(DISTINCT country) FROM Cholera)
)

-- Used for Tableau [Cholera (1993 to 2000)] Part 2
SELECT Country, Year, [Number of Reported Cases], [Number of Reported Deaths], ([Number of Reported Deaths]/[Number of Reported Cases])*100 as 'Fatality Rate' 
FROM Cholera
WHERE country IN ('Afghanistan', 'India', 'China', 'Bangladesh', 'Sri Lanka') AND year IN (
  SELECT year
  FROM Cholera
  WHERE country IN ('Afghanistan', 'India', 'China', 'Bangladesh', 'Sri Lanka')
  GROUP BY year
  HAVING COUNT(DISTINCT country) = (SELECT COUNT(DISTINCT country) FROM Cholera WHERE country IN ('Afghanistan', 'India', 'China', 'Bangladesh', 'Sri Lanka'))
)

-- Used for Tableau [Open Defecation (2000 to 2020)]
SELECT Country, Year, SUM([Population Percentage]) as 'Population Percentage'
FROM odp
WHERE country IN ('Afghanistan', 'India', 'China', 'Bangladesh', 'Sri Lanka') AND
year like 2000 or
country IN ('Afghanistan', 'India', 'China', 'Bangladesh', 'Sri Lanka') AND
year like 2020 
GROUP BY Country, Year


