-- EJERCICIO PROCEDIMIENTOS ALMACENADOS MANEJO DE EXCEPCIONES

CREATE DATABASE tienda2;
USE tienda2;

CREATE TABLE Productos (
  	id INT AUTO_INCREMENT,
    nombre VARCHAR(255),
    precio DECIMAL(10, 2),
    stock INT,
    PRIMARY KEY (id)
);
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255),
    email VARCHAR(255),
    PRIMARY KEY (id)
);
CREATE TABLE Ventas (
    id INT AUTO_INCREMENT,
    producto_id INT,
    cliente_id INT,
    cantidad INT,
    fecha_venta DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
CREATE TABLE errores_log (
	id int auto_increment primary key,
	error_message varchar(100)
);

drop table errores_log;

DROP PROCEDURE AñadirProducto;
DELIMITER //
CREATE PROCEDURE AñadirProducto(IN nombre VARCHAR(255), IN precio DECIMAL(10, 2),
IN stock INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    SELECT "Error al añadir producto." AS Error;
    BEGIN
		-- Se podría registrar el error en una tabla de logs
        
		INSERT INTO errores_log(error_message) VALUES ("Error al añadir producto.");
        
        ROLLBACK; -- Revertir la transacción
	END;
    INSERT INTO Productos(nombre, precio, stock) VALUES (nombre, precio, stock);
END //
DELIMITER ;

CALL AñadirProducto('Producto 1', sads, asd);

SELECT * FROM errores_log;
select * from Productos;

DELIMITER //
CREATE PROCEDURE RegistrarCliente(IN nombre VARCHAR(255), IN email VARCHAR(255))
BEGIN
    INSERT INTO Clientes(nombre, email) VALUES (nombre, email);
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE RealizarVenta(IN productoID INT, IN clienteID INT, IN cantidad INT)
BEGIN
    -- Aquí podrías añadir lógica para actualizar el stock, verificar disponibilidad, etc.
    INSERT INTO Ventas(producto_id, cliente_id, cantidad, fecha_venta) VALUES (productoID,
clienteID, cantidad, CURDATE());
END //
DELIMITER ;