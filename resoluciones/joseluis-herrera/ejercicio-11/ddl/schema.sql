PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS viajes;
DROP TABLE IF EXISTS conductores;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS rutas;

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    origen TEXT NOT NULL,
    destino TEXT NOT NULL,
    distancia_km REAL NOT NULL CHECK (distancia_km > 0),
    UNIQUE (origen, destino)
);

CREATE TABLE buses (
    id_bus INTEGER PRIMARY KEY,
    placa TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE conductores (
    id_conductor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    licencia TEXT NOT NULL UNIQUE,
    experiencia_anios INTEGER NOT NULL CHECK (experiencia_anios >= 0)
);

CREATE TABLE viajes (
    id_viaje INTEGER PRIMARY KEY,
    id_ruta INTEGER NOT NULL,
    id_bus INTEGER NOT NULL,
    id_conductor INTEGER NOT NULL,
    fecha_viaje TEXT NOT NULL,
    hora_salida TEXT NOT NULL,
    pasajeros INTEGER NOT NULL CHECK (pasajeros >= 0),
    estado TEXT NOT NULL DEFAULT 'Programado'
        CHECK (estado IN ('Programado', 'En curso', 'Finalizado', 'Cancelado')),
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
    FOREIGN KEY (id_bus) REFERENCES buses(id_bus),
    FOREIGN KEY (id_conductor) REFERENCES conductores(id_conductor)
);

CREATE INDEX idx_viajes_fecha ON viajes(fecha_viaje);
CREATE INDEX idx_viajes_ruta ON viajes(id_ruta);
CREATE INDEX idx_viajes_bus ON viajes(id_bus);
CREATE INDEX idx_viajes_conductor ON viajes(id_conductor);