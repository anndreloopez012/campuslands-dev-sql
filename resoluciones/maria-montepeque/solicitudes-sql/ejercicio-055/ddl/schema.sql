PRAGMA foreign_keys = ON;

-- Ejercicio 055: Cine Horror Nights
-- Modelo: peliculas + salas -> funciones (doble FOREIGN KEY), y
-- funciones -> boletos (1:N). 4 tablas en total.

CREATE TABLE peliculas (
    id_pelicula        INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo             TEXT NOT NULL UNIQUE,
    duracion_minutos   INTEGER NOT NULL CHECK (duracion_minutos > 0),
    clasificacion      TEXT NOT NULL CHECK (clasificacion IN ('B', 'B15', 'C', 'D'))
);

CREATE TABLE salas (
    id_sala      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala  TEXT NOT NULL UNIQUE,
    capacidad    INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE funciones (
    id_funcion      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula     INTEGER NOT NULL,
    id_sala         INTEGER NOT NULL,
    fecha_hora      TEXT NOT NULL,
    precio_boleto   REAL NOT NULL CHECK (precio_boleto > 0),
    estado          TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES salas (id_sala)
);

-- boletos: un mismo asiento no se puede vender dos veces para la
-- misma funcion (UNIQUE compuesto).
CREATE TABLE boletos (
    id_boleto       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion      INTEGER NOT NULL,
    nombre_cliente  TEXT NOT NULL,
    asiento         TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'vendido' CHECK (estado IN ('vendido', 'usado', 'reembolsado')),

    FOREIGN KEY (id_funcion) REFERENCES funciones (id_funcion),
    UNIQUE (id_funcion, asiento)
);
