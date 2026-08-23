PRAGMA foreign_keys = ON;

-- Ejercicio 12: Streaming Musica
-- Modelo: artistas, albumes, canciones, reproducciones

CREATE TABLE artistas (
    id_artista  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE,
    pais        TEXT NOT NULL
);

CREATE TABLE albumes (
    id_album            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_artista          INTEGER NOT NULL,
    titulo              TEXT NOT NULL,
    anio_lanzamiento    INTEGER NOT NULL CHECK (anio_lanzamiento BETWEEN 1900 AND 2100),

    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista),
    UNIQUE (id_artista, titulo)
);

CREATE TABLE canciones (
    id_cancion          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_album            INTEGER NOT NULL,
    titulo              TEXT NOT NULL,
    duracion_segundos   INTEGER NOT NULL CHECK (duracion_segundos > 0),
    genero              TEXT NOT NULL,

    FOREIGN KEY (id_album) REFERENCES albumes (id_album),
    UNIQUE (id_album, titulo)
);

CREATE TABLE reproducciones (
    id_reproduccion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cancion      INTEGER NOT NULL,
    usuario         TEXT NOT NULL,
    fecha_hora      TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    dispositivo     TEXT NOT NULL DEFAULT 'movil' CHECK (dispositivo IN ('movil', 'web', 'escritorio', 'tablet')),

    FOREIGN KEY (id_cancion) REFERENCES canciones (id_cancion)
);
