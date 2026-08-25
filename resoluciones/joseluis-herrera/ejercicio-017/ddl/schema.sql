PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS reacciones;
DROP TABLE IF EXISTS comentarios;
DROP TABLE IF EXISTS publicaciones;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    nombre_usuario TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL CHECK (date(fecha_registro) IS NOT NULL)
);

CREATE TABLE publicaciones (
    id_publicacion INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TEXT NOT NULL CHECK (datetime(fecha_publicacion) IS NOT NULL),
    vistas INTEGER NOT NULL DEFAULT 0 CHECK (vistas >= 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('publicada', 'oculta', 'eliminada')
    ),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE comentarios (
    id_comentario INTEGER PRIMARY KEY,
    id_publicacion INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    contenido TEXT NOT NULL,
    fecha_comentario TEXT NOT NULL CHECK (datetime(fecha_comentario) IS NOT NULL),
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE reacciones (
    id_reaccion INTEGER PRIMARY KEY,
    id_publicacion INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    tipo TEXT NOT NULL CHECK (
        tipo IN ('me_gusta', 'me_encanta', 'me_divierte', 'me_sorprende')
    ),
    fecha_reaccion TEXT NOT NULL CHECK (date(fecha_reaccion) IS NOT NULL),
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    UNIQUE (id_publicacion, id_usuario)
);

CREATE INDEX idx_publicaciones_usuario
ON publicaciones(id_usuario);

CREATE INDEX idx_publicaciones_fecha
ON publicaciones(fecha_publicacion);

CREATE INDEX idx_comentarios_publicacion
ON comentarios(id_publicacion);

CREATE INDEX idx_comentarios_usuario
ON comentarios(id_usuario);

CREATE INDEX idx_reacciones_publicacion
ON reacciones(id_publicacion);

CREATE INDEX idx_reacciones_usuario
ON reacciones(id_usuario);