PRAGMA foreign_keys = ON;

-- Ejercicio 019: Diseno 3D Arquitectura
-- Modelo minimo: catalogo de proyectos y bitacora historica de eventos.

CREATE TABLE proyectos (
    id_proyecto         INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_proyecto     TEXT NOT NULL UNIQUE,
    cliente             TEXT NOT NULL,
    arquitecto_asignado TEXT NOT NULL,
    estado_actual       TEXT NOT NULL DEFAULT 'en_diseno' CHECK (estado_actual IN ('en_diseno', 'en_revision', 'entregado'))
);

-- eventos: tabla principal, es el historico de auditoria. Cada fila es
-- un evento real que ocurrio en un proyecto; no se borra, solo se
-- corrige su estado (aprobado/rechazado) cuando cambia el resultado.
CREATE TABLE eventos (
    id_evento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto  INTEGER NOT NULL,
    tipo_evento  TEXT NOT NULL CHECK (tipo_evento IN ('boceto_inicial', 'render_3d', 'plano_tecnico', 'revision_cliente', 'entrega_final')),
    fecha_evento TEXT NOT NULL DEFAULT (datetime('now')),
    estado       TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
    comentario   TEXT,

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
);
