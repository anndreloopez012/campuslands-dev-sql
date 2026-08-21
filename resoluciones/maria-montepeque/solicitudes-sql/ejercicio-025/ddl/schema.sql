PRAGMA foreign_keys = ON;

-- Ejercicio 025: Track Day Hiperdeportivos
-- Modelo: pilotos -> vehiculos (1:N) -> sesiones (1:N).

CREATE TABLE pilotos (
    id_piloto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_piloto TEXT NOT NULL UNIQUE,
    licencia      TEXT NOT NULL UNIQUE,
    categoria     TEXT NOT NULL CHECK (categoria IN ('amateur', 'semi_profesional', 'profesional'))
);

CREATE TABLE vehiculos (
    id_vehiculo  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_piloto    INTEGER NOT NULL,
    modelo       TEXT NOT NULL,
    potencia_hp  INTEGER NOT NULL CHECK (potencia_hp > 0),

    FOREIGN KEY (id_piloto) REFERENCES pilotos (id_piloto)
);

-- sesiones: tabla principal. estado permite corregir una vuelta
-- sospechosa (corte de pista) sin borrar el registro.
CREATE TABLE sesiones (
    id_sesion               INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo             INTEGER NOT NULL,
    tiempo_vuelta_segundos  REAL NOT NULL CHECK (tiempo_vuelta_segundos > 0),
    fecha_sesion            TEXT NOT NULL DEFAULT (datetime('now')),
    clima                   TEXT NOT NULL CHECK (clima IN ('seco', 'lluvia', 'nublado')),
    estado                  TEXT NOT NULL DEFAULT 'valida' CHECK (estado IN ('valida', 'descalificada', 'en_revision')),

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
);
