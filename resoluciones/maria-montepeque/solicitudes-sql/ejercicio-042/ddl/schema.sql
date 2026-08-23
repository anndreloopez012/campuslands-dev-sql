PRAGMA foreign_keys = ON;

-- Ejercicio 042: Streaming Musica
-- Modelo: artistas -> canciones (1:N), y usuarios + canciones ->
-- reproducciones (doble FOREIGN KEY). 4 tablas en total.

CREATE TABLE artistas (
    id_artista     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista TEXT NOT NULL UNIQUE,
    genero         TEXT NOT NULL CHECK (genero IN ('pop', 'rock', 'electronica', 'jazz'))
);

-- Un mismo artista no puede repetir titulo (UNIQUE compuesto), pero
-- dos artistas distintos si pueden tener canciones con el mismo
-- nombre.
CREATE TABLE canciones (
    id_cancion         INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo             TEXT NOT NULL,
    id_artista         INTEGER NOT NULL,
    duracion_segundos  INTEGER NOT NULL CHECK (duracion_segundos > 0),

    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista),
    UNIQUE (titulo, id_artista)
);

CREATE TABLE usuarios (
    id_usuario     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_usuario TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE,
    plan           TEXT NOT NULL CHECK (plan IN ('gratuito', 'premium'))
);

-- reproducciones: tabla principal. Registra quien, que, cuando y
-- cuanto dinero (regalia) representa cada reproduccion.
CREATE TABLE reproducciones (
    id_reproduccion     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario          INTEGER NOT NULL,
    id_cancion          INTEGER NOT NULL,
    fecha_reproduccion  TEXT NOT NULL,
    monto_regalia       REAL NOT NULL CHECK (monto_regalia >= 0),
    estado              TEXT NOT NULL DEFAULT 'contabilizada' CHECK (estado IN ('contabilizada', 'en_revision', 'fraudulenta')),

    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES canciones (id_cancion)
);
