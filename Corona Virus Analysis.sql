
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT *
FROM [master].[dbo].[Coronavirus]
WHERE Province IS NULL
   OR Country_Region IS NULL
   OR Latitude IS NULL
   OR Longitude IS NULL
   OR Date IS NULL
   OR Confirmed IS NULL
   OR Deaths IS NULL
   OR Recovered IS NULL;

--Q2. If NULL values are present, update them with zeros for all columns. 
UPDATE [master].[dbo].[Coronavirus]
SET Province = COALESCE(Province, 'zero'),
    [Country_Region] = COALESCE([Country_Region], 'zero'),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
    [Date] = COALESCE([Date], 'zero'),
    Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0);


-- Q3. check total number of rows

SELECT count(*) as total_number_of_rows
from [master].[dbo].[Coronavirus];
-- Q4. Check what is start_date and end_date

SELECT MIN(Date) as start_date ,MAX(Date) as end_date
FROM [master].[dbo].[Coronavirus];

-- Q5. Number of month present in dataset

SELECT COUNT(DISTINCT MONTH(Date)) AS number_of_months
FROM [master].[dbo].[Coronavirus];

-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT
    MONTH(Date) AS Month, 
    AVG(Confirmed) AS Avg_Confirmed, 
    AVG(Deaths) AS Avg_Deaths, 
    AVG(Recovered) AS Avg_Recovered
FROM [master].[dbo].[Coronavirus]
GROUP BY MONTH(Date)
ORDER BY MONTH(Date) ;



-- Q7. Find most frequent value for confirmed, deaths, recovered each month

SELECT 
    MONTH(Date) AS Month,
    MAX(CONFIRMED) AS MostFrequentConfirmed,
    MAX(DEATHS) AS MostFrequentDeaths,
    MAX(RECOVERED) AS MostFrequentRecovered
FROM 
    [master].[dbo].[Coronavirus]
GROUP BY 
    MONTH(Date)
ORDER BY 
     MONTH(Date);




-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS Year,
    MIN(CONFIRMED) AS MinimumConfirmed,
    MIN(DEATHS) AS MinimumDeaths,
    MIN(RECOVERED) AS MinimumRecovered
FROM 
    [master].[dbo].[Coronavirus]
GROUP BY 
    YEAR(Date);

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year,
    MAX(CONFIRMED) AS MaximumConfirmed,
    MAX(DEATHS) AS MaximumDeaths,
    MAX(RECOVERED) AS MaximumRecovered
FROM 
    [master].[dbo].[Coronavirus]
GROUP BY 
    YEAR(Date);

-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT 
    MONTH(Date) AS Month,
    SUM(CONFIRMED) AS TotalConfirmed,
    SUM(DEATHS) AS TotalDeaths,
    SUM(RECOVERED) AS TotalRecovered
FROM 
    [master].[dbo].[Coronavirus]
GROUP BY 
    MONTH(Date)
ORDER BY 
   MONTH(Date);


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )


SELECT 
    COUNT(CONFIRMED) AS TotalCONFIRMEDCases,
    AVG(CONFIRMED) AS AverageCONFIRMEDCases,
    VAR(CONFIRMED) AS VarianceCONFIRMEDCases,
    SQRT(VAR(CONFIRMED))  AS StandardCONFIRMEDCases
FROM 
    [master].[dbo].[Coronavirus]


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    MONTH(Date) AS Month,
    COUNT(DEATHS) AS TotalDeathCases,
    AVG(DEATHS) AS AverageDeathCases,
    VAR(DEATHS) AS VarianceDeathCases,
    SQRT(VAR(DEATHS))  AS StandardDeviationDeathCases
FROM 
    [master].[dbo].[Coronavirus]
GROUP BY 
    MONTH(Date);

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(RECOVERED) AS TotalRecoveredCases,
    AVG(RECOVERED) AS AverageRecoveredCases,
    VAR(RECOVERED)AS VarianceRecoveredCases,
    SQRT( VAR(RECOVERED)) AS StandardDeviationRecoveredCases
FROM 
    [master].[dbo].[Coronavirus]
GROUP BY 
    YEAR(Date), MONTH(Date);

-- Q14. Find Country having highest number of the Confirmed case

 SELECT Country_Region, SUM(Confirmed) As total_confirmed_cases
FROM [master].[dbo].[Coronavirus]
GROUP BY Country_Region
HAVING SUM(Confirmed) = (
    SELECT MAX(total_confirmed_cases)
    FROM (
        SELECT SUM(Confirmed) AS total_confirmed_cases
        FROM [master].[dbo].[Coronavirus]
        GROUP BY Country_Region
    ) AS subquery
);



-- Q15. Find Country having lowest number of the death case


SELECT Country_Region, SUM(Deaths) AS total_deaths
FROM [master].[dbo].[Coronavirus]
GROUP BY Country_Region
HAVING SUM(Deaths) = (
    SELECT MIN(total_deaths)
    FROM (
        SELECT SUM(Deaths) AS total_deaths
        FROM [master].[dbo].[Coronavirus]
        GROUP BY Country_Region
    ) AS subquery
);

-- Q16. Find top 5 countries having highest recovered case

SELECT TOP 5
Country_Region
FROM [master].[dbo].[Coronavirus]
GROUP BY Country_Region
ORDER BY SUM(Recovered) DESC;