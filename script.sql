CREATE DATABASE IF NOT EXISTS  mundo;

USE mundo;

CREATE TABLE IF NOT EXISTS pais (
	id INT,
    nombre VARCHAR(20),
    continente VARCHAR(50),
    poblacion int
);

CREATE TABLE Temp (
	id INT,
    dato VARCHAR(20)
);

DROP TABLE IF EXISTS Temp;

ALTER TABLE pais ADD PRIMARY KEY(id);

DESCRIBE pais;

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (101,"Colombia", "Sur América", 50000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (102,"Ecuador", "Sur América", 17000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (103,"Guatemala", "Centro América", 17000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (104,"México", "Centro América", 126000000),
(105,"Estados Unidos", "Norte América", 331000000),
(106,"Canadá", "Norte América", 38000000);

SELECT * FROM pais;

DELETE FROM pais WHERE id=102 OR id=103;

-- ACTUALIZAR DATOS

/*
UPDATE nombre_de_la_tabla
SET columna1 = valor1, columna2 = valor2, ...
WHERE condicion;
*/

UPDATE pais
SET poblacion = 50887423
WHERE id = 101;

-- clonar la tabla a una tabla temporal
CREATE TABLE tpais AS SELECT * FROM pais;

-- BORRADO DE DATOS

/* Sintaxis del borado de datos DML
	DELETE FROM nombre_de_la_tabla
    WHERE condicion;
    
    DELETE FROM nombre_de_la_tabla
    WHERE condicion
    LIMIT cantidad_de_registros;
*/

DELETE FROM tpais;

-- ELIMINAR TODOS LOS REGISTROS DE UNA TABLA

-- TRUNCATE ES DDL
TRUNCATE TABLE temp;

SELECT * FROM pais;

DELETE FROM pais WHERE id=106;

-- DQL: SELECT
/*
	SELECT nombre_de_los_campos
    FROM nombre_de_las_tablas
    WHERE condicion;
*/

-- mostrar un listado con todos los países registrados en la tabla "país",

SELECT * nombre
FROM pais;

-- mostrar un listado de todos los paises de la tabla pais ordenados alfabeticamente.

SELECT nombre
FROM pais
ORDER BY nombre;

-- mostrar un listado de todos los paises de la tabla pais ordenados alfabeticamente de forma descendente(z-a).

SELECT nombre
FROM pais
ORDER BY nombre DESC;

-- mostrar el país con mayor poblacion

SELECT nombre, poblacion
FROM pais
ORDER BY poblacion DESC
LIMIT 1;

-- ALIAS DE CAMPOS

SELECT nombre AS País, poblacion AS Población
FROM pais
ORDER BY poblacion DESC
LIMIT 1;

-- ALIAS DE TABLAS

SELECT P.nombre as País, P.poblacion AS Poblacion
FROM pais AS P
ORDER BY P.población DESC
LIMIT 1;

-- OPERADORES DE COMPARACION EN EL WHERE
/*

*/

-- OPERADORES LOGICOS EN EL WHERE
/*
"AND"	Ambas son verdaderas
"OR"	Una condicion verdadera
"NOT"	invierte el resultado
*/

--  Mostrar el listado de los países ordenados alfabéticamente con población menor a 100 millones

SELECT P.nombre as País, P.poblacion AS Poblacion
FROM pais AS P
WHERE poblacion < 100000000
ORDER BY P.nombre;
LIMIT 1;

-- Mostrar el listado de los 2 países con menor población ordenados por la población y el nombre del país

SELECT nombre, poblacion
FROM pais
ORDER BY poblacion ASC, nombre ASC
LIMIT 2

CREATE DATABASE world;