PRAGMA foreign_keys = ON;

-- Ejercicio 52: UNIQUE Nivel Aplicado
-- Tema central: UNIQUE
-- Contexto: torneo de videojuegos (equipos, jugadores y partidas).

CREATE TABLE equipos (
    id_equipo  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE   -- UNIQUE simple
);

-- jugadores: el nickname NO lleva UNIQUE como restriccion de columna, sino
-- como INDICE UNICO SOBRE UNA EXPRESION (ver mas abajo). Esto es lo nuevo
-- del nivel aplicado: un UNIQUE de columna compara los valores tal cual se
-- guardaron, asi que "ProGamer" y "progamer" se considerarian DISTINTOS y
-- ambos se aceptarian, permitiendo un nickname casi duplicado. Para un
-- torneo, eso es justamente lo que se quiere evitar.
CREATE TABLE jugadores (
    id_jugador  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo   INTEGER NOT NULL,
    nickname    TEXT NOT NULL,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- UNIQUE por expresion: aplica la unicidad sobre LOWER(nickname), no sobre
-- nickname tal cual. Con esto, "ProGamer" y "progamer" SI chocan entre si,
-- porque ambos normalizan a "progamer".
CREATE UNIQUE INDEX idx_jugadores_nickname_lower ON jugadores (LOWER(nickname));

-- partidas: UNIQUE COMPUESTO sobre (equipo_local, equipo_visitante,
-- fecha_partida), para no registrar el mismo enfrentamiento dos veces en la
-- misma fecha (revision del concepto de UNIQUE compuesto del ejercicio 51,
-- ahora aplicado a un caso de negocio distinto).
CREATE TABLE partidas (
    id_partida            INTEGER PRIMARY KEY AUTOINCREMENT,
    equipo_local          INTEGER NOT NULL,
    equipo_visitante      INTEGER NOT NULL,
    fecha_partida         TEXT NOT NULL,
    marcador_local        INTEGER NOT NULL CHECK (marcador_local >= 0),
    marcador_visitante    INTEGER NOT NULL CHECK (marcador_visitante >= 0),
    mvp_jugador           INTEGER,   -- NULLABLE: jugador destacado de la partida

    FOREIGN KEY (equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (equipo_visitante) REFERENCES equipos (id_equipo),
    FOREIGN KEY (mvp_jugador) REFERENCES jugadores (id_jugador),
    CHECK (equipo_local <> equipo_visitante),
    UNIQUE (equipo_local, equipo_visitante, fecha_partida)
);
