create database Hospital;

use Hospital;


-- SOLUCION DE EJERCICIOS

-- PROCEDIMIENTOS ALMACENADOS

-- 1. Construya el procedimiento almacenado que saque todos los empleados que se dieron de
-- alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado
-- departamento.

select *
from Emp
WHERE Fecha_Alt BETWEEN "1980-01-01" AND "1984-01-01";

DELIMITER //

CREATE PROCEDURE empEntreFecha(IN fecha_ini date, IN fecha_fin date)


SELECT * FROM Emp;

DELIMITER //
CREATE PROCEDURE empleadosFecha(IN dep int, IN fecha_ini date, IN fecha_fin date)
BEGIN
	DECLARE 


