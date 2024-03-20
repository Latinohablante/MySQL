-- Active: 1710891568848@@127.0.0.1@3306
CREATE DATABASE world;
    DEFAULT CHARACTER SET = 'utf8mb4';

USE world;

SELECT NAME
FROM country
WHERE NAME LIKE "Co%";

select name
from country
where name like "%cia";

-- COMODIN _ : Representa un único caracter
SELECT *
from country
where name like "F___ce";

select *
from country
where name like "_%san%_";

SELECT *
from country
where name like "%a%" and name like "%e%" and name like "%i%" and name like "%o%" and name like "%u%";

SELECT *
from country
where trim(name) like "% %";

-- Comodines: %, _

-- Listar los paises que no contengan la expresión USA en su nombre

SELECT *
from country
where name not like "%USA%";


-- Listar todos los países donde el continente sea América

select *
from country
where continent like "%America%"


/*
** Concejos: Optimización de consultas
*/
create database biblioteca;
use biblioteca;

create table libros (
    ID int auto_increment,
    Titulo varchar(100),
    Autor varchar(100),
    Anio int,
    primary key (ID)
);

select * from Libros where Autor = "Gabriel Garcia Marquez";

create index idx_autor on Libros (Autor);

select * from Libros where Anio > 2000 and Autor in ("Autor1", "Autor2", "Gabriel Garcia Marquez");

create index idx_anio_autor on libros (Anio, Autor);


-- Evitar subconsultas innecesarias
select nombre
from usuarios
where id_usuario in (
                    select id_usuario
                    from compras);


select distinct usuarios.nombre
from usuarios
join compras on usuarios.id_usuario = compras.id_usuario;



-- Caching de consultas en MySQL

-- Consulta para obtener las últimas noticias
select * from Noticias order by fecha_publicacion desc limit 10;

-- NoSQL Redis o Memcached

#pseudocodigo en Python con uso de cache
noticias_cacheadas = obtener_de_cache("ultimas noticias");
if noticias_cacheadas is None:
    noticias = ejecutar_consulta_sql("SELECT * FROM Noticias ORDER BY fecha_publicacion DESC LIMIT 10;")
    guardar_en_cache("ultimas_noticias", noticias, tiempo_expiracion_db)
else:
    noticias = noticias_cacheadas

create database prueba2;

use prueba2;

create table employees (
    id int not null auto_increment primary key,
    fname varchar(25) not null,
    lname varchar(25) not null,
    store_id int not null,
    department_id int not null
)
    partition by range(id) (
        partition p0 values less than(5),
        partition p1 values less than(10),
        partition p3 values less than(15),
        partition p4 values less than maxvalue
    );


alter table 
    partition by range(id) (
        partition p0 values less than(5),
        partition p1 values less than(10),
        partition p2 values less than(15),
        partition p3 values less than maxvalue
    );

INSERT INTO employees VALUES
    (NULL, 'Bob', 'Taylor', 3, 2), (NULL, 'Frank', 'Williams', 1, 2),
    (NULL, 'Ellen', 'Johnson', 3, 4), (NULL, 'Jim', 'Smith', 2, 4),
    (NULL, 'Mary', 'Jones', 1, 1), (NULL, 'Linda', 'Black', 2, 3),
    (NULL, 'Ed', 'Jones', 2, 1), (NULL, 'June', 'Wilson', 3, 1),
    (NULL, 'Andy', 'Smith', 1, 3), (NULL, 'Lou', 'Waters', 2, 4),
    (NULL, 'Jill', 'Stone', 1, 4), (NULL, 'Roger', 'White', 3, 2),
    (NULL, 'Howard', 'Andrews', 1, 2), (NULL, 'Fred', 'Goldberg', 3, 3),
    (NULL, 'Barbara', 'Brown', 2, 3), (NULL, 'Alice', 'Rogers', 2, 2),
    (NULL, 'Mark', 'Morgan', 3, 3), (NULL, 'Karen', 'Cole', 3, 2);

select *
from employees
partition (p1);

select *
from employees
partition (p0,p3)
where lname like "S%";

select id, concat(fname, " ", lname) AS name
from employees
partition (p0)
order by lname;



-- TRANSACCIONES: Operaciones que se consideran o se tratan como si fueran una sola.
-- Entonces, si falla se deshace.

start transaction;
INSERT INTO employees VALUES
    (null, "Yulieth", "Taylor", 3, 2);

commit;


create table orden(
    idOrden int primary key auto_increment,
    estado varchar(50),
);

create table factura(
    idfac int primary key,
    idOrden int,
    cantidad int
    foreign key (idOrden) references orden(idOrden)
);

start transaction
insert into orden values (100, "Completada");
insert into factura values (1, 101, 3);
commit;

select * from orden;



