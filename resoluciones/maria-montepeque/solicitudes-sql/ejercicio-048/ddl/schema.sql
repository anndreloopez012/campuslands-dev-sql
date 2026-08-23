PRAGMA foreign_keys = ON;

-- Ejercicio 048: Clanes Shooter
-- Modelo: clanes -> jugadores (1:N), y clanes (como rival) + mapas ->
-- scrims (doble FOREIGN KEY). 4 tablas en total.

CREATE TABLE clanes (
    id_clan     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_clan TEXT NOT NULL UNIQUE,
    tag         TEXT NOT NULL UNIQUE,
    region      TEXT NOT NULL CHECK (region IN ('LATAM', 'NA', 'EU', 'APAC'))
);

CREATE TABLE jugadores (
    id_jugador     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_jugador TEXT NOT NULL UNIQUE,
    id_clan        INTEGER NOT NULL,
    rol            TEXT NOT NULL CHECK (rol IN ('entry', 'support', 'sniper', 'igl')),

    FOREIGN KEY (id_clan) REFERENCES clanes (id_clan)
);

CREATE TABLE mapas (
    id_mapa     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_mapa TEXT NOT NULL UNIQUE,
    modo        TEXT NOT NULL CHECK (modo IN ('busqueda_y_destruccion', 'dominio', 'eliminacion_por_equipos'))
);

-- scrims: tabla principal. id_clan_rival apunta al mismo catalogo
-- clanes que usan los jugadores (ver supuestos).
CREATE TABLE scrims (
    id_scrim          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_clan_rival     INTEGER NOT NULL,
    id_mapa           INTEGER NOT NULL,
    fecha_scrim       TEXT NOT NULL,
    rondas_ganadas    INTEGER NOT NULL DEFAULT 0 CHECK (rondas_ganadas >= 0),
    rondas_perdidas   INTEGER NOT NULL DEFAULT 0 CHECK (rondas_perdidas >= 0),
    estado            TEXT NOT NULL DEFAULT 'programado' CHECK (estado IN ('programado', 'jugado', 'cancelado')),

    FOREIGN KEY (id_clan_rival) REFERENCES clanes (id_clan),
    FOREIGN KEY (id_mapa) REFERENCES mapas (id_mapa)
);
