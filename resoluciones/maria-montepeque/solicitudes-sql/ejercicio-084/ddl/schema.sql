PRAGMA foreign_keys = ON;

-- Ejercicio 084: Estudio Animacion 3D
-- Modelo: clientes -> proyectos (1:N); proyectos + artistas ->
-- tareas (1:N cada una); proyectos -> entregas (1:N, una por
-- semana).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE artistas (
    id_artista      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista  TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL CHECK (especialidad IN ('modelado', 'animacion', 'render', 'texturizado'))
);

CREATE TABLE proyectos (
    id_proyecto      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente       INTEGER NOT NULL,
    nombre_proyecto  TEXT NOT NULL,
    fecha_inicio     TEXT NOT NULL,
    estado           TEXT NOT NULL DEFAULT 'en_curso'
                         CHECK (estado IN ('en_curso', 'pausado', 'finalizado', 'cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE tareas (
    id_tarea            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto         INTEGER NOT NULL,
    id_artista          INTEGER NOT NULL,
    descripcion         TEXT NOT NULL,
    fecha_tarea         TEXT NOT NULL,
    horas_trabajadas    REAL NOT NULL CHECK (horas_trabajadas >= 0),

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto),
    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);

-- entregas: el UNIQUE compuesto garantiza como maximo un checkpoint
-- semanal oficial por proyecto, evitando reportes semanales
-- duplicados o contradictorios.
CREATE TABLE entregas (
    id_entrega       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto      INTEGER NOT NULL,
    semana           INTEGER NOT NULL CHECK (semana >= 1),
    fecha_entrega    TEXT NOT NULL,
    aprobada         INTEGER NOT NULL DEFAULT 0 CHECK (aprobada IN (0, 1)),

    FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto),
    UNIQUE (id_proyecto, semana)
);

-- Vista SQL (requerida en nivel 5): responde directamente la
-- pregunta del cliente ("que paso esta semana en cada proyecto"), sin
-- repetir el JOIN cada vez.
CREATE VIEW vista_reporte_semanal AS
    SELECT
        en.id_entrega,
        cl.nombre_cliente,
        pr.nombre_proyecto,
        pr.estado,
        en.semana,
        en.fecha_entrega,
        en.aprobada
    FROM entregas en
    JOIN proyectos pr ON pr.id_proyecto = en.id_proyecto
    JOIN clientes cl ON cl.id_cliente = pr.id_cliente;
