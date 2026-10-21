
CREATE DATABASE IF NOT EXISTS rpg_manager CHARACTER SET utf8mb4;
USE rpg_manager;

CREATE TABLE clase (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE personaje (
    id_personaje INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    nivel INT DEFAULT 1,
    vida INT DEFAULT 100,
    id_clase INT,
    CONSTRAINT fk_personaje_clase FOREIGN KEY (id_clase) REFERENCES clase(id_clase)
);


INSERT INTO clase (nombre, descripcion) VALUES 
('Guerrero', 'Especialista en combate cuerpo a cuerpo'),
('Mago', 'Dominador de las artes arcanas'),
('Arquero', 'Mago del ataque a distancia');

INSERT INTO personaje (nombre, nivel, vida, id_clase) VALUES 
('Eva', 100, 100, 1),
('Adan', 100, 100, 2);


SELECT p.nombre, c.nombre AS clase
FROM personaje p
JOIN clase c ON p.id_clase = c.id_clase;
