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

/*
SEGUNDA PARTE
EJERCICIO DE TIENDA INFORMÁTICA
*/

DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;
CREATE TABLE cliente (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
ciudad VARCHAR(100),
categoría INT UNSIGNED
);
CREATE TABLE comercial (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
comisión FLOAT
);
CREATE TABLE pedido (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
total DOUBLE NOT NULL,
fecha DATE,
id_cliente INT UNSIGNED NOT NULL,
id_comercial INT UNSIGNED NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES cliente(id),
FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);
INSERT INTO cliente VALUES(1, "Aarón", "Rivero", "Gómez", "Almería", 100);
INSERT INTO cliente VALUES(2, "Adela", "Salas", "Díaz", "Granada", 200);
INSERT INTO cliente VALUES(3, "Adolfo", "Rubio", "Flores", "Sevilla", NULL);
INSERT INTO cliente VALUES(4, "Adrián", "Suárez", NULL, "Jaén", 300);
INSERT INTO cliente VALUES(5, "Marcos", "Loyola", "Méndez", "Almería", 200);
INSERT INTO cliente VALUES(6, "María", "Santana", "Moreno", "Cádiz", 100);
INSERT INTO cliente VALUES(7, "Pilar", "Ruiz", NULL, "Sevilla", 300);
INSERT INTO cliente VALUES(8, "Pepe", "Ruiz", "Santana", "Huelva", 200);

INSERT INTO cliente VALUES(9, "Guillermo", "López", "Gómez", "Granada", 225);
INSERT INTO cliente VALUES(10, "Daniel", "Santana", "Loyola", "Sevilla", 125);
INSERT INTO comercial VALUES(1, "Daniel", "Sáez", "Vega", 0.15);
INSERT INTO comercial VALUES(2, "Juan", "Gómez", "López", 0.13);
INSERT INTO comercial VALUES(3, "Diego","Flores", "Salas", 0.11);
INSERT INTO comercial VALUES(4, "Marta","Herrera", "Gil", 0.14);
INSERT INTO comercial VALUES(5, "Antonio","Carretero", "Ortega", 0.12);
INSERT INTO comercial VALUES(6, "Manuel","Domínguez", "Hernández", 0.13);
INSERT INTO comercial VALUES(7, "Antonio","Vega", "Hernández", 0.11);
INSERT INTO comercial VALUES(8, "Alfredo","Ruiz", "Flores", 0.05);
INSERT INTO pedido VALUES(1, 150.5, "2017-10-05", 5, 2);
INSERT INTO pedido VALUES(2, 270.65, "2016-09-10", 1, 5);
INSERT INTO pedido VALUES(3, 65.26, "2017-10-05", 2, 1);
INSERT INTO pedido VALUES(4, 110.5, "2016-08-17", 8, 3);
INSERT INTO pedido VALUES(5, 948.5, "2017-09-10", 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, "2016-07-27", 7, 1);
INSERT INTO pedido VALUES(7, 5760, "2015-09-10", 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, "2017-10-10", 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, "2016-10-10", 8, 3);
INSERT INTO pedido VALUES(10, 250.45, "2015-06-27", 8, 2);
INSERT INTO pedido VALUES(11, 75.29, "2016-08-17", 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, "2017-04-25", 2, 1);
INSERT INTO pedido VALUES(13, 545.75, "2019-01-25", 6, 1);
INSERT INTO pedido VALUES(14, 145.82, "2017-02-02", 6, 1);
INSERT INTO pedido VALUES(15, 370.85, "2019-03-11", 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, "2019-03-11", 1, 5);

-- 1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.

SELECT SUM(total) as Suma_total FROM pedido;

-- 2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.

SELECT AVG(total) as Suma_total FROM pedido;

-- 3. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.

select count(distinct P.id_comercial) as Comerc_distintos
from pedido P
inner join comercial Co on P.id_comercial = Co.id;

-- 4. Calcula el número total de clientes que aparecen en la tabla cliente.

select count(distinct P.id_cliente) as Cliente_num
from pedido P
inner join cliente Cl on P.id_comercial = Cl.id;

-- 5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.

SELECT MAX(total) as MAX_cant FROM pedido;

-- 6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.

SELECT MIN(total) as MIN_cant FROM pedido;

-- 7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece
-- en la tabla cliente.

select ciudad, MAX(categoría) as Max_cat
from cliente
group by ciudad;

/* 
8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada
uno de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de
diferentes cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo
valor para cada uno de los días en los que un cliente ha realizado un pedido. Muestra el
identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
*/

select max(total), 
P.id_cliente,
Cl.nombre,
Cl.apellido1,
Cl.apellido2,
P.fecha,
P.total
from pedido P
inner join cliente Cl on P.id_comercial = Cl.id
group by P.fecha, Cl.nombre, Cl.apellido1, Cl.apellido2, P.total;

/* 
9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada
uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que
superen la cantidad de 2000 €.
*/


/* 
10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales
durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y
total.
*/