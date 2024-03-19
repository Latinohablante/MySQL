use prueba;

DELIMITER $$
create function calcularAreaCirculo(radio double)
returns double
deterministic
begin
	declare area double;
    set area = pi() * radio * radio;
    return area;
end $$
DELIMITER ;

select calcularAreaCirculo(10);

--  Funcion que me devuelva la clasificación de una película según su edad
delimiter $$
create function clasificarPelicula(edad int)
returns varchar(30)
deterministic
begin
	if edad < 13 then
		return "Para niños";
	elseif edad < 18 then
		return "Para adolecentes";
    else
		return "Para adultos";
	end if;
end$$
delimiter ;

select clasificarPelicula(19);

select nombre, clasificarPelicula(edad) as Clasificación
from pelicula;


-- Crear funcion para calcular el factorial de un número

delimiter $$
create function factorial(numero int)
returns int
deterministic
begin
	declare f int default 1;
    while numero > 1 do
		set f = f * numero;
        set numero = numero - 1;
        end while;
        return f;
end$$
delimiter ;

select factorial(6);


-- Crear funcion que devuelva el coche con menor kilometraje:
drop function menosKilometros;
select * from coches;

use miprimerabasededatos;
delimiter $$
create function menosKilometros()
returns int
deterministic
begin
	declare kilometraje int;
    select Kilometros into kilometraje
    from coches
    order by kilometros asc
    limit 1;
    return kilometraje;
end $$
delimiter ;

select * 
from coches
where kilometros = menosKilometros();

-- EJEMPLO - Función que calcula descuento al precio
use tienda;
drop function calcularDescuento;

delimiter $$
create function calcularDescuento(valor decimal(10, 2), porc decimal(10, 2))
returns decimal(10,2)
deterministic
begin
	if porc > 0 and porc <= 100 then
		return valor * (porc / 100);
	elseif porc > 100 then
		return valor;
    else
		return 0;
	end if;
    /*
    if porc > 100 then
		return valor;
	elseif porc 0
    */
end $$
delimiter ;
-- 
set @porc = 120;
select nombre, precio, calcularDescuento(Precio, @porc) as descuento, (precio - calcularDescuento(precio,@porc)) as "Precio final"
from producto;

-- Ejercicio - Función cálculo de promedios

-- Se requiere calcular el promedio de ventas de un vendedor, para ello mostraremos como crearla tabla y usar la función de cálculo de promedios

CREATE TABLE ventas (
	id INT AUTO_INCREMENT,
    vendedor_id INT,
    monto_venta DECIMAL(10,2),
    PRIMARY KEY (id)
);

SELECT PromedioVentas(123) AS promedioVentasVendedor;
-- Arreglar este ejercicio
delimiter $$
create function promedioVentas(cod_vendedor int)
returns decimal(10,2)
deterministic
begin
	declare acumulador decimal(10,2);
    declare existe boolean;
		select avg (moto_venta) into acumulador
        from ventas
        where vendedor_id = cod_vendedor;
        
return acumulador;

end $$

-- NUEVA FUNCIÓN
-- Función que calcula el descuento dependiendo de la categoría del cliente

-- Creación de la función para calcular el descuento teniendo en cuenta la categoría del cliente.
-- Se da la estructura y la consulta

CREATE TABLE ordenes (
	id INT AUTO_INCREMENT,
    cliente_id INT,
    precio DECIMAL(10, 2),
    categoria_cliente VARCHAR(10),
    PRIMARY KEY (id)
);

SELECT CalcularDescuento(precio, categoria_cliente) AS precioFinal
FROM ordenes;

delimiter $$
create function calcularDescuento(precio decimal(10,2), categoria_cliente varchar(10))
returns decimal(10,2)
deterministic
begin
	if categoria_cliente = "A" then
		return precio * (10 / 100);
	elseif categoria_cliente = "B" then
		return precio * (20 / 100);
	elseif categoria_cliente = "C" then
		return precio * (30 / 100);
        end if;
end $$
delimiter ;



set 
select 
        

-- solucion con case
delimiter $$
create function calcularDescuento(precio decimal(10,2), categoria_cliente varchar(10))
returns decimal(10,2)
deterministic
begin
	case lower(catCliente)
		when "A" then return precio * (10 / 100);
        when "B" then return precio * (20 / 100);
        when "C" then return precio * (30 / 100);
        else return precio;
	end case;
end $$
delimiter ;

select calcularDescuento(precio, categoria_cliente) as precioFinal
from ordenes;


use prueba;
select 1/0;

drop function calcularDivision;
delimiter $$
create function calcularDivision(dividendo double, divisor double)
returns double
deterministic
begin
	if divisor = 0 then
		signal sqlstate '10000' set message_text = "Error. División por cero no permitida";
		return 1;
    else
		return dividendo / divisor;
	end if;
end $$
delimiter ;

select calcularDivision(6,2) as resultado;
select calcularDivision(6,0) as resultado;


