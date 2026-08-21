PRAGMA foreign_keys = ON;

-- Ejercicio 067: Streaming Musica
-- Modelo: artistas, canciones, usuarios, playlists, reproducciones

CREATE TABLE artistas (
    id_artista   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE
);

CREATE TABLE canciones (
    id_cancion            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_artista            INTEGER NOT NULL,
    titulo                TEXT NOT NULL,
    duracion_segundos     INTEGER NOT NULL CHECK (duracion_segundos > 0),
    genero                TEXT NOT NULL CHECK (genero IN ('pop', 'rock', 'reggaeton', 'electronica')),

    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);

CREATE TABLE usuarios (
    id_usuario   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    email        TEXT NOT NULL UNIQUE,
    plan         TEXT NOT NULL DEFAULT 'gratuito' CHECK (plan IN ('gratuito', 'premium'))
);

-- playlists: el estado se corrige (activa <-> archivada) en vez de
-- borrar la playlist, para no perder informacion del usuario.
CREATE TABLE playlists (
    id_playlist   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario    INTEGER NOT NULL,
    nombre        TEXT NOT NULL,
    estado        TEXT NOT NULL DEFAULT 'activa' CHECK (estado IN ('activa', 'archivada')),

    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);

CREATE TABLE reproducciones (
    id_reproduccion       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario            INTEGER NOT NULL,
    id_cancion            INTEGER NOT NULL,
    fecha_reproduccion    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES canciones (id_cancion)
);
