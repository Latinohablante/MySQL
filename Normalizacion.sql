-- NORMALIZACION

-- Ejercicio
-- El campo telefonos debe aceptar diferentes números de teléfono

CREATE TABLE Estudiante (
	ID int primary key,
    Nombre varchar(100)
    -- Telefonos varchar(255)
);

CREATE TABLE Telefono (
	id_est int,
    telefono varchar(100),
    foreign key (id_est) references Estudiante (id),
    primary key (id_est, telefono)
);

-- Ejercicio 2
-- Normalizar la siguiente estructura
-- tabla original
CREATE TABLE CursoEstudiante (
	CursoID int,
    EstudianteID int,
    NombreCurso varchar(100),
    NombreEstudiante varchar(100),
    PRIMARY KEY (CursoID, EstudianteID)
);


-- solución
CREATE TABLE Estudiante (
    EstudianteID int primary key,
    NombreEstudiante varchar(100)
);

CREATE TABLE Curso (
	CursoID int primary key,
    NombreCurso varchar (100)
);

CREATE TABLE CursoEstudiante (
	CursoID int,
    EstudianteID int,
    foreign key (EstudianteID) references Estudiante (EstudianteID),
    foreign key (CursoID) references Curso (CursoID),
    primary key (CursoID, EstudianteID)
);

-- Ejercicio 3
-- Normalizar la siguiente estructura
-- Tabla Original
CREATE TABLE Profesor (
	ProfesorID int,
    Nombre varchar(100),
    DepartamentoID int,
    NombreDepartamento varchar(100)
);

-- solución

CREATE TABLE Profesor (
	ProfesorID int primary key,
    Nombre varchar(100),
    DepartamentoID int,
    primary key (ProfesorID),
    foreign key (DepartamentoID) references Departamento(DepartamentoID)
);

CREATE TABLE Departamento (
    DepartamentoID int primary key,
    NombreDepartamento varchar(100)
);


-- Ejercicio 4
-- Normalizar la siguiente estructura si "Horario" depende solo de "CursoID"
-- Tabla original
CREATE TABLE Asignacion (
	ProfesorID int,
    CursoID int,
    Horario varchar(50),
    Primary key (ProfesorID,CursoID)
);

-- solución
CREATE TABLE Asignacion (
	ProfesorID int,
    CursoID int,
    Primary key (ProfesorID,CursoID),
    foreign key (CursoID) references Curso(CursoID),
    foreign key (ProfesorID) references Profesor(ProfesorID)
);

CREATE TABLE Curso (
    CursoID int,
    nombre varchar(50),
    Primary key (CursoID)
);

CREATE TABLE Horario (
	HorID int,
	Horario time,
    primary key (HorID)
);

CREATE TABLE Cur_Hor (
	HorID int,
    CursoID int,
    primary key (HorID, CursoID),
    foreign key (HorID) references Horario(HorID)
);

CREATE TABLE Profesor (
	ProfesorID int,
    nombre varchar(100),
    Primary key (ProfesorID)
);

-- Ejercicio 5
-- Normalizar la siguiente estructura para un sistema de gestión de un hospital.
-- En este escenario hay una tabla que intenta manejar mùltiples aspectos de 
-- la información del paciente, las visitas al médico, los tratamientos y las recetas.

-- TABLA ORIGINAL
CREATE TABLE RegistroHospital (
	PacienteID int,
    NombrePaciente varchar(100),
    FechaNacimiento date,
    MedicoID int,
    NombreMedico varchar(100),
    Especialidad varchar(100),
    FechaVisita datetime,
    DescripcionTratamiento varchar(255),
    Medicamento varchar(100),
    Dosis varchar(50)    
);

-- Solución

CREATE TABLE Medico (
	MedicoID int primary key,
    NombreMedico varchar(100),
    Especialidad varchar(100)
);

CREATE TABLE Paciente (
	PacienteID int primary key,
    NombrePac varchar(100)
);

CREATE TABLE Cita (
	CitaID int,
    FechaVisita datetime,
    PacienteID int,
    MedicoID int,
    TratID int,
    MedicamentoID int,
    DosisID int,
    primary key (CitaID),
    foreign key(tratID) references Tratamiento (tratID),
    foreign key(DosisID) references Dosis (DosisID),
    foreign key(MedicamentoID) references Medicamento (MedicamentoID),
    foreign key (PacienteID) references Paciente(PacienteID)
);

CREATE TABLE Tratamiento (
	tratID int primary key,
    DescrTrat varchar(255)
);

CREATE TABLE Trat_Med (
	tratID int,
    MedicamentoID int,
    primary key (tratID, MedicamentoID),
    foreign key(tratID) references Tratamiento (tratID),
    foreign key(MedicamentoID) references Medicamento (MedicamentoID)
);

CREATE TABLE Medicamento (
	MedicamentoID int primary key,
    nombre varchar(100)
);

CREATE TABLE Med_Dos (
	DosisID int,
    MedicamentoID int,
    primary key (DosisID, MedicamentoID),
    foreign key(DosisID) references Dosis (DosisID),
    foreign key(MedicamentoID) references Medicamento (MedicamentoID)
);

CREATE TABLE Dosis (
	DosisID int primary key,
    cantidad varchar(100)
);

-- Consulta:
-- Pacientes que fueron tratados en el 2022. Indique el id del paciente, nombre, 
-- fecha consulta, nombre médico y tratamiento

select P.pacienteID, P.nombre, C.fechaVisita, M.NombreMedico, T.DescrTrat
from cita C
inner join paciente P on C.pacienteID = P.pacienteID
inner join medico M on M.medicoID = C.medicoID
inner join tratamiento T on T.tratID = C.tratID
where year(C.fechaVisita) = 2022;


