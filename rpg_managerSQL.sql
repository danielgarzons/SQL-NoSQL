SHOW DATABASES;
CREATE DATABASE rpg_manager CHARACTER SET utf8mb4;
SHOW TABLES;
USE rpg_manager;


-- TABLAS
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

CREATE TABLE item (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    tipo ENUM('arma', 'armadura', 'pocion', 'reliquia') NOT NULL,
    valor DECIMAL(10,2) DEFAULT 0.00 CHECK (valor >= 0),
    peso DECIMAL(5,2) DEFAULT 0.00 CHECK (peso >= 0)
);

CREATE TABLE inventario (
    id_personaje INT,
    id_item INT,
    cantidad INT DEFAULT 1 CHECK (cantidad > 0),
    PRIMARY KEY (id_personaje, id_item),
    FOREIGN KEY (id_personaje) REFERENCES personaje(id_personaje),
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE mision (
    id_mision INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL UNIQUE,
    dificultad ENUM('facil', 'media', 'dificil', 'legendaria') NOT NULL,
    recompensa_oro DECIMAL(10,2) DEFAULT 0.00 CHECK (recompensa_oro >= 0),
    nivel_minimo INT DEFAULT 1 CHECK (nivel_minimo BETWEEN 1 AND 100)
);


-- CLASES Y PERSONAJES
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

INSERT INTO personaje (nombre, id_clase, nivel, vida, oro)
VALUES ('Arargan', 1, 99, 100, 50.00);

INSERT INTO personaje (nombre, id_clase, nivel, vida, oro)
VALUES ('ElFantasma', 99, 10, 100, 50.00);
SELECT * FROM clase;
SELECT * FROM personaje;


-- ITEMS
INSERT INTO item (nombre, tipo, peso, valor)
VALUES ('Espada de Hierro', 'arma', 3.50, 15.00),
		('Pocion de Vida', 'pocion', 0.25, 5.00);

SELECT * FROM item;

-- INVENTARIO
INSERT INTO inventario (id_personaje, id_item, cantidad)
VALUES (1,2,3);

SELECT * FROM inventario;