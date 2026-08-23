PRAGMA foreign_keys = ON;

-- Ejercicio 012: Club Futbol Sala
-- Modelo minimo: catalogo de equipos y registro de eventos (goles y
-- tarjetas, cada uno con su valor monetario: bono o multa).

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    categoria     TEXT NOT NULL CHECK (categoria IN ('primera', 'segunda', 'juvenil'))
);

-- eventos: tabla principal. Responde quien (nombre_jugador), que
-- (tipo_evento), cuando (fecha_partido) y cuanto dinero representa
-- (monto: bono por gol o multa por tarjeta).
CREATE TABLE eventos (
    id_evento      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo      INTEGER NOT NULL,
    nombre_jugador TEXT NOT NULL,
    tipo_evento    TEXT NOT NULL CHECK (tipo_evento IN ('gol', 'tarjeta_amarilla', 'tarjeta_roja')),
    fecha_partido  TEXT NOT NULL DEFAULT (date('now')),
    monto          REAL NOT NULL CHECK (monto >= 0),
    estado         TEXT NOT NULL DEFAULT 'registrado' CHECK (estado IN ('registrado', 'pagado', 'anulado')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);
