PRAGMA foreign_keys = ON;

-- Ejercicio 069: Diseno 3D Arquitectura
-- Modelo: clientes, proyectos, renders, revisiones, entregas

CREATE TABLE clientes (
    id_cliente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    telefono     TEXT NOT NULL UNIQUE
);

CREATE TABLE proyectos (
    id_proyecto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    nombre          TEXT NOT NULL,
    tipo            TEXT NOT NULL CHECK (tipo IN ('residencial', 'comercial', 'institucional')),
    fecha_inicio    TEXT NOT NULL DEFAULT (date('now')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE renders (
    id_render          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto        INTEGER NOT NULL,
    nombre_archivo     TEXT NOT NULL,
    fecha_creacion     TEXT NOT NULL DEFAULT (datetime('now')),
    estado             TEXT NOT NULL DEFAULT 'en_proceso'
                           CHECK (estado IN ('en_proceso', 'terminado', 'descartado')),

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
);

-- revisiones: historico de auditoria. No se borra ninguna fila de esta
-- tabla en operaciones normales; si algo se registro mal, se corrige
-- con UPDATE para conservar el rastro de que paso y cuando paso.
CREATE TABLE revisiones (
    id_revision       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_render         INTEGER NOT NULL,
    comentario        TEXT NOT NULL,
    fecha_revision    TEXT NOT NULL DEFAULT (datetime('now')),
    aprobado          INTEGER NOT NULL DEFAULT 0 CHECK (aprobado IN (0, 1)),

    FOREIGN KEY (id_render) REFERENCES renders (id_render)
);

CREATE TABLE entregas (
    id_entrega       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto      INTEGER NOT NULL,
    fecha_entrega    TEXT NOT NULL DEFAULT (date('now')),
    version          TEXT NOT NULL,

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
);
