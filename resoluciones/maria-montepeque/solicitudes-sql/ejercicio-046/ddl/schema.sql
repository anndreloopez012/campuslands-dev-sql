PRAGMA foreign_keys = ON;

-- Ejercicio 046: Battle Royale Ranking
-- Modelo organizado en catalogos (jugadores, temporadas), operacion
-- (partidas) y resultados (estadisticas), tal como pidio el cliente.

-- Catalogo
CREATE TABLE jugadores (
    id_jugador     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_jugador TEXT NOT NULL UNIQUE,
    plataforma     TEXT NOT NULL CHECK (plataforma IN ('pc', 'consola', 'movil'))
);

-- Catalogo
CREATE TABLE temporadas (
    id_temporada     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_temporada TEXT NOT NULL UNIQUE,
    fecha_inicio     TEXT NOT NULL,
    fecha_fin        TEXT NOT NULL,
    estado           TEXT NOT NULL DEFAULT 'activa' CHECK (estado IN ('activa', 'cerrada')),

    CHECK (fecha_fin > fecha_inicio)
);

-- Operacion: un movimiento (una partida que se jugo).
CREATE TABLE partidas (
    id_partida     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_temporada   INTEGER NOT NULL,
    fecha_partida  TEXT NOT NULL,
    mapa           TEXT NOT NULL CHECK (mapa IN ('Isla Tormenta', 'Desierto Rojo', 'Zona Artica')),
    estado         TEXT NOT NULL DEFAULT 'en_curso' CHECK (estado IN ('en_curso', 'finalizada', 'anulada')),

    FOREIGN KEY (id_temporada) REFERENCES temporadas (id_temporada)
);

-- Resultado: lo que un jugador obtuvo en una partida especifica.
CREATE TABLE estadisticas (
    id_estadistica  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partida      INTEGER NOT NULL,
    id_jugador      INTEGER NOT NULL,
    kills           INTEGER NOT NULL DEFAULT 0 CHECK (kills >= 0),
    posicion_final  INTEGER NOT NULL CHECK (posicion_final > 0),
    puntos          INTEGER NOT NULL DEFAULT 0 CHECK (puntos >= 0),

    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);
