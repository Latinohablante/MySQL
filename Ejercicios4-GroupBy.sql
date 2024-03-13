-- Guía 4 - GROUP BY

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
CREATE TABLE IF NOT EXISTS fabricante (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS producto (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE NOT NULL,
id_fabricante INT UNSIGNED NOT NULL,
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, "Asus");
INSERT INTO fabricante VALUES(2, "Lenovo");
INSERT INTO fabricante VALUES(3, "Hewlett-Packard");
INSERT INTO fabricante VALUES(4, "Samsung");
INSERT INTO fabricante VALUES(5, "Seagate");
INSERT INTO fabricante VALUES(6, "Crucial");
INSERT INTO fabricante VALUES(7, "Gigabyte");
INSERT INTO fabricante VALUES(8, "Huawei");
INSERT INTO fabricante VALUES(9, "Xiaomi");

INSERT INTO producto VALUES(1, "Disco duro SATA3 1TB", 86.99, 5);
INSERT INTO producto VALUES(2, "Memoria RAM DDR4 8GB", 120, 6);
INSERT INTO producto VALUES(3, "Disco SSD 1 TB", 150.99, 4);
INSERT INTO producto VALUES(4, "GeForce GTX 1050Ti", 185, 7);
INSERT INTO producto VALUES(5, "GeForce GTX 1080 Xtreme", 755, 6);
INSERT INTO producto VALUES(6, "Monitor 24 LED Full HD", 202, 1);
INSERT INTO producto VALUES(7, "Monitor 27 LED Full HD", 245.99, 1);
INSERT INTO producto VALUES(8, "Portátil Yoga 520", 559, 2);
INSERT INTO producto VALUES(9, "Portátil Ideapd 320", 444, 2);
INSERT INTO producto VALUES(10, "Impresora HP Deskjet 3720", 59.99, 3);
INSERT INTO producto VALUES(11, "Impresora HP Laserjet Pro M26nw", 180, 3);

-- 1. Calcula el número total de productos que hay en la tabla productos.

SELECT COUNT(*) as cant_productos FROM producto;

-- 2. Calcula el número total de fabricantes que hay en la tabla fabricante.

select count(nombre) as tot_fabric
from fabricante;

-- 3. Calcula el número de valores distintos de identificador de fabricante aparecen en la
-- tabla productos.

select count(DISTINCT id_fabricante) as fab_dist
from producto;

-- 4. Calcula la media del precio de todos los productos.

select avg(precio) as precio_prom
from producto;

-- 5. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que
-- tiene el fabricante Crucial.

select MAX(P.precio) as Max_Precio, MIN(P.precio) as Min_Precio, AVG(P.precio) as Prom_Precio, COUNT(id_fabricante) as Cant_Prod
from producto P
inner join fabricante F on P.id_fabricante = F.id
where F.nombre = "Crucial";

/*
6. Muestra el número total de productos que tiene cada uno de los fabricantes. El listado
también debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará
dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene.
Ordene el resultado descendentemente por el número de productos.
*/


SELECT nombre, count(id_fabricante) as cant_prod
FROM (
SELECT F.nombre, P.id_fabricante, P.id
FROM producto P
LEFT JOIN fabricante F on P.id_fabricante = F.id

UNION

SELECT F.nombre, P.id_fabricante, P.id 
FROM producto P
RIGHT JOIN fabricante F on P.id_fabricante = F.id
WHERE P.id_fabricante IS NULL) as todo
group by nombre, id_fabricante
order by cant_prod desc;

/*
7. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los
fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se
solicitan.
*/

SELECT nombre, 
count(id_fabricante) as cant_prod, 
max(precio) AS MAX, 
min(precio) AS MIN, 
avg(precio) AS PROM
FROM (
SELECT F.nombre, P.id_fabricante, P.id, P.precio
FROM producto P
LEFT JOIN fabricante F on P.id_fabricante = F.id

UNION

SELECT F.nombre, P.id_fabricante, P.id, P.precio
FROM producto P
RIGHT JOIN fabricante F on P.id_fabricante = F.id
WHERE P.id_fabricante IS NOT NULL) as todo
group by nombre, id_fabricante;

/*
8. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de
los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el
nombre del fabricante, con el identificador del fabricante es suficiente.
*/

SELECT id_fabricante, 
count(id_fabricante) as cant_prod, 
max(precio) AS MAX, 
min(precio) AS MIN, 
avg(precio) AS PROM
FROM (
SELECT F.nombre, P.id_fabricante, P.id, P.precio
FROM producto P
LEFT JOIN fabricante F on P.id_fabricante = F.id

UNION

SELECT F.nombre, P.id_fabricante, P.id, P.precio
FROM producto P
RIGHT JOIN fabricante F on P.id_fabricante = F.id
WHERE P.id_fabricante IS NOT NULL) as todo
group by nombre, id_fabricante
HAVING AVG(precio) > 200;

/*
9. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio
medio y el número total de productos de los fabricantes que tienen un precio medio superior
a 200€. Es necesario mostrar el nombre del fabricante.
*/
SELECT nombre, 
count(id_fabricante) as cant_prod, 
max(precio) AS MAX, 
min(precio) AS MIN, 
avg(precio) AS PROM
FROM (
SELECT F.nombre, P.id_fabricante, P.id, P.precio
FROM producto P
LEFT JOIN fabricante F on P.id_fabricante = F.id

UNION

SELECT F.nombre, P.id_fabricante, P.id, P.precio
FROM producto P
RIGHT JOIN fabricante F on P.id_fabricante = F.id
WHERE P.id_fabricante IS NOT NULL) as todo
group by nombre, id_fabricante
HAVING AVG(precio) > 200;

-- 10. Calcula el número de productos que tienen un precio mayor o igual a 180€.

select count(*)
from producto P
inner join fabricante F on P.id_fabricante = F.id
where precio >= 180;

-- 11. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a
-- 180€.

select F.nombre, count(P.id_fabricante) "cant. prod > 180"
from producto P
inner join fabricante F on P.id_fabricante = F.id
where P.precio >=180
group by  F.nombre
ORDER BY count(P.id_fabricante);










