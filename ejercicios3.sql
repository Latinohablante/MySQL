-- EJERCICIO DE CLASE

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
CREATE TABLE fabricante (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);
CREATE TABLE producto (
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

-- 1. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

SELECT distinct count(*)
from producto P 
inner join fabricante F on P.id_fabricante = F.id
where P.id_fabricante = F.id;
    
SELECT DISTINCT f.nombre
FROM fabricante f
inner join producto P on P.id_fabricante = f.id
WHERE (
    SELECT COUNT(*)
    FROM producto p
    WHERE p.id_fabricante = f.id
) >= 2;


-- 2. Devuelve un listado con los nombres de los fabricantes y el número de productos que
-- tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre
-- de los fabricantes que no tienen productos que cumplan la condición.

create view contador as 
	SELECT COUNT(*)
    FROM producto p
    inner join fabricante f
    WHERE p.id_fabricante = f.id  and p.precio > 220;

SELECT DISTINCT f.nombre
FROM fabricante f
WHERE contador >= 1;

/* 3. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio
superior o igual a $220. el listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante
que no tiene productos con un precio superior o igual a $220 deberá aparecer en el listado con un valor igual a 0
en el número de productos.

*/

CREATE OR REPLACE VIEW fabricantes_220 AS
select f1.nombre as fabricante, f1.id AS Id_view
FROM fabricante as f1, producto as p1
where p1.Precio >= 220 and f1.id = p1.id_fabricante;

SELECT distinct fabricante.nombre, 
(select count(Fabricante) 
	from fabricantes_220
	where Fabricante = fabricante.nombre) AS count_fabr 
FROM fabricante
LEFT JOIN (SELECT * FROM fabricantes_220) AS fabr_220 ON fabricante.id = Id_view
ORDER BY count_fabr desc;


