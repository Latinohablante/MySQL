-- PROCEDIMIENTOS ALMACENADOS

USE tienda;
-- Parámetros de entrada

INSERT INTO productos (nombre, estado, precio) VALUES
('Producto1', 'disponible', 10.99),
('Producto2', 'disponible', 20.49),
('Producto3', 'agotado', 5.99),
('Producto4', 'disponible', 15.29),
('Producto5', 'disponible', 12.99),
('Producto6', 'agotado', 8.99),
('Producto7', 'disponible', 18.79),
('Producto8', 'agotado', 6.49),
('Producto9', 'disponible', 22.99),
('Producto10', 'disponible', 14.99),
('Producto11', 'disponible', 11.99),
('Producto12', 'agotado', 9.99),
('Producto13', 'disponible', 17.99),
('Producto14', 'disponible', 19.99),
('Producto15', 'disponible', 16.99),
('Producto16', 'agotado', 7.99),
('Producto17', 'disponible', 21.99),
('Producto18', 'disponible', 24.99),
('Producto19', 'disponible', 13.99),
('Producto20', 'agotado', 8.49);


delimiter //
CREATE PROCEDURE CalcularTotal(IN precio DECIMAL(10,2), IN cantidad INT, OUT total DECIMAL(10,2))
BEGIN
	SET total = precio * cantidad;
END//

delimiter ;

set @total = 0;
call tienda.CalcularTotal(10, 5, @total);
select @total;

-- Script base ejemplo

CREATE DATABASE base_ejemplo;
USE base_ejemplo;

CREATE TABLE productos (
		id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(20) NOT NULL,
    estado VARCHAR(20) not null default "disponible",
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(id)
);

-- Ejercicio:
-- Obtener los productos basado en su estado: disponible o agotado

DELIMITER $$
CREATE PROCEDURE obtenerProductosPorEstados(IN nombre_estado VARCHAR(255))
BEGIN
	SELECT *FROM productos WHERE estado = nombre_estado;
END $$
DELIMITER ;

call base_ejemplo.obtenerProductosporEstados("DispoNible");


-- Contar el número de productos según su estado y devolver este número
DELIMITER $$
CREATE PROCEDURE contarProductosPorEstado(IN nombre_estado VARCHAR(25), OUT numero INT)
BEGIN
	SELECT COUNT(id) INTO numero FROM productos WHERE estado = NOMBRE_ESTADO;
END $$
DELIMITER ;


-- Ejecutar el procedimiento
SET @cantidad_disponibles = 0;
CALL contarProductosPorEstado("agotado", @cantidad_disponibles);
SELECT @cantidad_disponibles AS ProductosDisponibles;


-- PROCEDIMIENTO con parámetros INOUT
-- Sirve para hacer sumas
DELIMITER $$
CREATE PROCEDURE venderProducto(INOUT beneficio INT(255), IN id_producto int)
BEGIN
	DECLARE precio_producto FLOAT;
    SELECT precio INTO precio_producto FROM productos WHERE id = id_producto;
    SET beneficio = beneficio + precio_producto;
END $$
DELIMITER ;

SET @beneficio_acumulado = 0;
CALL venderProducto(@beneficio_acumulado, 1);
-- SELECT @beneficio_acumulado AS BeneficioTotal;
-- Venta del Producto 1

-- SET @beneficio_acumulado = 0;
CALL venderProducto(@beneficio_acumulado, 2);
-- Venta del Producto 2
SELECT @beneficio_acumulado AS BeneficioTotal;

-- ELIMINAR PROCEDIMIENTOS
DROP PROCEDURE venderProducto;

-- EJEMPLO 1
-- Crear un procedimiento almacenado que liste todas las ciudades de un país

USE world;

DELIMITER $$
CREATE PROCEDURE ListarCiudadesDePais (in nombrePais varchar(100))
BEGIN
	SELECT city.name
    FROM country
    INNER JOIN city ON city.countrycode = country.code
    WHERE upper(country.name) = upper(nombrePais);
END $$
DELIMITER ;

DROP PROCEDURE ListarCiudadesDePais;

CALL listarCiudadesDePais("Spain");

-- EJEMPLO 2
-- Crear un procedimiento almacenado para contar el número de ciudades en un lugar específico

DELIMITER $$
CREATE PROCEDURE ContarCiudadesDePais (in nombrePais varchar(100), out contador int)
BEGIN
	SELECT COUNT(city.name) into contador
    FROM country
    INNER JOIN city ON city.countrycode = country.code
    WHERE upper(country.name) = upper(nombrePais);
END $$
DELIMITER ;

DROP PROCEDURE ContarCiudadesDePais;

SET @contador = 0;
CALL ContarCiudadesDePais("Colombia",@contador);
SELECT @contador AS NumciudadesPaís;



-- EJERCICIO EN CLASE
-- Hacer un procedimiento almacenado que calcule la población total de ciertos países que hablen español
-- como idioma oficial cada uno de estos países se pasan por parámetro.

-- Ejemplo
-- poblacionTotal("Colombia")
-- poblacionTotal("Francia")
-- poblacionTotal("Peru")
-- Total = 70.000.000

select * from city;
select * from country;
select * from countrylanguage;

SELECT DISTINCT Co.Population
from country Co
inner join countrylanguage CL on CL.CountryCode = Co.Code
where upper(Co.Name) = "Colombia";

use world;

DELIMITER $$
CREATE PROCEDURE sumarHablantes(INOUT hablantes INT, in nombrePais varchar(100))
BEGIN
	DECLARE tot_hablantes FLOAT;
    SELECT DISTINCT Co.Population INTO tot_hablantes
    from country Co
	inner join countrylanguage CL on CL.CountryCode = Co.Code
    where upper(Co.Name) = upper(nombrePais);
    SET hablantes = if (tot_hablantes is null, 0, hablantes + tot_hablantes);
END $$
DELIMITER ;

drop procedure sumarHablantes;

SET @hablantes = 0;
CALL sumarHablantes(@hablantes, "Colombia");

-- Primer país

-- SET @beneficio_acumulado = 0;
CALL sumarHablantes(@hablantes, "Peru");

-- Segundo país

CALL sumarHablantes(@hablantes, "French");
SELECT @hablantes AS TOThablantes;
SELECT @beneficio_acumulado AS BeneficioTotal;


-- Copiar codigo de Estructura IF Then


-- Estructura LOOP
-- Acciones a repetir
/*
LOOP
	IF condición_salida THEN
		LEAVE loop_label;
	END IF;
END LOOP loop_label
*/

-- Ejemplo LOOP
-- Queremos aumentar el salario de los empleadoe en un 10% hasta que alcance un máximo de $5000

DELIMITER //
DELIMITER ;

/*
REPEAT
  -- Acciones a repetir
UNTIL condicion
END REPEAT;
*/

-- Ejemplo REPEAT

-- Aumentar el salario de los empleados en un 5% repetidamente hasta que todos
-- tengan un salario mínimo de $3000

DELIMITER //

CREATE PROCEDURE AumentarSalarios()
BEGIN
	LOOP
		UPDATE empleados SET salario = salario * 1.05 WHERE salario < 3000;
        UNTIL (SELECT COUNT(*) FROM empleados WHERE salario < 3000)
        END REPEAT;
        -- esta condicion se repite mientras sea falsa, al ser verdadera cambia
END //

DELIMITER ;


-- ESTRUCTURA WHILE 

WHILE condicion DO
	-- Acciones a repetir
END WHILE;

-- EJEMPLO WHILE

-- queremos contar cuántos empleados tienen un salario mayor a $4000

DELIMITER //

CREATE PROCEDURE ContarEmpleadosAltosSalarios()
BEGIN
	DECLARE contador 


-- ESTRUCTURA CASE

CASE expresion
	WHEN valor1 THEN
		-- Acciones para valor1
	WHEN valor2 THEN
		-- Acciones para valor2
	ELSE
		-- Acciones si no se cumple ninguno de los casos anteriores
END CASE;
DELIMITER ;

-- ERROR 1062: Dato duplicado

USE tienda;

delimiter $$
CREATE procedure insertFabricante(in idfab int, in nomfab varchar(100))
begin 
	declare exit handler for 1062 select concat("Error, el fabricante código ", idfab, " ya existe") as Error;
    insert into fabricante values (idfab, nomfab);
end $$
delimiter ;

drop procedure insertFabricante;

use tienda;
call insertFabricante(10, "Oppo");
call insertFabricante(10, "Motorola");
