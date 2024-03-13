-- GRUOP BY


DROP SCHEMA IF EXISTS miprimerabasededatos;
CREATE SCHEMA IF NOT EXISTS miprimerabasededatos
DEFAULT CHARACTER SET utf8;
SHOW WARNINGS;
USE miprimerabasededatos;

DROP TABLE IF EXISTS coches;

CREATE TABLE IF NOT EXISTS coches (
	id INT(11) NOT NULL AUTO_INCREMENT,
	Marca VARCHAR(45) NOT NULL,
    Modelo VARCHAR(45) NOT NULL,
    kilometros INT(11) NOT NULL,
    PRIMARY KEY(id))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;

INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Renault", "Clio", 10);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Renault", "Megane", 23000);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Seat", "Ibiza", 9000);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Seat", "Leon", 20);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Opel", "Corsa", 999);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Renault", "Clio", 34000);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Seat", "Ibiza", 2000);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Seat", "Cordoba", 99999);
INSERT INTO coches (Marca, Modelo, kilometros) VALUES ("Renault", "Clio", 88888);

SELECT marca
from coches
group by marca;

SELECT Marca, Modelo
from coches
group by Marca, Modelo;

SELECT Marca, COUNT(*) AS contador
FROM coches
GROUP BY Marca 
ORDER BY contador Desc;

SELECT Marca, SUM(kilometros)
FROM coches
GROUP BY Marca;

SELECT Marca, MAX(kilometros)
FROM coches
GROUP BY Marca;

SELECT Marca, MIN(kilometros)
FROM coches
GROUP BY Marca;

SELECT 



