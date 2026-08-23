PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech
-- Cree aqui las tablas necesarias para el modelo.
-- Debe incluir PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

-- Ejemplo de estructura esperada:
-- CREATE TABLE nombre_tabla (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL UNIQUE,
--   estado TEXT NOT NULL CHECK (estado IN ('activo', 'inactivo'))
-- );

`autores`
- `libros`
- `campers`
- `prestamos`
- `editorial`

DROP DATABASE IF EXISTS 02_libreria_tech;
CREATE DATABASE IF NOT EXISTS 02_libreria_tech;

USE 02_libreria_tech;
CREATE TABLE autores(
    id INT PRIMARY KEY AUTO_INCREMENT,
    autor VARCHAR(60) NOT NULL
);

CREATE TABLE editorial(
    id INT AUTO_INCREMENT PRIMARY KEY,
    editorial VARCHAR(80)
);

CREATE TABLE libros(
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(80) NOT NULL,
    id_autor INT NOT NULL,
    id_editorial INT NOT NULL,
    fecha_publicacion DATE,
    cantidad INT CHECK(cantidad > 0) DEFAULT 0,

    CONSTRAINT FK_ID_AUTOR
        Foreign Key (id_autor) REFERENCES autores(id),

    CONSTRAINT FK_ID_CATEGORIA
        Foreign Key (id_editorial) REFERENCES editorial(id)
);

CREATE TABLE sedes_campus(
    id  INT AUTO_INCREMENT PRIMARY KEY,
    departamento VARCHAR(100) NOT NULL
);
 
CREATE TABLE campers(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL,
    id_sede INT NOT NULL,

    CONSTRAINT fk_id_sede
    Foreign Key (id_sede) REFERENCES sedes_campus(id)
);

CREATE TABLE prestamos(
    id  INT PRIMARY KEY AUTO_INCREMENT,
    id_camper INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATETIME DEFAULT CURRENT_TIMESTAMP,
    punto_de_vista TEXT,

    CONSTRAINT fk_id_camper
        Foreign Key (id_camper) REFERENCES campers(id),
    CONSTRAINT fk_id_libro
        Foreign Key (id_libro) REFERENCES libros(id)
);