PRAGMA foreign_keys = ON;

-- Ejercicio 009: Estudio Animacion 3D
-- Modelo minimo: catalogo de proyectos y bitacora historica de entregas.

CREATE TABLE proyectos (
    id_proyecto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_proyecto  TEXT NOT NULL UNIQUE,
    cliente          TEXT NOT NULL,
    artista_asignado TEXT NOT NULL,
    estado_actual    TEXT NOT NULL DEFAULT 'en_progreso' CHECK (estado_actual IN ('en_progreso', 'pausado', 'finalizado'))
);

-- entregas: tabla principal, es el historico de auditoria. Cada fila es
-- un evento real que ocurrio en un proyecto; no se borra, solo se
-- corrige su estado (aprobado/rechazado) cuando cambia el resultado.
CREATE TABLE entregas (
    id_entrega   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto  INTEGER NOT NULL,
    tipo_evento  TEXT NOT NULL CHECK (tipo_evento IN ('inicio', 'avance', 'revision', 'correccion', 'entrega_final')),
    fecha_evento TEXT NOT NULL DEFAULT (datetime('now')),
    estado       TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
    comentario   TEXT,

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
);
