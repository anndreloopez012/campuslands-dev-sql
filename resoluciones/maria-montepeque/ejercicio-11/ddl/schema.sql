PRAGMA foreign_keys = ON;

-- Ejercicio 11: Transporte Rutas
-- Modelo: rutas, buses, conductores, viajes

CREATE TABLE rutas (
    id_ruta         INTEGER PRIMARY KEY AUTOINCREMENT,
    origen          TEXT NOT NULL,
    destino         TEXT NOT NULL,
    distancia_km    REAL NOT NULL CHECK (distancia_km > 0),

    UNIQUE (origen, destino)
);

CREATE TABLE buses (
    id_bus      INTEGER PRIMARY KEY AUTOINCREMENT,
    placa       TEXT NOT NULL UNIQUE,
    capacidad   INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE conductores (
    id_conductor    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL,
    licencia        TEXT NOT NULL UNIQUE
);

CREATE TABLE viajes (
    id_viaje        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ruta         INTEGER NOT NULL,
    id_bus          INTEGER NOT NULL,
    id_conductor    INTEGER NOT NULL,
    fecha_hora      TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    pasajeros       INTEGER NOT NULL CHECK (pasajeros >= 0),
    estado          TEXT NOT NULL DEFAULT 'programado' CHECK (estado IN ('programado', 'en_curso', 'finalizado', 'cancelado')),

    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
    FOREIGN KEY (id_bus) REFERENCES buses (id_bus),
    FOREIGN KEY (id_conductor) REFERENCES conductores (id_conductor),
    UNIQUE (id_bus, fecha_hora)
);
