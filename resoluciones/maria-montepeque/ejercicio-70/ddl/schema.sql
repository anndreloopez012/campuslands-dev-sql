PRAGMA foreign_keys = ON;

-- Ejercicio 70: DROP Nivel Aplicado
-- Tema central: DROP
-- Contexto: torneo de videojuegos, partidas y puntajes por equipo.

-- Tablas principales, permanentes.
CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE,
    region         TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    id_equipo    INTEGER NOT NULL,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local      INTEGER NOT NULL,
    id_equipo_visitante  INTEGER NOT NULL,
    fecha_partida        TEXT NOT NULL,
    puntaje_local         INTEGER NOT NULL DEFAULT 0 CHECK (puntaje_local >= 0),
    puntaje_visitante     INTEGER NOT NULL DEFAULT 0 CHECK (puntaje_visitante >= 0),
    estado                TEXT NOT NULL DEFAULT 'programada'
                              CHECK (estado IN ('programada', 'jugada', 'cancelada')),

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo)
);

-- Tabla temporal de importacion: el sistema del torneo exporto los
-- resultados de la primera jornada en un formato plano, sin las
-- restricciones finales, y se usa solo para migrar esos resultados a
-- `partidas`.
CREATE TABLE partidas_temporal (
    equipo_local_bruto      TEXT,
    equipo_visitante_bruto  TEXT,
    fecha_bruta             TEXT,
    marcador_local           INTEGER,
    marcador_visitante       INTEGER
);

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones del Norte', 'Norte'),
    ('Lobos del Sur', 'Sur'),
    ('Halcones del Centro', 'Centro'),
    ('Tigres del Oeste', 'Oeste');

INSERT INTO jugadores (nombre, id_equipo) VALUES
    ('Kevin Us', 1),
    ('Diana Perez', 1),
    ('Oscar Tzul', 2),
    ('Melissa Ordonez', 3),
    ('Sergio Batz', 4);

INSERT INTO partidas_temporal (equipo_local_bruto, equipo_visitante_bruto, fecha_bruta, marcador_local, marcador_visitante) VALUES
    ('Dragones del Norte', 'Lobos del Sur', '2026-08-01', 3, 1),
    ('Halcones del Centro', 'Tigres del Oeste', '2026-08-02', 2, 2);

-- Migracion: se traduce cada nombre bruto a su id_equipo real y el
-- resultado queda como partida ya jugada.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, puntaje_local, puntaje_visitante, estado)
SELECT
    eloc.id_equipo,
    evis.id_equipo,
    pt.fecha_bruta,
    pt.marcador_local,
    pt.marcador_visitante,
    'jugada'
FROM partidas_temporal pt
JOIN equipos eloc ON eloc.nombre_equipo = pt.equipo_local_bruto
JOIN equipos evis ON evis.nombre_equipo = pt.equipo_visitante_bruto;

-- Partidas de la siguiente jornada, cargadas directo en la tabla
-- definitiva (todavia no se jugaron).
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (2, 3, '2026-08-08', 'programada'),
    (4, 1, '2026-08-08', 'programada');

-- DROP TABLE: la tabla de importacion ya cumplio su proposito (los
-- resultados ya viven en `partidas`) y se elimina para no dejar datos
-- duplicados. Este es el riesgo de DROP: si se ejecutara antes de
-- migrar los datos, esos resultados se perderian para siempre.
DROP TABLE partidas_temporal;

-- El ciclo completo crear -> usar para el reporte oficial -> eliminar
-- de un indice y una vista de apoyo (tabla de posiciones) se hace en
-- dql/consultas.sql (consulta 5), despues de que ya existen datos
-- suficientes para que el reporte tenga sentido.

-- Caso que debe fallar / no recomendable (queda comentado): intentar
-- eliminar una tabla que todavia esta referenciada por FOREIGN KEY
-- desde otra tabla con filas. SQLite, con PRAGMA foreign_keys = ON, no
-- permite este DROP mientras existan jugadores o partidas que dependan
-- de equipos: hay que eliminar o reasignar esas filas primero.
-- DROP TABLE equipos;
