PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS asistencias;
DROP TABLE IF EXISTS evaluaciones;
DROP TABLE IF EXISTS modulos;
DROP TABLE IF EXISTS campers;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS trainers;

CREATE TABLE campers (
    id_camper INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    fecha_ingreso TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo'
        CHECK (estado IN ('Activo', 'Inactivo', 'Graduado'))
);

CREATE TABLE trainers (
    id_trainer INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    fecha_ingreso TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo'
        CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    nivel TEXT NOT NULL
        CHECK (nivel IN ('Basico', 'Intermedio', 'Avanzado')),
    modalidad TEXT NOT NULL
        CHECK (modalidad IN ('Presencial', 'Virtual', 'Hibrida')),
    id_trainer INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activa'
        CHECK (estado IN ('Activa', 'Finalizada', 'Suspendida')),
    FOREIGN KEY (id_trainer) REFERENCES trainers(id_trainer)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE modulos (
    id_modulo INTEGER PRIMARY KEY,
    id_ruta INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    orden INTEGER NOT NULL CHECK (orden > 0),
    horas INTEGER NOT NULL CHECK (horas > 0),
    estado TEXT NOT NULL DEFAULT 'Activo'
        CHECK (estado IN ('Activo', 'Inactivo')),
    UNIQUE (id_ruta, orden),
    UNIQUE (id_ruta, nombre),
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE evaluaciones (
    id_evaluacion INTEGER PRIMARY KEY,
    id_camper INTEGER NOT NULL,
    id_modulo INTEGER NOT NULL,
    fecha_evaluacion TEXT NOT NULL,
    nota REAL NOT NULL CHECK (nota BETWEEN 0 AND 100),
    tipo TEXT NOT NULL
        CHECK (tipo IN ('Teorica', 'Practica', 'Proyecto')),
    estado TEXT NOT NULL DEFAULT 'Calificada'
        CHECK (estado IN ('Calificada', 'Pendiente')),
    UNIQUE (id_camper, id_modulo, fecha_evaluacion),
    FOREIGN KEY (id_camper) REFERENCES campers(id_camper)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE asistencias (
    id_asistencia INTEGER PRIMARY KEY,
    id_camper INTEGER NOT NULL,
    id_modulo INTEGER NOT NULL,
    fecha TEXT NOT NULL,
    estado TEXT NOT NULL
        CHECK (estado IN ('Presente', 'Ausente', 'Justificada')),
    observacion TEXT,
    UNIQUE (id_camper, id_modulo, fecha),
    FOREIGN KEY (id_camper) REFERENCES campers(id_camper)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_campers_estado
ON campers(estado);

CREATE INDEX idx_rutas_trainer
ON rutas(id_trainer);

CREATE INDEX idx_modulos_ruta
ON modulos(id_ruta);

CREATE INDEX idx_evaluaciones_camper
ON evaluaciones(id_camper);

CREATE INDEX idx_evaluaciones_modulo
ON evaluaciones(id_modulo);

CREATE INDEX idx_asistencias_camper
ON asistencias(id_camper);

CREATE INDEX idx_asistencias_modulo
ON asistencias(id_modulo);

CREATE INDEX idx_asistencias_fecha
ON asistencias(fecha);