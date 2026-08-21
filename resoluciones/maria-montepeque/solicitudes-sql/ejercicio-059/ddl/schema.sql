PRAGMA foreign_keys = ON;

-- Ejercicio 059: Estudio Animacion 3D
-- Modelo: clientes -> proyectos (1:N), y proyectos + artistas ->
-- tareas (doble FOREIGN KEY). fecha_ultimo_cambio guarda cuando
-- cambio el estado por ultima vez, para auditorias.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL
);

CREATE TABLE artistas (
    id_artista     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista TEXT NOT NULL UNIQUE,
    especialidad   TEXT NOT NULL CHECK (especialidad IN ('modelado', 'animacion', 'texturizado', 'iluminacion'))
);

CREATE TABLE proyectos (
    id_proyecto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    nombre_proyecto TEXT NOT NULL UNIQUE,
    fecha_inicio    TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'en_desarrollo' CHECK (estado IN ('en_desarrollo', 'revision', 'entregado', 'cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- tareas: tabla principal. El estado se corrige con UPDATE (nunca con
-- DELETE) y cada cambio actualiza fecha_ultimo_cambio.
CREATE TABLE tareas (
    id_tarea             INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto          INTEGER NOT NULL,
    id_artista           INTEGER NOT NULL,
    descripcion          TEXT NOT NULL,
    fecha_asignacion     TEXT NOT NULL,
    estado               TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'en_progreso', 'completada')),
    fecha_ultimo_cambio  TEXT NOT NULL,

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto),
    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);
