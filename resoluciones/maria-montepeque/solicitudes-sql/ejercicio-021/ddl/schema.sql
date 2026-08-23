PRAGMA foreign_keys = ON;

-- Ejercicio 021: Battle Royale Ranking
-- Modelo: dos catalogos (jugadores, partidas) y una tabla de detalle
-- (estadisticas) que resuelve la relacion muchos-a-muchos entre ellos,
-- siguiendo el ejemplo de razonamiento del enunciado (ventas + detalle_ventas).

-- jugadores: catalogo.
CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY AUTOINCREMENT,
    gamertag   TEXT NOT NULL UNIQUE,
    equipo     TEXT NOT NULL,
    nivel      INTEGER NOT NULL DEFAULT 1 CHECK (nivel > 0)
);

-- partidas: catalogo.
CREATE TABLE partidas (
    id_partida       INTEGER PRIMARY KEY AUTOINCREMENT,
    mapa             TEXT NOT NULL CHECK (mapa IN ('desierto', 'isla', 'urbano', 'nieve')),
    fecha_partida    TEXT NOT NULL DEFAULT (datetime('now')),
    total_jugadores  INTEGER NOT NULL CHECK (total_jugadores > 0)
);

-- estadisticas: tabla de detalle (principal). Conecta un jugador con una
-- partida especifica: cuantos kills hizo y en que posicion termino.
-- estado permite corregir una estadistica sospechosa sin borrarla.
CREATE TABLE estadisticas (
    id_estadistica  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jugador      INTEGER NOT NULL,
    id_partida      INTEGER NOT NULL,
    kills           INTEGER NOT NULL DEFAULT 0 CHECK (kills >= 0),
    posicion_final  INTEGER NOT NULL CHECK (posicion_final > 0),
    estado          TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_revision', 'anulada')),

    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida)
);
