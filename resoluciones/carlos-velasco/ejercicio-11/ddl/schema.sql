PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS viajes;
DROP TABLE IF EXISTS conductores;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS rutas;

-- RUTAS

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE,
    origen TEXT NOT NULL,
    destino TEXT NOT NULL,
    distancia_km REAL NOT NULL,
    CHECK (length(trim(origen)) >= 3),
    CHECK (length(trim(destino)) >= 3),
    CHECK (origen <> destino),
    CHECK (distancia_km > 0)
);

-- BUSES

CREATE TABLE buses (
    id_bus INTEGER PRIMARY KEY,
    placa TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    capacidad INTEGER NOT NULL,
    anio INTEGER NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Disponible',
    CHECK (capacidad BETWEEN 10 AND 80),
    CHECK (anio BETWEEN 2000 AND 2030),
    CHECK (estado IN ('Disponible', 'Mantenimiento', 'Fuera de Servicio'))
);

-- CONDUCTORES

CREATE TABLE conductores (
    id_conductor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    licencia TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (length(trim(telefono)) >= 7),
    CHECK (estado IN ('Activo', 'Inactivo', 'Vacaciones'))
);

-- VIAJES

CREATE TABLE viajes (
    id_viaje INTEGER PRIMARY KEY,
    id_ruta INTEGER NOT NULL,
    id_bus INTEGER NOT NULL,
    id_conductor INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    pasajeros_registrados INTEGER NOT NULL DEFAULT 0,
    estado TEXT NOT NULL DEFAULT 'Programado',
    CHECK (fecha_hora GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    CHECK (pasajeros_registrados >= 0),
    CHECK (estado IN ('Programado', 'En Curso', 'Completado', 'Cancelado')),
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
    FOREIGN KEY (id_bus) REFERENCES buses(id_bus),
    FOREIGN KEY (id_conductor) REFERENCES conductores(id_conductor),
    UNIQUE (id_bus, fecha_hora),
    UNIQUE (id_conductor, fecha_hora)
);

CREATE INDEX idx_viajes_fecha_hora
ON viajes(fecha_hora);

CREATE INDEX idx_viajes_ruta
ON viajes(id_ruta);

CREATE INDEX idx_viajes_bus
ON viajes(id_bus);

CREATE INDEX idx_viajes_conductor
ON viajes(id_conductor);