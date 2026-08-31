PRAGMA foreign_keys = ON;

-- Ejercicio 075: Track Day Hiperdeportivos
-- Modelo: sesiones + pilotos + vehiculos -> tiempos (1:N cada una);
-- pilotos + sesiones -> pagos (1:N cada una).

CREATE TABLE pilotos (
    id_piloto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_piloto  TEXT NOT NULL UNIQUE,
    licencia       TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
    id_vehiculo   INTEGER PRIMARY KEY AUTOINCREMENT,
    modelo        TEXT NOT NULL UNIQUE,
    categoria     TEXT NOT NULL CHECK (categoria IN ('hipercar', 'superdeportivo', 'gt'))
);

CREATE TABLE sesiones (
    id_sesion       INTEGER PRIMARY KEY AUTOINCREMENT,
    fecha_sesion    TEXT NOT NULL,
    pista           TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'programada'
                        CHECK (estado IN ('programada', 'en_curso', 'finalizada', 'cancelada'))
);

-- tiempos: el UNIQUE compuesto impide que un piloto quede cargado dos
-- veces en la misma vuelta de la misma sesion.
CREATE TABLE tiempos (
    id_tiempo         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_sesion         INTEGER NOT NULL,
    id_piloto         INTEGER NOT NULL,
    id_vehiculo       INTEGER NOT NULL,
    vuelta            INTEGER NOT NULL CHECK (vuelta >= 1),
    tiempo_segundos   REAL NOT NULL CHECK (tiempo_segundos > 0),

    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion),
    FOREIGN KEY (id_piloto) REFERENCES pilotos (id_piloto),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo),
    UNIQUE (id_sesion, id_piloto, vuelta)
);

CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_piloto     INTEGER NOT NULL,
    id_sesion     INTEGER NOT NULL,
    monto         REAL NOT NULL CHECK (monto > 0),
    estado        TEXT NOT NULL DEFAULT 'pendiente'
                      CHECK (estado IN ('pendiente', 'pagado', 'reembolsado')),
    fecha_pago    TEXT,

    FOREIGN KEY (id_piloto) REFERENCES pilotos (id_piloto),
    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
);
