PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Cree aqui las tablas necesarias para el modelo.
-- Debe incluir PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

-- Ejemplo de estructura esperada:
-- CREATE TABLE nombre_tabla (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL UNIQUE,
--   estado TEXT NOT NULL CHECK (estado IN ('activo', 'inactivo'))
-- );

CREATE TABLE peliculas (
    id_pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    director TEXT,
    duracion TEXT NOT NULL CHECK (duracion > 0),
    genero TEXT
    
);
DROP TABLE if EXISTS boleto;
CREATE TABLE boleto (
    id_boleto INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion INTEGER NOT NULL,
    id_pelicula INTEGER,
    fecha_compra TEXT,
    asiento TEXT NOT NULL,

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    FOREIGN KEY (id_funcion) REFERENCES funcion (id_funcion),
    UNIQUE(id_funcion, asiento)
);

CREATE TABLE sala (
    id_sala INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK (capacida> 0) 
)

CREATE TABLE IF NOT EXISTS funcion (
    id_funcion INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    id_pelicula INTEGER,
    id_sala INTEGER,
    fecha TEXT NOT NULL,
    hora TEXT NOT NULL,
    precio FLOAT NOT NULL CHECK (precio > 0)
)    
   
   
