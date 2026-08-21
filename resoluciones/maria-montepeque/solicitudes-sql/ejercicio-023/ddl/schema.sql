PRAGMA foreign_keys = ON;

-- Ejercicio 023: Clanes Shooter
-- Modelo: clanes -> jugadores (1:N) y clanes -> scrims (1:N, dos veces:
-- como local y como rival).

CREATE TABLE clanes (
    id_clan     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_clan TEXT NOT NULL UNIQUE,
    region      TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY AUTOINCREMENT,
    id_clan    INTEGER NOT NULL,
    gamertag   TEXT NOT NULL UNIQUE,
    rol        TEXT NOT NULL CHECK (rol IN ('entry', 'support', 'sniper', 'igl')),

    FOREIGN KEY (id_clan) REFERENCES clanes (id_clan)
);

-- scrims: tabla principal. NOT NULL en los campos que, si faltaran,
-- harian que un reporte de victorias no sea confiable (la queja central
-- del cliente).
CREATE TABLE scrims (
    id_scrim        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_clan_local   INTEGER NOT NULL,
    id_clan_rival   INTEGER NOT NULL,
    mapa            TEXT NOT NULL CHECK (mapa IN ('bunker', 'puerto', 'ciudad', 'desierto')),
    marcador_local  INTEGER NOT NULL CHECK (marcador_local >= 0),
    marcador_rival  INTEGER NOT NULL CHECK (marcador_rival >= 0),
    fecha_scrim     TEXT NOT NULL DEFAULT (datetime('now')),
    estado          TEXT NOT NULL DEFAULT 'jugado' CHECK (estado IN ('jugado', 'disputado', 'anulado')),

    FOREIGN KEY (id_clan_local) REFERENCES clanes (id_clan),
    FOREIGN KEY (id_clan_rival) REFERENCES clanes (id_clan),
    CHECK (id_clan_local <> id_clan_rival)
);
