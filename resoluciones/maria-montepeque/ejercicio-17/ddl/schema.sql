PRAGMA foreign_keys = ON;

-- Ejercicio 17: Red Social Campus
-- Modelo: usuarios, publicaciones, comentarios, reacciones

CREATE TABLE usuarios (
    id_usuario      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_usuario  TEXT NOT NULL UNIQUE,
    correo          TEXT NOT NULL UNIQUE,
    fecha_registro  TEXT NOT NULL   -- ISO 'YYYY-MM-DD'
);

CREATE TABLE publicaciones (
    id_publicacion  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario      INTEGER NOT NULL,
    contenido       TEXT NOT NULL CHECK (length(contenido) > 0),
    fecha           TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'

    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);

CREATE TABLE comentarios (
    id_comentario   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_publicacion  INTEGER NOT NULL,
    id_usuario      INTEGER NOT NULL,
    contenido       TEXT NOT NULL,
    fecha           TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'

    FOREIGN KEY (id_publicacion) REFERENCES publicaciones (id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);

CREATE TABLE reacciones (
    id_reaccion     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_publicacion  INTEGER NOT NULL,
    id_usuario      INTEGER NOT NULL,
    tipo            TEXT NOT NULL CHECK (tipo IN ('like', 'love', 'haha', 'wow', 'sad', 'angry')),
    fecha           TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'

    UNIQUE (id_publicacion, id_usuario),
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones (id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);
