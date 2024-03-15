-- Creación de la base de datos Hospital


/*!40000 DROP DATABASE IF EXISTS `Hospital`*/;
CREATE DATABASE Hospital DEFAULT CHARACTER SET utf8mb4;

USE Hospital;

CREATE TABLE Dept (
	Dept_No			INT				NOT NULL,
	DNombre			VARCHAR(50)		NULL,
	Loc				VARCHAR(50)		NULL,
	PRIMARY KEY(Dept_No)
);

CREATE TABLE Emp (
	Emp_No			INT				NOT NULL,
	Apellido		VARCHAR(50)		NULL,
	Oficio			VARCHAR(50)		NULL,
	Dir				INT				NULL,
	Fecha_Alt		DATETIME	NULL,
	Salario			NUMERIC(9,2)	NULL,
	Comision		NUMERIC(9,2)	NULL,
	Dept_No			INT				NULL,
	PRIMARY KEY(Emp_No),
	FOREIGN KEY (Dept_No) REFERENCES Dept(Dept_No)
);

CREATE TABLE Hospital (
	Hospital_Cod	INT				NOT NULL,
	Nombre			VARCHAR(50)		NULL,
	Direccion		VARCHAR(50)		NULL,
	Telefono		VARCHAR(50)		NULL,
	Num_Cama		INT				NULL,
	PRIMARY KEY(Hospital_Cod)
);

CREATE TABLE Doctor (
	Doctor_No		INT				NOT NULL,
	Hospital_Cod	INT				NOT NULL,
	Apellido		VARCHAR(50)		NULL,
	Especialidad	VARCHAR(50)		NULL,
	PRIMARY KEY(Doctor_No),
	FOREIGN KEY (Hospital_Cod) REFERENCES Hospital(Hospital_Cod)
);

CREATE TABLE Sala (
	Sala_Cod		INT				NOT NULL,	
	Hospital_Cod	INT				NOT NULL,
	Nombre			VARCHAR(50)		NULL,
	Num_Cama		INT				NULL,
	PRIMARY KEY(Sala_Cod,Hospital_Cod),
	FOREIGN KEY (Hospital_Cod) REFERENCES Hospital(Hospital_Cod)
);

CREATE TABLE Plantilla (
	Empleado_No		INT				NOT NULL,
	Sala_Cod		INT				NOT NULL,	
	Hospital_Cod	INT				NOT NULL,
	Apellido		VARCHAR(50)		NULL,
	Funcion			VARCHAR(50)		NULL,
	T				VARCHAR(15)		NULL,
	Salario			NUMERIC(9,2)	NULL,
	PRIMARY KEY(Empleado_No),
	FOREIGN KEY (Sala_Cod,Hospital_Cod) REFERENCES Sala(Sala_Cod,Hospital_Cod)
);

CREATE TABLE Enfermo (
	Inscripcion		INT				NOT NULL,
	Apellido		VARCHAR(50)		NULL,
	Direccion		VARCHAR(50)		NULL,
	Fecha_Nac		VARCHAR(50)		NULL,
	S				VARCHAR(2)		NULL,
	NSS				INT				NULL
);