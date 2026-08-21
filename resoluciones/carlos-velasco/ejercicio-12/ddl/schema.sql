PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS reproducciones;
DROP TABLE IF EXISTS canciones;
DROP TABLE IF EXISTS albumes;
DROP TABLE IF EXISTS artistas;

-- ARTISTAS

CREATE TABLE artistas (
    id_artista INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    genero_principal TEXT NOT NULL,
    pais_origen TEXT NOT NULL,
    anio_inicio INTEGER NOT NULL,
    CHECK (length(trim(nombre)) >= 2),
    CHECK (anio_inicio BETWEEN 1900 AND 2100)
);

-- ALBUMES

CREATE TABLE albumes (
    id_album INTEGER PRIMARY KEY,
    id_artista INTEGER NOT NULL,
    titulo TEXT NOT NULL,
    fecha_lanzamiento TEXT NOT NULL,
    cantidad_canciones INTEGER NOT NULL,
    CHECK (
        fecha_lanzamiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
    ),
    CHECK (cantidad_canciones > 0),
    UNIQUE (id_artista, titulo),
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
);

-- CANCIONES

CREATE TABLE canciones (
    id_cancion INTEGER PRIMARY KEY,
    id_album INTEGER NOT NULL,
    titulo TEXT NOT NULL,
    duracion_segundos INTEGER NOT NULL,
    numero_pista INTEGER NOT NULL,
    CHECK (length(trim(titulo)) >= 2),
    CHECK (duracion_segundos BETWEEN 30 AND 900),
    CHECK (numero_pista > 0),
    UNIQUE (id_album, numero_pista),
    UNIQUE (id_album, titulo),
    FOREIGN KEY (id_album) REFERENCES albumes(id_album)
);

-- REPRODUCCIONES

CREATE TABLE reproducciones (
    id_reproduccion INTEGER PRIMARY KEY,
    id_cancion INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    dispositivo TEXT NOT NULL,
    segundos_escuchados INTEGER NOT NULL,
    CHECK (
        fecha_hora GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'
    ),
    CHECK (segundos_escuchados > 0),
    CHECK (
        dispositivo IN ('Movil', 'Web', 'Desktop', 'Smart TV')
    ),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion)
);

CREATE INDEX idx_albumes_artista
ON albumes(id_artista);

CREATE INDEX idx_canciones_album
ON canciones(id_album);

CREATE INDEX idx_reproducciones_cancion
ON reproducciones(id_cancion);

CREATE INDEX idx_reproducciones_fecha
ON reproducciones(fecha_hora);