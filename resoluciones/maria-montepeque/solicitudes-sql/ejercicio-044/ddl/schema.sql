PRAGMA foreign_keys = ON;

-- Ejercicio 044: Diseno 3D Arquitectura
-- Modelo: clientes -> proyectos -> renders -> revisiones, una cadena
-- de FOREIGN KEY de 4 tablas.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE
);

CREATE TABLE proyectos (
    id_proyecto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_proyecto TEXT NOT NULL UNIQUE,
    id_cliente      INTEGER NOT NULL,
    fecha_inicio    TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- renders: incluye tambien planos (mismo concepto para este modelo) y
-- entregas (un render 'aprobado' es, en la practica, una entrega).
CREATE TABLE renders (
    id_render                INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto              INTEGER NOT NULL,
    nombre_render             TEXT NOT NULL,
    fecha_entrega_estimada    TEXT NOT NULL,
    estado                    TEXT NOT NULL DEFAULT 'en_proceso' CHECK (estado IN ('en_proceso', 'en_revision', 'aprobado', 'rechazado')),

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
);

-- revisiones: historial de comentarios y resultados por render.
CREATE TABLE revisiones (
    id_revision     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_render       INTEGER NOT NULL,
    fecha_revision  TEXT NOT NULL,
    comentario      TEXT NOT NULL,
    resultado       TEXT NOT NULL CHECK (resultado IN ('aprobado', 'cambios_solicitados')),

    FOREIGN KEY (id_render) REFERENCES renders (id_render)
);
