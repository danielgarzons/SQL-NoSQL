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

CREATE TABLE personaje_mision (
    id_personaje INT,
    id_mision INT,
    estado ENUM('aceptada', 'completada', 'fallida') DEFAULT 'aceptada',
    PRIMARY KEY (id_personaje, id_mision),
    FOREIGN KEY (id_personaje) REFERENCES personaje(id_personaje),
    FOREIGN KEY (id_mision) REFERENCES mision(id_mision)
);

CREATE TABLE combate (
    id_combate INT AUTO_INCREMENT PRIMARY KEY,
    id_atacante INT NOT NULL,
    id_defensor INT NOT NULL,
    id_ganador INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_atacante) REFERENCES personaje(id_personaje),
    FOREIGN KEY (id_defensor) REFERENCES personaje(id_personaje),
    FOREIGN KEY (id_ganador) REFERENCES personaje(id_personaje)
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

-- MISION
INSERT INTO mision (titulo, dificultad, recompensa_oro, nivel_minimo)
VALUES ('Limpieza de Alcantarillas', 'facil', 20.00, 1)

SELECT * FROM mision;

-- MISION DE PERSONAJE
INSERT INTO personaje_mision (id_personaje, id_mision, estado)
VALUES (1,1,'aceptada')

SELECT * FROM personaje_mision;

-- ARENA DE COMBATE
INSERT INTO combate (id_atacante, id_defensor, id_ganador)
VALUES (1,2,1)

SELECT * FROM combate;


-- CONSULTAS
-- Nombre y clase
SELECT p.nombre AS personaje, c.nombre AS clase
FROM personaje p
JOIN clase c ON p.id_clase = c.id_clase;

-- Nombre, item y cantidad
SELECT p.nombre AS personaje, i.nombre AS objeto, inv.cantidad
FROM personaje p
JOIN inventario inv ON p.id_personaje = inv.id_personaje
JOIN item i ON inv.id_item = i.id_item;

-- Todos los personajes sin importar si tienen item o no en el inventario
SELECT p.nombre AS personaje, i.nombre AS objeto, inv.cantidad
FROM personaje p
LEFT JOIN inventario inv ON p.id_personaje = inv.id_personaje
LEFT JOIN item i ON inv.id_item = i.id_item;

--- Cantidad total de objetos de cada personaje en la mochila
SELECT p.nombre AS personaje, SUM(inv.cantidad) AS total_items
FROM personaje p
LEFT JOIN inventario inv ON p.id_personaje = inv.id_personaje
GROUP BY p.id_personaje;

-- Reemplazar NULL por 0
SELECT p.nombre AS personaje, IFNULL(SUM(inv.cantidad), 0) AS total_items
FROM personaje p
LEFT JOIN inventario inv ON p.id_personaje = inv.id_personaje
GROUP BY p.id_personaje 
HAVING SUM(inv.cantidad) > 1; 
-- Solo personajes con +1 objeto en total


-- Ranking de mayor a menor según cantidad de objetos, solo el top 1
SELECT p.nombre AS personaje, IFNULL(SUM(inv.cantidad), 0) AS total_items
FROM personaje p
LEFT JOIN inventario inv ON p.id_personaje = inv.id_personaje
GROUP BY p.id_personaje
ORDER BY total_items DESC
LIMIT 1;

-- Reporte de misiones
SELECT p.nombre AS personaje, COUNT(pm.id_mision) AS misiones_completadas
FROM personaje p
LEFT JOIN personaje_mision pm ON p.id_personaje = pm.id_personaje
AND pm.estado = 'completada'
GROUP BY p.id_personaje;




