PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Estructura DDL para gestión de proyecciones, salas y boletos

-- 1. Tabla de Salas
CREATE TABLE salas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    tipo_pantalla TEXT NOT NULL CHECK (tipo_pantalla IN ('2D', '3D', 'IMAX'))
);

-- 2. Tabla de Películas
CREATE TABLE peliculas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    genero TEXT NOT NULL,
    duracion_minutos INTEGER NOT NULL CHECK (duracion_minutos > 0),
    clasificacion TEXT NOT NULL
);

-- 3. Tabla de Funciones (Relación Película - Sala)
CREATE TABLE funciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pelicula_id INTEGER NOT NULL,
    sala_id INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    precio REAL NOT NULL CHECK (precio >= 0),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id) ON DELETE CASCADE,
    FOREIGN KEY (sala_id) REFERENCES salas(id) ON DELETE CASCADE
);

-- 4. Tabla de Boletos / Tickets
CREATE TABLE boletos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    funcion_id INTEGER NOT NULL,
    numero_asiento TEXT NOT NULL,
    estado TEXT NOT NULL CHECK (estado IN ('reservado', 'vendido', 'cancelado')),
    FOREIGN KEY (funcion_id) REFERENCES funciones(id) ON DELETE CASCADE
);
