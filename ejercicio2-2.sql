-- INDICES EN MySQL

-- Creaciòn de indices

CREATE INDEX index_name
	ON table_name (column1, column2);
    

use world;

create index idx_name on country(name);

-- borrar indice
drop index idx_name on country;

-- Indice único sobre el nombre del país
create unique index idx_unq_name on country(name);

-- Crear índice de texto completo
create fulltext index idx_article_content on articles(content);

-- VISTAS 
CREATE VIEW vista_detalles_usuarios AS
	SELECT u.id, u.nombre, d.direccion, d.telefono
	FROM usuarios u
	JOIN detalles_usuario;

create view tPopulationCity as
    select *
        from (
            select Name as cityName, Population, CountryCode
            from city
            order by Population desc
        ) as ciudades

        inner join (
            select Code, Name as CountryName, Continent
                from country
        ) as countryFilter on ciudades.CountryCode = countryFilter.Code

        where Continent <> 'Oceania' and Continent <> 'Antarctica';



create or replace view view_PopulationCity as
    select *
        from (
            select Name as cityName, Population, CountryCode
            from city
            order by Population desc
        ) as ciudades

        inner join (
            select Code, Name as CountryName, Continent
                from country
        ) as countryFilter on ciudades.CountryCode = countryFilter.Code

        where Continent <> 'Oceania' and Continent <> 'Antarctica';

select *
    from (
        select *
        from (
            select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
            from view_PopulationCity
            where Continent = 'South America' or Continent = 'North America'
            order by Population desc
            limit 5
        ) as PopulationCitiesAmerica

        union

        select *
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from view_PopulationCity
                where Continent = 'Europe'
                order by Population desc
                limit 5
            ) as PopulationCitiesEurope

        union

        select *
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from view_PopulationCity
                where Continent = 'Asia'
                order by Population desc
                limit 5
            ) as PopulationCitiesAsia

        union

        select * 
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from view_PopulationCity
                where Continent = 'Africa'
                order by Population desc
                limit 5
            ) as PopulationCitiesAfrica
    ) as orderCitiesPopulation
    order by Continent asc, CityName desc;

set @continente := "Africa";

create or replace view PopulationCitiesAfrica as
	select * 
		from (
			select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
			from view_PopulationCity
			where Continent = @continent
			order by Population desc
			limit 5
            );
            
select *
from country;
            
select L.language, L.Percentage,
	if (L.IsOfficial = "F", "No oficial", "Oficial") as Tipo,
    case
		when L.IsOfficial = "F" then "No oficial"
        else "Oficial"
	end as Tipo2,
    case
		when L.Percentage < 0.3 then "Poco hablado"
        when L.percentage between 0.4 and 49 then "Medianamente hablado"
        else "Más hablado"
	end as Frecuencia
from world.countrylanguage as L
join world.country as P on L.CountryCode = P.Code
where P.name = "Colombia";


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
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


use tienda;

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los
-- productos de la base de datos.

select * from producto;
select * from fabricante;

-- Solucion aplicando Inner Join
select P.nombre, P.precio, F.nombre as Nombre_Fabricante
from producto as P
inner join fabricante as F on P.id_fabricante = F.id;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los
-- productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden
-- alfabético.

select P.nombre, P.precio, F.nombre as Nombre_Fabricante
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
order by Nombre_Fabricante;

-- 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del
-- fabricante y nombre del fabricante, de todos los productos de la base de datos.

select P. id, P.nombre, F.id as id_Fab, F.nombre as Nombre_Fabricante
from producto as P
inner join fabricante as F on P.id_fabricante = F.id;

-- 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más
-- barato.

select P.nombre, P.precio, F.nombre as Fab_nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where precio = (select MIN(precio) from producto);

-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más
-- caro.

select P.nombre, P.precio, F.nombre as Fab_nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where precio = (select MAX(precio) from producto);

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.
select P.nombre, P.precio, F.nombre as Fab_nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where F.nombre = "Lenovo";

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor
-- que 200€.

select *
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where F.nombre = "Crucial" and P.precio > 200;

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy
-- Seagate. Sin utilizar el operador IN.

select *
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where F.nombre = "Asus" or F.nombre = "Hewlett-Packard" or F.nombre = "Seagate";

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y
-- Seagate. Utilizando el operador IN.

select *
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where F.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo
-- nombre termine por la vocal e.

select P.nombre, P.precio, F.nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where SUBSTRING(F.nombre, length(F.nombre)) = "e";

-- 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de
-- fabricante contenga el carácter w en su nombre.

select P.nombre, P.precio, F.nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where SUBSTRING(F.nombre, length(F.nombre)) = "e";

select P.nombre, P.precio, F.nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where locate("w", F.nombre) > 0;

-- 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los
-- productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar
-- por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)

select P.nombre, P.precio, F.nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id
where P.precio >= 180
order by P.precio desc, P.nombre;

-- 13. Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos
-- fabricantes que tienen productos asociados en la base de datos.

select distinct F.id, F.nombre
from producto as P
inner join fabricante as F on P.id_fabricante = F.id;

-- 14. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
-- productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes
-- que no tienen productos asociados.

SELECT P.*, F.*
FROM producto P
LEFT JOIN fabricante F ON P.id_fabricante = F.id

union

SELECT P.*, F.*
FROM producto P
RIGHT JOIN fabricante F ON P.id_fabricante = F.id
WHERE P.id_fabricante IS NULL;

-- 15. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún
-- producto asociado.

SELECT F.*
from fabricante F
Left join producto P on P.id_fabricante = F.id
where P.id_fabricante IS NULL;

-- 16. ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su
-- respuesta.

-- Sí, si en la base de datos no se asigna dicho fabricante ni código o si el id_fabricante en el producto es null
INSERT INTO producto VALUES(12, 'Impresora HP', 100, null);

-- 17. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).

SELECT P.*
from fabricante F
Left join producto P on P.id_fabricante = F.id
where F.nombre = "Lenovo";

-- 18. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más
-- caro del fabricante Lenovo. (Sin utilizar INNER JOIN).

select *
from producto
where precio = (
	select max(P.precio)
	from fabricante F
	Left join producto P on P.id_fabricante = F.id
	where F.nombre = "Lenovo"
);

-- 19. Lista el nombre del producto más caro del fabricante Lenovo.

select nombre
from producto
where precio = (
	select max(P.precio)
	from fabricante F
	Left join producto P on P.id_fabricante = F.id
	where F.nombre = "Lenovo"
);

-- 20. Lista el nombre del producto más barato del fabricante Hewlett-Packard.

select nombre
from producto
where precio = (
	select min(P.precio)
	from fabricante F
	Left join producto P on P.id_fabricante = F.id
	where F.nombre = "Hewlett-Packard"
);

-- 21. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al
-- producto más caro del fabricante Lenovo.

select nombre, precio
from producto
where precio >= (
	select max(P.precio)
	from fabricante F
	Left join producto P on P.id_fabricante = F.id
	where F.nombre = "Lenovo"
);

-- 22. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio
-- de todos sus productos.

select P.nombre, P.precio
from producto P
inner join fabricante F on P.id_fabricante = F.id
where P.precio >= (
	select avg(P.precio)
	from producto as P
	)
	and F.nombre = "Asus";