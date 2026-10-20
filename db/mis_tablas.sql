SELECT VERSION();
SHOW DATABASES;
CREATE DATABASE rpg_manager CHARACTER SET utf8mb4;
USE rpg_manager;
CREATE TABLE personaje(
id_personaje INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
nivel INT DEFAULT 1,
vida INT DEFAULT 100
);

SHOW TABLES;
INSERT INTO personaje (nombre, nivel, vida)
VALUES ('Eva',100,100);
SELECT * FROM  personaje;

INSERT INTO personaje (nombre,nivel,vida)
VALUES('Adan',100,100);

SELECT * FROM  personaje;
