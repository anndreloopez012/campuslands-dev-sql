PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS resultados;
DROP TABLE IF EXISTS partidas;
DROP TABLE IF EXISTS jugadores;
DROP TABLE IF EXISTS equipos;

CREATE TABLE equipos (
    id_equipo INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    region TEXT NOT NULL,
    fecha_fundacion TEXT NOT NULL,

    CONSTRAINT chk_equipo_nombre
        CHECK (length(trim(nombre)) >= 3),

    CONSTRAINT chk_equipo_fecha
        CHECK (
            fecha_fundacion GLOB
            '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        )
);

CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY,
    nickname TEXT NOT NULL UNIQUE,
    nombre_completo TEXT NOT NULL,
    rol TEXT NOT NULL,
    id_equipo INTEGER NOT NULL,

    FOREIGN KEY (id_equipo)
        REFERENCES equipos(id_equipo),

    CONSTRAINT chk_jugador_rol
        CHECK (
            rol IN (
                'TOP',
                'JUNGLA',
                'MID',
                'ADC',
                'SOPORTE'
            )
        )
);

CREATE TABLE partidas (
    id_partida INTEGER PRIMARY KEY,
    id_equipo_local INTEGER NOT NULL,
    id_equipo_visitante INTEGER NOT NULL,
    fecha_partida TEXT NOT NULL,
    fase TEXT NOT NULL,

    FOREIGN KEY (id_equipo_local)
        REFERENCES equipos(id_equipo),

    FOREIGN KEY (id_equipo_visitante)
        REFERENCES equipos(id_equipo),

    CONSTRAINT chk_partida_equipos
        CHECK (id_equipo_local <> id_equipo_visitante),

    CONSTRAINT chk_partida_fase
        CHECK (
            fase IN (
                'GRUPOS',
                'CUARTOS',
                'SEMIFINAL',
                'FINAL'
            )
        ),

    CONSTRAINT chk_partida_fecha
        CHECK (
            fecha_partida GLOB
            '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] *'
        )
);

CREATE TABLE resultados (
    id_resultado INTEGER PRIMARY KEY,
    id_partida INTEGER NOT NULL UNIQUE,
    ganador_id_equipo INTEGER NOT NULL,
    puntos_local INTEGER NOT NULL,
    puntos_visitante INTEGER NOT NULL,
    duracion_minutos INTEGER NOT NULL,

    FOREIGN KEY (id_partida)
        REFERENCES partidas(id_partida),

    FOREIGN KEY (ganador_id_equipo)
        REFERENCES equipos(id_equipo),

    CONSTRAINT chk_resultado_puntos_local
        CHECK (puntos_local >= 0),

    CONSTRAINT chk_resultado_puntos_visitante
        CHECK (puntos_visitante >= 0),

    CONSTRAINT chk_resultado_duracion
        CHECK (duracion_minutos > 0),

    CONSTRAINT chk_resultado_ganador
        CHECK (
            puntos_local <> puntos_visitante
        )
);