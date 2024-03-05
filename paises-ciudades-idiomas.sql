use world;

SELECT * FROM country;

SELECT * FROM city;

SELECT * FROM countrylanguage;

-- mostrar el país con mayor población

SELECT Name, Population
FROM country
ORDER BY Population DESC
LIMIT 1;

-- mostrar las ciudades con población menor a 1 millon de habitantes. El listado debe estar ordenado por poblacion
-- de menor a mayor y si hay dos ciudades con la misma población mostrarlas en orden alfabético

SELECT Name, Population
FROM city
WHERE Population < 1000000
ORDER BY Population
LIMIT 10000;

-- mostrar los tres paises con mayor población de sur américa

SELECT Name, Region
FROM country
WHERE Region = "South America"
ORDER BY Population DESC
LIMIT 3;

-- mostrar los idiomas no oficiales hablados en Colombia. Los idiomas debe estar ordenados ascendentemente por el porcentaje de habla
-- el código de Colombia es "COL"

SELECT CountryCode, Language, Percentage
FROM countrylanguage
WHERE IsOfficial = "F" and CountryCode = "COL"
ORDER BY Percentage;

-- mostrar los 5 paises de Europa con menor expectativa de vida. Mostrar el listado descendentemente por la expectativa de vida y el nombre del país 

SELECT Name, LifeExpectancy, Continent
FROM country
WHERE Continent = "Europe" AND LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy, name
LIMIT 5;

SELECT * FROM (
SELECT Name, LifeExpectancy, Continent
FROM country
WHERE Continent = "Europe" AND LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy, name
LIMIT 5) country ORDER BY LifeExpectancy DESC;
