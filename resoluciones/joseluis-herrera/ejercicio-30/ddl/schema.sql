PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS asistencias;
DROP TABLE IF EXISTS evaluaciones;
DROP TABLE IF EXISTS modulos;
DROP TABLE IF EXISTS campers;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS trainers;

CREATE TABLE trainers (
    id_trainer INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    fecha_ingreso TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (date(fecha_ingreso) IS NOT NULL)
);

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    tecnologia_principal TEXT NOT NULL,
    duracion_meses INTEGER NOT NULL,
    nivel TEXT NOT NULL,
    CHECK (duracion_meses > 0),
    CHECK (nivel IN ('basico', 'intermedio', 'avanzado'))
);

CREATE TABLE campers (
    id_camper INTEGER PRIMARY KEY,
    id_ruta INTEGER NOT NULL,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_ingreso TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (estado IN ('activo', 'graduado', 'retirado')),
    CHECK (date(fecha_ingreso) IS NOT NULL)
);

CREATE TABLE modulos (
    id_modulo INTEGER PRIMARY KEY,
    id_ruta INTEGER NOT NULL,
    id_trainer INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    horas INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL,
    fecha_fin TEXT NOT NULL,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
    FOREIGN KEY (id_trainer) REFERENCES trainers(id_trainer),
    UNIQUE (id_ruta, nombre),
    CHECK (horas > 0),
    CHECK (date(fecha_inicio) IS NOT NULL),
    CHECK (date(fecha_fin) IS NOT NULL),
    CHECK (date(fecha_fin) >= date(fecha_inicio))
);

CREATE TABLE evaluaciones (
    id_evaluacion INTEGER PRIMARY KEY,
    id_camper INTEGER NOT NULL,
    id_modulo INTEGER NOT NULL,
    fecha_evaluacion TEXT NOT NULL,
    nota REAL NOT NULL,
    tipo TEXT NOT NULL,
    FOREIGN KEY (id_camper) REFERENCES campers(id_camper),
    FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo),
    UNIQUE (id_camper, id_modulo, tipo),
    CHECK (nota >= 0 AND nota <= 100),
    CHECK (tipo IN ('teorica', 'practica', 'proyecto')),
    CHECK (date(fecha_evaluacion) IS NOT NULL)
);

CREATE TABLE asistencias (
    id_asistencia INTEGER PRIMARY KEY,
    id_camper INTEGER NOT NULL,
    id_modulo INTEGER NOT NULL,
    fecha TEXT NOT NULL,
    estado TEXT NOT NULL,
    FOREIGN KEY (id_camper) REFERENCES campers(id_camper),
    FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo),
    UNIQUE (id_camper, id_modulo, fecha),
    CHECK (estado IN ('presente', 'ausente', 'justificada')),
    CHECK (date(fecha) IS NOT NULL)
);

CREATE INDEX idx_campers_ruta
ON campers(id_ruta);

CREATE INDEX idx_modulos_ruta
ON modulos(id_ruta);

CREATE INDEX idx_modulos_trainer
ON modulos(id_trainer);

CREATE INDEX idx_evaluaciones_camper
ON evaluaciones(id_camper);

CREATE INDEX idx_evaluaciones_modulo
ON evaluaciones(id_modulo);

CREATE INDEX idx_asistencias_camper
ON asistencias(id_camper);

CREATE INDEX idx_asistencias_modulo
ON asistencias(id_modulo);