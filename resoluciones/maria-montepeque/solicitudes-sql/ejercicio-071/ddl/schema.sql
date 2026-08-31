PRAGMA foreign_keys = ON;

-- Ejercicio 071: Battle Royale Ranking
-- Modelo: temporadas -> partidas (1:N); partidas + jugadores ->
-- estadisticas (1:N cada una); temporadas + jugadores -> ranking
-- (1:N cada una). El UNIQUE compuesto en estadisticas ataca
-- directamente el problema del cliente: datos duplicados en la hoja
-- de calculo.

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    nickname     TEXT NOT NULL UNIQUE,
    region       TEXT NOT NULL
);

CREATE TABLE temporadas (
    id_temporada     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_temporada TEXT NOT NULL UNIQUE,
    fecha_inicio     TEXT NOT NULL,
    fecha_fin        TEXT NOT NULL,

    CHECK (fecha_fin > fecha_inicio)
);

CREATE TABLE partidas (
    id_partida     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_temporada   INTEGER NOT NULL,
    fecha_partida  TEXT NOT NULL,
    mapa           TEXT NOT NULL,
    estado         TEXT NOT NULL DEFAULT 'programada'
                       CHECK (estado IN ('programada', 'jugada', 'cancelada')),

    FOREIGN KEY (id_temporada) REFERENCES temporadas (id_temporada)
);

-- estadisticas: detalle de cada partida. El UNIQUE compuesto impide
-- que el mismo jugador quede cargado dos veces en la misma partida,
-- que es justo el problema que el cliente describio de la hoja de
-- calculo.
CREATE TABLE estadisticas (
    id_estadistica   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partida       INTEGER NOT NULL,
    id_jugador       INTEGER NOT NULL,
    kills            INTEGER NOT NULL DEFAULT 0 CHECK (kills >= 0),
    posicion_final   INTEGER NOT NULL CHECK (posicion_final >= 1),

    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    UNIQUE (id_partida, id_jugador)
);

-- ranking: resumen por temporada. Tambien lleva un UNIQUE compuesto:
-- un jugador solo tiene una fila de ranking por temporada, que se
-- corrige con UPDATE a medida que se juegan mas partidas.
CREATE TABLE ranking (
    id_ranking       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_temporada     INTEGER NOT NULL,
    id_jugador       INTEGER NOT NULL,
    puntos_totales   INTEGER NOT NULL DEFAULT 0 CHECK (puntos_totales >= 0),

    FOREIGN KEY (id_temporada) REFERENCES temporadas (id_temporada),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    UNIQUE (id_temporada, id_jugador)
);
