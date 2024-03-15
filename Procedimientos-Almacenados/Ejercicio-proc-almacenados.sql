create database Hospital;

use Hospital;


-- SOLUCION DE EJERCICIOS

-- PROCEDIMIENTOS ALMACENADOS

-- 1. Construya el procedimiento almacenado que saque todos los empleados que se dieron de
-- alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado
-- departamento.
select * from Dept;

select *
from Emp E
inner join Dept D on D.Dept_No = E.Dept_No
WHERE E.Fecha_Alt BETWEEN "1980-01-01" AND "1984-01-01" AND E.Dept_No = 10

DELIMITER //
CREATE PROCEDURE empEntreFecha(IN fecha_ini date, IN fecha_fin date, in depar int)
begin
select *
from Emp E
inner join Dept D on D.Dept_No = E.Dept_No
WHERE E.Fecha_Alt BETWEEN fecha_ini AND fecha_fin AND E.Dept_No = depar;
end //
DELIMITER ;

call empEntreFecha("1980-01-01","1982-01-01",10);

-- 2. Construya el procedimiento que inserte un empleado.

INSERT INTO Emp( Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No) VALUES
(7369,'SANCHEZ','EMPLEADO',7902,'1980-12-17',10400,0,20),

