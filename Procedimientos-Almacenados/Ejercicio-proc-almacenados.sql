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
CREATE PROCEDURE empleadosFecha(IN dep int, IN fecha_ini date, IN fecha_fin date)
BEGIN
	DECLARE 
use Hospital;

-- 1. Construya el procedimiento almacenado que saque todos los empleados que se dieron de
-- alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado
-- departamento.
select * from Dept;

select *
from Emp E
inner join Dept D on D.Dept_No = E.Dept_No
WHERE E.Fecha_Alt BETWEEN "1980-01-01" AND "1984-01-01" AND E.Dept_No = 10

DELIMITER //
CREATE PROCEDURE empEntreFecha(IN fecha_ini date, IN fecha_fin date, in depar varchar(20))
begin
select *
from Emp E
inner join Dept D on D.Dept_No = E.Dept_No
WHERE E.Fecha_Alt BETWEEN fecha_ini AND fecha_fin AND D.DNombre = depar;
end //
DELIMITER ;

DROP PROCEDURE empEntreFecha;

call empEntreFecha("1980-01-01","1984-01-01","CONTABILIDAD");

-- 2. Construya el procedimiento que inserte un empleado.
-- DATOS DE Emp: 

DELIMITER //
CREATE PROCEDURE ingresarEmp(
IN N_Emp INT, 
IN Apell varchar(50), 
IN Oficio varchar(50),
IN Dir int,
IN Fecha_Alt datetime,
IN salario numeric(9,2),
IN comision numeric(9,2),
IN Dept_No int)
BEGIN

INSERT INTO Emp VALUES(N_Emp,Apell,Oficio,Dir,Fecha_Alt,salario,comision,Dept_No);
END //
DELIMITER ;

call ingresarEmp(1111,"Perez","EMPLEADO",7999,"1980-01-02",40500,0,20);

select * from Emp where Apellido = "Perez";

-- INSERT INTO Emp(Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No) VALUES(1111,"Perez","EMPLEADO",7999,"1980-01-02",40500,0,20)



-- 3. Construya el procedimiento que recupere el nombre del departamento, número y número de personas a partir del número de departamento.

select *  from Dept;
select * from Emp;

select count(Dept_No) 
from Emp
where Dept_No = 10;

select D.DNombre, D.Dept_No, Count(E.Dept_No) as numEmpleados
from Dept D
inner join Emp E on D.Dept_No = E.Dept_No
where E.Dept_No = 30;

DROP PROCEDURE numPersDepart;
DELIMITER //
CREATE PROCEDURE numPersDepart(IN numDept INT)
BEGIN
select D.DNombre, D.Dept_No as Num, Count(E.Dept_No) AS numEmpleados
from Dept D
inner join Emp E on D.Dept_No = E.Dept_No
where D.Dept_No = numDept
group by Num;
END //
DELIMITER ;

call numPersDepart(10);

-- 4. Diseñe y construya un procedimiento igual que el anterior, pero que recupere también las
-- personas que trabajan en dicho departamento, pasándole como parámetro el nombres

select D.DNombre, D.Dept_No as Num, E.Apellido, E.Salario
from Dept D
inner join Emp E on D.Dept_No = E.Dept_No
where D.Dnombre = "CONTABILIDAD";

DROP PROCEDURE numYNomPersDepart;
DELIMITER //
CREATE PROCEDURE numYNomPersDepart(IN nomDept VARCHAR(50))
BEGIN
select D.DNombre, D.Dept_No as Num, Count(E.Dept_No) AS numEmpleados
from Dept D
inner join Emp E on D.Dept_No = E.Dept_No
where D.Dnombre = nomDept
group by Num;

select D.DNombre, D.Dept_No as Num, E.Apellido, E.Salario
from Dept D
inner join Emp E on D.Dept_No = E.Dept_No
where D.Dnombre = nomDept;
END //
DELIMITER ;

call numYNomPersDepart("CONTABILIDAD");


-- 5. Construya un procedimiento para devolver salario, oficio y comisión, pasándole el apellido.

select Salario, Oficio, Comision 
from Emp
where Apellido = "SERRA";

DELIMITER //
CREATE PROCEDURE datosEmp(IN Apell varchar(50))
BEGIN
select Salario, Oficio, Comision 
from Emp
where Apellido = Apell;
END //
DELIMITER ;

call datosEmp("SERRA");

-- 6. Tal como el ejercicio anterior, pero si no le pasamos ningún valor, mostrará los datos de todos los empleados.

select Salario, Oficio, Comision 
from Emp;

DROP PROCEDURE datosEmpT;
DELIMITER //
CREATE PROCEDURE datosEmpT(IN Apell varchar(50))
BEGIN
	IF length(Apell) = 0 THEN
		select Salario, Oficio, Comision 
		from Emp;
	ELSE
		select Salario, Oficio, Comision 
		from Emp
		where  Apellido = Apell;
	END IF;
END //
DELIMITER ;

call datosEmpT("");

-- 7. Construya un procedimiento para mostrar el salario, oficio, apellido y nombre del
-- departamento de todos los empleados que contengan en su apellido el valor que le
-- pasemos como parámetro.

SELECT * FROM Dept;
SELECT * FROM Emp;

DROP PROCEDURE datosEmpconSala;
DELIMITER // 
CREATE PROCEDURE datosEmpconSala(IN Letra varchar(50))
BEGIN
SELECT E.Salario, E.Oficio, E.Apellido, D.DNombre
FROM Emp E
INNER JOIN Dept D ON E.Dept_No = D.Dept_No
WHERE E.Apellido LIKE concat("%",Letra,"%");
END //
DELIMITER ;

call datosEmpconSala("IA");


