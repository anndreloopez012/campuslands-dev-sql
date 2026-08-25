PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS reproducciones;
DROP TABLE IF EXISTS canciones;
DROP TABLE IF EXISTS albumes;
DROP TABLE IF EXISTS artistas;

CREATE TABLE artistas (
    id_artista INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    genero_principal TEXT NOT NULL,
    pais_origen TEXT NOT NULL
);

CREATE TABLE albumes (
    id_album INTEGER PRIMARY KEY,
    id_artista INTEGER NOT NULL,
    titulo TEXT NOT NULL,
    fecha_lanzamiento TEXT NOT NULL,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista),
    UNIQUE (id_artista, titulo),
    CHECK (length(fecha_lanzamiento) = 10)
);

CREATE TABLE canciones (
    id_cancion INTEGER PRIMARY KEY,
    id_album INTEGER NOT NULL,
    titulo TEXT NOT NULL,
    duracion_segundos INTEGER NOT NULL,
    numero_pista INTEGER NOT NULL,
    FOREIGN KEY (id_album) REFERENCES albumes(id_album),
    UNIQUE (id_album, titulo),
    CHECK (duracion_segundos > 0),
    CHECK (numero_pista > 0)
);

CREATE TABLE reproducciones (
    id_reproduccion INTEGER PRIMARY KEY,
    id_cancion INTEGER NOT NULL,
    fecha_reproduccion TEXT NOT NULL,
    segundos_reproducidos INTEGER NOT NULL,
    dispositivo TEXT NOT NULL,
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion),
    CHECK (segundos_reproducidos > 0),
    CHECK (length(fecha_reproduccion) >= 10)
);

CREATE INDEX idx_albumes_artista
ON albumes(id_artista);

CREATE INDEX idx_canciones_album
ON canciones(id_album);

CREATE INDEX idx_reproducciones_cancion
ON reproducciones(id_cancion);

CREATE INDEX idx_reproducciones_fecha
ON reproducciones(fecha_reproduccion);