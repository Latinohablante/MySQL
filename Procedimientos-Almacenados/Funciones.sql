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