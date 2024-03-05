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




