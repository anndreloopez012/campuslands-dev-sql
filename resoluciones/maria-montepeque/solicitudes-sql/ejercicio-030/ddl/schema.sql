PRAGMA foreign_keys = ON;

-- Ejercicio 030: Cine Horror Nights
-- Modelo: peliculas y salas (catalogos) -> funciones (tabla principal).

-- peliculas: catalogo. duracion_min tiene un CHECK de rango (detecta
-- valores fuera de rango), tal como pidio el cliente.
CREATE TABLE peliculas (
    id_pelicula   INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo        TEXT NOT NULL UNIQUE,
    duracion_min  INTEGER NOT NULL CHECK (duracion_min BETWEEN 60 AND 240)
);

CREATE TABLE salas (
    id_sala     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala TEXT NOT NULL UNIQUE,
    capacidad   INTEGER NOT NULL CHECK (capacidad > 0)
);

-- funciones: tabla principal. La FOREIGN KEY doble evita relaciones
-- invalidas, y UNIQUE(id_sala, fecha_hora) evita el registro repetido
-- de dos funciones en la misma sala a la misma hora.
CREATE TABLE funciones (
    id_funcion     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula    INTEGER NOT NULL,
    id_sala        INTEGER NOT NULL,
    fecha_hora     TEXT NOT NULL DEFAULT (datetime('now')),
    precio_boleto  REAL NOT NULL CHECK (precio_boleto > 0),
    estado         TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES salas (id_sala),
    UNIQUE (id_sala, fecha_hora)
);
