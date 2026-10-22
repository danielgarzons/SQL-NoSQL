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