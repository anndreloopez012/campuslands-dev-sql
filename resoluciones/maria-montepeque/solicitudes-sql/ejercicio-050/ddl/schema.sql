PRAGMA foreign_keys = ON;

-- Ejercicio 050: Track Day Hiperdeportivos
-- Modelo: pilotos, vehiculos y sesiones alimentan tiempos (triple
-- FOREIGN KEY). Cada restriccion ataca uno de los tres errores que
-- pidio detectar el cliente: repetidos (UNIQUE), relaciones
-- invalidas (FOREIGN KEY) y valores fuera de rango (CHECK).

CREATE TABLE pilotos (
    id_piloto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_piloto TEXT NOT NULL UNIQUE,
    licencia      TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
    id_vehiculo  INTEGER PRIMARY KEY AUTOINCREMENT,
    placa        TEXT NOT NULL UNIQUE,
    modelo       TEXT NOT NULL,
    potencia_hp  INTEGER NOT NULL CHECK (potencia_hp > 0)
);

CREATE TABLE sesiones (
    id_sesion      INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_sesion  INTEGER NOT NULL UNIQUE CHECK (numero_sesion > 0),
    fecha_sesion   TEXT NOT NULL,
    pista          TEXT NOT NULL CHECK (pista IN ('circuito_norte', 'circuito_sur', 'circuito_mixto'))
);

-- tiempos: tabla principal. tiempo_segundos = 0 representa una
-- vuelta que nunca se completo (ver supuestos).
CREATE TABLE tiempos (
    id_tiempo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_piloto        INTEGER NOT NULL,
    id_vehiculo      INTEGER NOT NULL,
    id_sesion        INTEGER NOT NULL,
    vuelta           INTEGER NOT NULL CHECK (vuelta > 0),
    tiempo_segundos  REAL NOT NULL CHECK (tiempo_segundos >= 0),
    estado           TEXT NOT NULL DEFAULT 'valido' CHECK (estado IN ('valido', 'invalido', 'descalificado')),

    FOREIGN KEY (id_piloto) REFERENCES pilotos (id_piloto),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo),
    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
);
