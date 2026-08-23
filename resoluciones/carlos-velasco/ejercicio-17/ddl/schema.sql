PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS reacciones;
DROP TABLE IF EXISTS comentarios;
DROP TABLE IF EXISTS publicaciones;
DROP TABLE IF EXISTS usuarios;

-- USUARIOS

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    nombre_usuario TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL,
    CHECK (length(nombre_completo) >= 3),
    CHECK (fecha_registro GLOB '____-__-__')
);

-- PUBLICACIONES

CREATE TABLE publicaciones (
    id_publicacion INTEGER PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TEXT NOT NULL,
    visibilidad TEXT NOT NULL DEFAULT 'publica',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario),
    CHECK (length(contenido) >= 5),
    CHECK (visibilidad IN ('publica', 'privada'))
);

-- COMENTARIOS

CREATE TABLE comentarios (
    id_comentario INTEGER PRIMARY KEY,
    publicacion_id INTEGER NOT NULL,
    usuario_id INTEGER NOT NULL,
    contenido TEXT NOT NULL,
    fecha_comentario TEXT NOT NULL,
    FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario),
    CHECK (length(contenido) >= 2),
    CHECK (fecha_comentario GLOB '____-__-__')
);

-- REACCIONES

CREATE TABLE reacciones (
    id_reaccion INTEGER PRIMARY KEY,
    publicacion_id INTEGER NOT NULL,
    usuario_id INTEGER NOT NULL,
    tipo TEXT NOT NULL,
    fecha_reaccion TEXT NOT NULL,
    FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario),
    UNIQUE (publicacion_id, usuario_id),
    CHECK (tipo IN ('me_gusta', 'me_encanta', 'me_interesa')),
    CHECK (fecha_reaccion GLOB '____-__-__')
);

CREATE INDEX idx_publicaciones_usuario
ON publicaciones(usuario_id);

CREATE INDEX idx_publicaciones_fecha
ON publicaciones(fecha_publicacion);

CREATE INDEX idx_comentarios_publicacion
ON comentarios(publicacion_id);

CREATE INDEX idx_reacciones_publicacion
ON reacciones(publicacion_id);