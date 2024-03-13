create database prueba;

use prueba;


-- Creación de la tabla vehículo
CREATE TABLE vehiculo (
	vhc_id int primary key,
	marca varchar(50) not null,
    modelo varchar(50) not null,
    matricula varchar(50) not null,
    anioFabricacion int not null
);

-- creacion de la tabla empleado
CREATE TABLE empleado (
	e_id int primary key,
    apellidos varchar(50) not null,
    nombre varchar(50) not null,
    vhc_id int,
    foreign key (vhc_id) references vehiculo(vhc_id)
);

-- inserción de datos en la tabla vehiculo
insert into vehiculo (vhc_id, marca, modelo, matricula, aniofabricacion) values
(1, 'VW', 'Caddy', 'C 0000 YZ', 2016),
(2, 'Opel', 'Astra', 'C 0001 YZ', 2010),
(3, 'BMW', 'X6', 'C 0002 YZ', 2017),
(4, 'Porsche', 'Boxster', 'C 0003 YZ', 2018);

-- Inserción de datos en la tabla empleado
insert into empleado (e_id, apellidos, nombre, vhc_id) values
(1, 'García Hurtado', 'Macarena', 3),
(2, 'Ocaña Martinez', 'Francisco', 1),
(3, 'Gutierrez Doblado', 'Elena', 1),
(4, 'Hernández Soria', 'Manuela', 2),
(5, 'Oliva Cansino', 'Andrea', NULL);



select *
from empleado
left join vehiculo on empleado.vhc_id = vehiculo.vhc_id;

-- muestre empleados que no tienen vehiculo asignado
select *
from empleado
left join vehiculo on empleado.vhc_id = vehiculo.vhc_id
where vehiculo.vhc_id is null;

-- muestre todos los empleados que tienen un vehiculo asignado y la informacion de dichos vehiculos
select *
from empleado
left join vehiculo on empleado.vhc_id = vehiculo.vhc_id
where vehiculo.vhc_id is not null;

-- Muestre todos los emplados con los vehiculos que tengan asignados.
-- Si hay algún vehículo que no haya sido asignado, también mostrarlo.

select *
from empleado
right join vehiculo on empleado.vhc_id = vehiculo.vhc_id;


-- Conjunto completo de empleados y vehiculos, incluyendo todo

-- simulación de FULL JOIN con LEFT JOIN y RIGHT JOIN combinados con UNION
select E.*, V.*
from empleado E
left join vehiculo V on E.vhc_id = V.vhc_id

union

select E.*, V.*
from empleado E
right join vehiculo V on E.vhc_id = V.vhc_id;

-- WHERE E.vhc_id IS NULL;
-- Para evitar duplicados, se puede excluir las filas que ya aparecieron en el LEFT JOIN





-- EJERCICIOS DE CLASSROOM
create database world;
use world;
-- Con la base de datos Worl hacer las siguientes consultas

-- 1. Listar nombres de países y sus respectivas ciudades:

select Co.name, Ci.name
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode;

-- 		Mostrar todas las ciudades de colombia
select Co.name, Ci.name
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode
where Co.code = "Col";

-- 2. Continentes y sus poblaciones
-- Mostrar las 5 ciudades más pobladas de América, Europa, Asia y África

select Co.continent, Co.name, Ci.name, Ci.Population
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode
where Co.continent = "Europe"
order by Ci.Population desc, Ci.name
limit 5;


select continent
from country;

select * from
((select Co.continent, Co.name as Pais, Ci.name as City, Ci.Population
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode
where Co.continent = "North America" or Co.continent = "South America"
order by Ci.Population desc
limit 5)

union

(select Co.continent, Co.name as Pais, Ci.name as City, Ci.Population
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode
where Co.continent = "Africa"
order by Ci.Population desc
limit 5)

union

(select Co.continent, Co.name as Pais, Ci.name as City, Ci.Population
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode
where Co.continent = "Asia"
order by Ci.Population desc
limit 5)

union

(select Co.continent, Co.name as Pais, Ci.name as City, Ci.Population
from country AS Co
left join city AS Ci on Co.Code = Ci.CountryCode
where Co.continent = "Europe"
order by Ci.Population desc
limit 5)) as Todo
order by continent, City;

-- 3. Idiomas oficiales
-- 		Mostrar todos los países de África y sus idiomas oficiales. 
-- 		Ordenar el listado alfabéticamente

select Co.continent, Co.name, La.Language, La.IsOfficial
from country AS Co
left join countrylanguage AS La on Co.Code = La.CountryCode
where Co.continent = "Africa" and La.IsOfficial = "T"
order by La.Language;


-- 4. Capitales e idiomas
-- 		Listar todos los idiomas no oficiales hablados en Santander Colombia.

select * from city
where District = "Santander";

select * from countrylanguage
where CountryCode = "COL";

select distinct La.language
from city as Ci
join countrylanguage as La on Ci.CountryCode = La.CountryCode
where Ci.District = "Santander" and La.Isofficial="F";

select Ci.District, La.*
from city as Ci
left join countrylanguage as La on Ci.CountryCode = La.CountryCode
where Ci.District = "Santander" and La.Isofficial="F"

union

select Ci.District, La.*
from city as Ci
right join countrylanguage as La on Ci.CountryCode = La.CountryCode
where Ci.District = "Santander" and La.Isofficial="F" ;

-- 5. Paises sin lenguaje oficial
-- 		Encontrar los países que no tienen idioma oficial registrado.

select * from countrylanguage;

select Co.name, La.*
from country as Co
left join countrylanguage as La on Co.code = La.CountryCode
where La.Isofficial="F"

union

select Co.name, La.*
from country as Co
right join countrylanguage as La on Co.code = La.CountryCode
where La.Isofficial="F";

-- ejercicio número 6
-- paises que no tienen lenguaje oficial registrado
select distinct c.name, cl.countrycode
from countrylanguage as cl
inner join country as c on c.code = cl.countrycode
where cl.countrycode not in (select distinct countrycode
							 from countrylanguage
							 where IsOfficial="T" or IsOfficial is null);

select *
from countrylanguage
where countrycode = "ATA";

select *
from countrylanguage as cl
inner join country as c on c.code = cl.countrycode
where cl.countrycode not in (select distinct countrycode
							 from countrylanguage
							 where IsOfficial="T");


-- ejercicio 7

select *
from country as c
left join countrylanguage as cl on c.code = cl.countrycode
where c.continent = "Asia" and cl.language = "Spanish"
order by c.population desc;

-- CONSULTAS ANIDADAS
-- Mostrar una lista de paises donde su poblacion es mayor que el promedio de la poblacion de todos los los paises
-- consultas anidadas en el where

select name, Population
from country
where population > (select AVG(population) FROM country);

-- Consulta que calcula el promedio de población de todas las ciudades que pertenecen al país de Venezuela "VEN"
-- consultas anidadas en el from

select AVG(population)
from (select population
	  from city
      where countrycode = "VEN") AS ciudadesPais1;
      
-- Lista países de América con el número de ciudades
select name, (select count(*)
			  from city C
              where C.countrycode = P.code) AS NumeroCiudades
from country AS P
where P.continent = "North America" or P.continent = "South america"
Order By NumeroCiudades desc;

-- Ciudades de América cuya población es mayor que el promedio de las ciudades en su mismo paísavepoint

select C1.name, C1.population
from city AS C1
inner join country P on C1.countrycode = P.Code
where (P.continent = "North America" or P.continent= "South America") and
		C1.Population > (select avg(C2.Population) 
						 from city as C2
                         where C2.countrycode = C1.countrycode);
                         
                         
