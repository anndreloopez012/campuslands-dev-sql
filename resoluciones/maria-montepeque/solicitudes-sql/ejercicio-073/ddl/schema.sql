PRAGMA foreign_keys = ON;

-- Ejercicio 073: Clanes Shooter
-- Modelo: clanes -> jugadores (1:N); clanes -> scrims (1:N, como
-- local y como visitante); mapas -> scrims (1:N); scrims ->
-- resultados (1:1, con UNIQUE sobre id_scrim). El objetivo central es
-- evitar registros incompletos o duplicados, tal como lo pidio el
-- cliente.

CREATE TABLE clanes (
    id_clan      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_clan  TEXT NOT NULL UNIQUE,
    region       TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    nickname     TEXT NOT NULL UNIQUE,
    id_clan      INTEGER NOT NULL,

    FOREIGN KEY (id_clan) REFERENCES clanes (id_clan)
);

CREATE TABLE mapas (
    id_mapa       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_mapa   TEXT NOT NULL UNIQUE,
    modo_juego    TEXT NOT NULL CHECK (modo_juego IN ('busqueda', 'dominio', 'eliminacion'))
);

CREATE TABLE scrims (
    id_scrim             INTEGER PRIMARY KEY AUTOINCREMENT,
    id_clan_local         INTEGER NOT NULL,
    id_clan_visitante     INTEGER NOT NULL,
    id_mapa               INTEGER NOT NULL,
    fecha_scrim           TEXT NOT NULL,
    estado                 TEXT NOT NULL DEFAULT 'programado'
                               CHECK (estado IN ('programado', 'jugado', 'cancelado')),

    FOREIGN KEY (id_clan_local) REFERENCES clanes (id_clan),
    FOREIGN KEY (id_clan_visitante) REFERENCES clanes (id_clan),
    FOREIGN KEY (id_mapa) REFERENCES mapas (id_mapa)
);

-- resultados: el UNIQUE sobre id_scrim garantiza como maximo un
-- resultado oficial por scrim (relacion 1:1). Es la restriccion que
-- ataca directamente el problema del cliente: registros incompletos o
-- repetidos que arruinan los reportes.
CREATE TABLE resultados (
    id_resultado        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_scrim            INTEGER NOT NULL UNIQUE,
    id_clan_ganador      INTEGER,
    marcador_local        INTEGER NOT NULL CHECK (marcador_local >= 0),
    marcador_visitante    INTEGER NOT NULL CHECK (marcador_visitante >= 0),
    fecha_registro         TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_scrim) REFERENCES scrims (id_scrim),
    FOREIGN KEY (id_clan_ganador) REFERENCES clanes (id_clan)
);
