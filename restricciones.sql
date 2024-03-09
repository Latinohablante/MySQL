-- CLAVES PRIMARIAS
-- es el valor único que iddentifica la tabla
CREATE TABLE estudiantes (
	id INT primary key,
    nombre VARCHAR(50)
);

-- otra forma de crear las llaves primarias
CREATE TABLE estudiantes2 (
	id INT,
    nombre VARCHAR(50),
    PRIMARY KEY(id)
);

-- CLAVES FORANEAS (EXTERNAS)(FOREIGN KEY)
-- se usa para establecer relaciones entre tablas

CREATE TABLE cursos (
	id INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE inscripciones (
	estudiante_id INT,
    curso_id INT,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);


-- RESTRICCIONES
USE prueba;

-- UNIQUE -> crea un índice que indica que ese valor es único

CREATE TABLE empleados (
	id INT PRIMARY KEY,
    codigo_empleado INT UNIQUE,
    nombre VARCHAR(50)
);

-- DEFAULT -> crea un valor por defecto y evita valores nulos

CREATE TABLE pedidos (
	id INT PRIMARY KEY,
	fecha_pedido DATE DEFAULT (CURRENT_DATE),
    total DECIMAL(10, 2) DEFAULT 0.00
);

INSERT INTO pedidos (id, total) VALUES (1,100), (2,30), (3, 150);

SELECT * FROM pedidos;

-- RESTRICCIÓN DE VERIFICACIÓN (CHECK)
-- condición que debe cumplirse para que un valor se almacene

-- Ejemplo
-- Crear una tabla productos con un id, nombre y cantidad donde se verifique que la cantidad debe ser 
-- mayor a 0

CREATE TABLE IF NOT EXISTS producto (
	id INT PRIMARY KEY,
    nombre VARCHAR(50),
    cantidad INT CHECK (cantidad > 0)
);

insert into producto values(1, "Bandeja paisa", 0);
insert into producto values(1, "Bandeja paisa", 1);

-- RESTICCION DE NOT NULL
-- indica qué columna no puede tener NOT NULL

CREATE TABLE clientes (
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);


-- RESTRICCION DE VALOR ÚNICO EN LLAVE PRIMARIA (AUTO_INCREMENT)alter
-- Genera automáticamente valores únicos para una columna

-- EJEMPLO
CREATE TABLE IF NOT EXISTS empleados2 (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

INSERT INTO empleados2 (nombre) VALUES ("Camilo"), ("Lorenzo"), ("Carlos");

select * from empleados2;

-- Entidad relación y modelo relacional
-- Componentes principales del modelo E-R

-- 1. Entidades: objetos del mundo real de interes para el sistema.
-- 2. Atributos: características o propiedades de las entidades.
-- 3. Relaciones: conexiones entre entidades.
-- 4. Cardinalidad: cantidad de instancias de una entidad en otra. (1:1), (1-N), (M,N).

-- MODELO RELACIONAL
-- Es una representación lógica más concreta y física de la base de datos
-- Los datos se organizan en tablas y relaciones
-- Las tablas filas(registros) y columnas(campos)
-- Las relaciones se hacen a través de las llaves (primarias y foráneas)

-- EJERCICIO 3 MySQL










