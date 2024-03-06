-- SECCIÓN 3 - GESTIÓN DE DATOS CON SQL

-- CREAR TABLAS TEMPORALES

/*
CREATE TABLE nueva_tabla
AS
SELECT columna1, columna2, ...
FROM tabla_origen
WHERE condicion;

*/

CREATE TABLE expVida AS
	SELECT C.name, C.LifeExpectancy
    FROM world.country AS C
    WHERE C.Continent = "Europe" AND C.LifeExpectancy IS NOT NULL
    ORDER BY C.LifeExpectancy
    LIMIT 5;
    
SELECT * FROM expVida
ORDER BY LifeExpectancy DESC, NAME DESC;

-- Ejercicio #1
-- Crear una tabla temporal llamada empleados_departamentos_x la cual contendrá la información de los empleados(nombre y salario) de la tabla empleados.
-- Estos empleados trabajan en el departamento X y ganan más de $1'200.000

CREATE TABLE empleados_departamentos_x
	SELECT E.Nombre, E.Salario
    FROM empleados AS E
    WHERE E.departamento="x";
    


-- Ejercicio #2
-- "Crear una nueva tabla llamada tempPais que contenga las columnas 'nombre' y 'población', seleccionando los registros de la tabla 'country'
-- donde la población sea igual o inferior a 100,000,000. La tabla se encuentra en la base de datos world


CREATE TABLE tempPais AS
SELECT NAME AS Nombre, population AS Población
FROM country
WHERE Population <= "100000000";

DROP tempPais;
    
    
DESCRIBE tempPais; -- desc <nombre de la tabla>

-- RELACIONES ENTRE TABLAS
-- Relacion de uno a muchos

CREATE SCHEMA biblioteca;

USE biblioteca;

-- Crear tabla libro
CREATE TABLE Libro (
	id INT PRIMARY KEY,
    Titulo VARCHAR(100),
    Autor VARCHAR(100)
);

-- Crear la tabla prestamos
CREATE TABLE Prestamo(
	id int primary key,
    id_libro int,
    fechaPrestamo date,
    fechaDevolucion date,
    foreign key (id_libro) references Libro(id)
);

-- RELACION DE MUCHOS A MUCHOS
-- Estudiante e Inscripción a cursos (N:M)
create table estudiante(
	id int primary key,
    nombre varchar(100)
);

create table curso (
	id int primary key,
    nombre varchar(100),
    descripcion text
);

create table inscripcion(
	idestudiante int,
    idcurso int,
    fechainscripcion date,
    primary key(idestudiante, idcurso),
    foreign key(idestudiante) references estudiante(id),
    foreign key(idcurso) references curso(id)
);


-- EJERCICIOS

-- Crear tabla pais
CREATE TABLE pais (
	id INT PRIMARY KEY,
    nombre VARCHAR(20),
    continente VARCHAR(50),
    poblacion INT
);

-- Crear la tabla ciudad
CREATE TABLE ciudad(
	id int primary key,
    nombre VARCHAR(20),
    id_pais INT,
    fechaDevolucion date,
    foreign key (id_pais) references pais(id)
);


CREATE TABLE idioma(
	id int primary key,
    idioma varchar(50)
);

CREATE TABLE Pais(
	id int primary key,
    nombre varchar(20),
    continente varchar(50),
    poblacion int
);

CREATE TABLE idioma_Pais (
	id_idioma int,
    id_pais int,
    primary key(id_idioma, id_pais),
    foreign key(id_idioma) references idioma(id),
    foreign key(id_pais) references Pais(id)
);

-- REVISION DE ESTRUCTURAS DE UNA TABLA

-- Comando DESCRIBE o desc

-- Comando SHOW COLUMNS FROM
USE mundo;
SHOW COLUMNS FROM tpais;

-- Comando: SHOW CREATE TABLE -> nos muestra como se creó la tabla

use biblioteca;
show create table inscripcion;

-- Comando: SHOW TABLE STATUS -> Información general de la tabla
show table status like "inscripcion";

-- Comando: IFORMATION_SCHEMA.TABLES y INFORMATION_SCHEMA.COLUMNS
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'inscripcion';

SELECT *
FROM information_schema.tables
WHERE table_schema = 'biblioteca';

-- Funciones y comandos en Campos en MySQL

-- 1. CONCAT : Concatena dos o más cadenas de texto.
use world;

select concat(name, " ", region) as ubicacion
from country
limit 5;

-- 2. UPPER: Convierte una cadena a mayúsculas.

SELECT upper(concat(name, " ", region)) as Ubicacion
FROM country
limit 5;

-- 3. LOWER: Convierte una cadena a minúsculas.

SELECT lower(concat(name, " ", region)) as Ubicacion
FROM country
limit 5;

-- 4. LENGTH: Devuelve la longitud de una cadena.

select (concat(name, " ", region)) as Ubicacion, length(concat(name, " ", region)) as Largo
from country
limit 5;

-- EJERCICIO
-- muestre un listado con los 3 paises con el nombre más largo. Ordenados del más largo al menor

select name, length(name) as largo, region
from country
order by largo desc
limit 3;

-- 5. Comando: SUBSTRING() Extrae una parte de una cadena.

select SUBSTRING(concat(name, " ", region),1, 3) as "sigla de la ubicacion"
from country
limit 5;

-- 6. Comando: LOCATE() Encuentra la posición de una subcadena

SELECT SUBSTRING(concat(name," ", region), 1, 3) as "Sigla de la ubicación",
	locate('g', SUBSTRING(concat(name, " ", region), 1, 3)) as POS_G
FROM country
LIMIT 5;

-- EJERCICIO
-- Construya un listado con el primer nombre de los paises con nombres compuestos.
-- Ordene el listado por nombre del país

SELECT Locate(' ', SUBSTRING(concat(name, " ", region), 1, 3)) as POS_G,
	SUBSTRING(concat(name," ", region), 1, POS_G) as "Sigla de la ubicación"
FROM country
LIMIT 5;

select substring(name,1, locate(' ', name)) as "nombre acotado", name as pais, locate(' ', name) as compuestp
from country
WHERE locate(' ', name) > 0
ORDER BY name
limit 10000;

-- 7. TRIM: elimina los espacios 
-- RTRIM -> elimina espacios a la derecha 
-- LTRIM -> elimina espacios a la izquierda

select TRIM(substr(name, 1, locate(' ', name))) as Primer_Nombre,
	name as pais,
    locate(' ', name) as compuesto
from country
where locate(' ', name) > 0
order by pais;

use world;

select name, replace(name, "Gu", "Yu") as REMPLAZO
from country
where region = "South America";

select name, locate('Gu', name) as RemYu,
replace(name, "Gu", "Yu") as REMPLAZO
from country
where region ="South America" and locate('Gu', name) > 0;


-- MAX() devuelve el valor máximo de una tabla
select max(lifeexpectancy) from country;

-- MIN() devuelve el valor mínimo de una tabla
select min(lifeexpectancy) from country;


-- DATE_FORMAT() Formatea una fecha
-- NOW() toma la fecha actual
select date_format(now(), '%d/%m/%Y') as fecha_col;

-- ROUND() redondea un numero y el número dice la cantidad de números redondeando el último


-- IF() Cálculos condicionales
select name, format(population, 0) as Poblacion,
if(population < 20000000, "Despoblado", if(population < 40000000, "Poblado", "Sobrepoblado")) as Estado
from country
where region = "South America";

-- EJERCICIO
-- Calcular la densidad de población de los paises de América
-- Si la densidad de población es mayor al 30 h/km2 entonces mostrar "super-poblado"
-- Si está entre [20 - 30]h/km2 está poblado
-- Si está entre [10 - 20]h/km2 está poco poblado
-- si es menor que el 10 h/km2 mostrar despoblado

select * from country;

select surfacearea, name, region, format(population, 0) as Poblacion, format((Population/surfacearea),0) as Densidad,
if ((Population/surfacearea) < 10, "Despoblado", 
if ((Population/surfacearea) < 20, "poco poblado", 
if ((Population/surfacearea) < 30, "Poblado", "super-poblado"))) as Estado
from country
where continent = "South America" or continent = "North America" 
order by Densidad desc;


-- TALLER
-- Cual es el idioma con el nombre más largo hablado en el mundo. También indique
-- qué países hablan ese idioma. El listado debe estar ordenado alfabéticamente por
-- nombre de país.

select * from countrylanguage;

select Language, CountryCode, length(Language) as Tamaño
from countrylanguage
where max(length(Language));

select * from country;

CREATE TABLE maxLang AS
	SELECT C.Language, C.CountryCode, C.max(length(Language))
    FROM world.countrylanguage AS C
    WHERE C.lenght = "Europe" AND C.LifeExpectancy IS NOT NULL
    ORDER BY C.LifeExpectancy
    LIMIT 5;

-- II. Muestre un listado del año de independencia de cada país. Si aún no se ha
-- independizado muestre el vano “N/A”

select * from country;

select name as Nombre,
if (indepYear is null, "N/A", indepYear) as Independencia
from country;

-- III. Muestre un listado con los países “recién independizados” y “antiguamente  independizados”. 
-- Es recién independizado si su fecha de independizado es  posterior a 1899. 

select name as Nombre,
if (indepYear > 1899, "Recién independizado", "Antiguamente independizado") as Independencia
from country
where indepYear is not null;

-- IV. Cuál es el promedio de nivel de vida de los países africanos.

select avg(lifeExpectancy) as Promedio_vida_África
from country
where continent = "Africa";

-- V. Cuál es el país con menor nivel de vida. 

select MIN(lifeExpectancy)
from country;

select name, lifeExpectancy
from country
where lifeExpectancy = 83.5;

-- VI. Cuál es el país con mayor nivel de vida. 

select MAX(lifeExpectancy)
from country;

select name, lifeExpectancy
from country
where lifeExpectancy = 37.2;

-- VII. Muestre un listado de los países de América y cuanta es la capacidad de repartir su  riqueza 
-- entre su densidad de población. GNP = PIB. El listado debe estar ordenado  descendentemente 
-- por capacidad de repartir riqueza, luego por nombre  ascendentemente. La capacidad de repartir 
-- riqueza debe mostrarse en separación de miles y con dos decimales.

select * from country;

use world;

select name,
region,
GNP,
format(Population,0) as Poblacion,
format(Surfacearea,0) as Area,
(Population/SurfaceArea) as Densidad,
format(GNP/(Population/SurfaceArea),2) as Capacidad_Riqueza
from country
where continent = "North America" or continent = "South America"
order by GNP/(Population/SurfaceArea) desc, name;

select name, 
substring(name, locate(' ', name) + 1) as SegundoNombre
from country
where continent = "Europe" and locate(' ', name) > 0;


select seg_nombre, 
	locate(" ", name) as pos2,
    if(locate(" ", seg_nombre) = 0,
		seg_nombre,
		substr(seg_nombre, 1, locate(" ", seg_nombre)-1)) as segundo_nombre
from
	(select name, 
		locate(" ", name) as esp1, 
		substr(name, locate(" ", name) + 1) as seg_nombre
from country
where Continent = "Europe" and locate(" ", name) > 0) as S;

-- Producto Cruz: todos los datos revueltos
select C.code, C.name, D.id, D.name, D.countrycode
from country as C, city as D;

-- Intersección INNER JOIN (NATURAL JOIN, JOIN)
-- Ciudades de Colombia
select P.name, C.name
from country as P
inner join city as C on P.code = C.countrycode
where P.name = "Colombia";


-- LEFT JOIN
-- Todos los elementos del conjunto A y donde no exista relación con B es Null
select L.language, P.name
from countrylanguage as L
left join country as P on L.countrycode = P.code;

select * from countrylanguage;


-- LEFT JOIN
-- Todos los elementos del conjunto B y donde no exista relación con A es Null
select P.name, C.name
from city as C
right join country as P on C.countrycode = P.code
where P.name = "Colombia";

desc countrylanguage;
insert into countrylanguage (countrycode, language, isofficial, percentage) values ("ZZZ", "Marciano", "T", "100");



-- Ejercicio de orquestas
select P.name, C.name
from country as P
inner join city as C on P.code = C.countrycode
where P.name = "Colombia";

select O,name, C.year
from orchestras as O
inner join concerts as C on O.city_origin = C.city
where C.year = 2013;

















