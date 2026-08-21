PRAGMA foreign_keys = ON;

-- Ejercicio 017: Streaming Musica
-- Modelo minimo: catalogo de artistas y registro de canciones.

CREATE TABLE artistas (
    id_artista       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista   TEXT NOT NULL UNIQUE,
    genero_principal TEXT NOT NULL CHECK (genero_principal IN ('pop', 'rock', 'reggaeton', 'jazz', 'electronica'))
);

-- canciones: tabla principal. estado permite corregir la situacion de
-- una cancion (retirada, bloqueada) sin borrar su registro, tal como
-- pidio el cliente explicitamente.
CREATE TABLE canciones (
    id_cancion        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_artista        INTEGER NOT NULL,
    titulo            TEXT NOT NULL,
    duracion_segundos INTEGER NOT NULL CHECK (duracion_segundos > 0),
    fecha_lanzamiento TEXT NOT NULL DEFAULT (date('now')),
    estado            TEXT NOT NULL DEFAULT 'disponible' CHECK (estado IN ('disponible', 'retirada_temporalmente', 'bloqueada_por_derechos')),

    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);
