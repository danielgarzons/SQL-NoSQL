SHOW DATABASES;
CREATE DATABASE rpg_manager CHARACTER SET utf8mb4;
SHOW TABLES;
USE rpg_manager;


CREATE TABLE clase (
	id_clase INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(150)
);

CREATE TABLE personaje (
	id_personaje INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    id_clase INT NOT NULL,
    nivel INT DEFAULT 1 CHECK (nivel BETWEEN 1 AND 100),
	vida INT DEFAULT 100 CHECK (vida >= 0),
    oro DECIMAL(10,2) DEFAULT 0.00 CHECK (oro >= 0),
    FOREIGN KEY (id_clase) REFERENCES clase(id_clase)
)

INSERT INTO clase (nombre, descripcion)
values('Guerrero', 'Especialista en combate cuerpo a cuerpo');

INSERT INTO clase (nombre, descripcion)
values('Mago', 'Experto en restaurar tu nivel de vida');

INSERT INTO clase (nombre, descripcion)
values('Arquero', 'Tiene vista y precision de halcon');
SELECT * FROM clase;


INSERT INTO personaje (nombre, id_clase, nivel, vida, oro)
VALUES ('Maximilian', 1, 10, 100, 50.00),
       ('Arturo', 2, 5, 80, 25.50);
SELECT * FROM personaje;


INSERT INTO personaje (nombre, id_clase, nivel, vida, oro)
VALUES ('Arargan', 1, 99, 100, 50.00);

INSERT INTO personaje (nombre, id_clase, nivel, vida, oro)
VALUES ('ElFantasma', 99, 10, 100, 50.00);