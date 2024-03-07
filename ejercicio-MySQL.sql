create database world;

use world;

select name, lifeExpectancy
from country
where lifeExpectancy = 83.5;

select * from country;

-- I. Cuál es el idioma con el nombre más largo hablado en el mundo. 
-- También indique  qué países hablan ese idioma. El listado debe estar 
-- ordenado alfabéticamente por  nombre de país.

select * from countrylanguage;

select max(length(language)) from countrylanguage;

select countryCode, length(language), language
from countrylanguage
where length(language) = 25;

select name, Code
from country
where Code in ("DEU", "SWE");


-- VII. Países de américa ordenados por GNP/Densidad y por nombre

select name,
region,
GNP,
format(Population,0) as Poblacion,
format(Surfacearea,0) as Area, 
(Population/SurfaceArea) as Densidad,
format(GNP/(Population/SurfaceArea),2) as Capacidad_Riqueza
from country
where continent = "North America" or continent = "South America"
order by GNP/(Population/SurfaceArea), name;

-- VIII. Muestre los segundos nombres de los países de Europa. 
-- El listado debe estar  ordenado alfabéticamente por este segundo nombre

select * from country;

select name, 
substring(name, locate(' ', name) + 1) as SegundoNombre
from country
where continent = "Europe" and locate(' ', name) > 0;



-- IX. Muestre un listado de los países América y la cantidad de veces que aparece 
-- la  letra “A” en ellos. El listado debe estar ordenado por la cantidad de veces
--  que  aparece la letra A en el nombre del país. 

select * from country;

select name, 
length(name) - length(replace(lower(name), "a", "")) as A_numero
from country
where (continent = "North America" or continent = "South America")
and (length(name) - length(replace(lower(name), "a", ""))) <> 0
order by A_numero;

-- X. Muestre un listado de todos los países con un solo nombre que terminan en “bia”.  
-- Ordene este listado alfabéticamente por el nombre del país. 

select name
from country
where (length(name) - length(replace(lower(name), "bia", ""))) > 0 
and locate(' ', name) = 0
order by name;



-- 
-- 

select 
