PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS modulos;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS trainers;
DROP TABLE IF EXISTS estudiantes;

CREATE TABLE estudiantes (
    id_estudiante INTEGER PRIMARY KEY,
    documento TEXT NOT NULL UNIQUE,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (length(documento) >= 5),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE trainers (
    id_trainer INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (length(nombre_completo) >= 5),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    jornada TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activa',
    CHECK (jornada IN ('manana', 'tarde', 'noche')),
    CHECK (estado IN ('activa', 'inactiva'))
);

CREATE TABLE modulos (
    id_modulo INTEGER PRIMARY KEY,
    id_ruta INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    orden INTEGER NOT NULL,
    horario TEXT NOT NULL,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
    UNIQUE (id_ruta, nombre),
    UNIQUE (id_ruta, orden),
    CHECK (orden > 0),
    CHECK (length(horario) > 0)
);

CREATE TABLE matriculas (
    id_matricula INTEGER PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_ruta INTEGER NOT NULL,
    id_trainer INTEGER NOT NULL,
    fecha_matricula TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activa',
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
    FOREIGN KEY (id_trainer) REFERENCES trainers(id_trainer),
    UNIQUE (id_estudiante, id_ruta),
    CHECK (estado IN ('activa', 'finalizada', 'cancelada'))
);

CREATE TABLE notas (
    id_matricula INTEGER NOT NULL,
    id_modulo INTEGER NOT NULL,
    nota REAL NOT NULL,
    PRIMARY KEY (id_matricula, id_modulo),
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo),
    CHECK (nota >= 0 AND nota <= 100)
);

CREATE INDEX idx_estudiantes_nombre
ON estudiantes(nombre_completo);

CREATE INDEX idx_matriculas_ruta
ON matriculas(id_ruta);

CREATE INDEX idx_matriculas_trainer
ON matriculas(id_trainer);

CREATE INDEX idx_matriculas_fecha
ON matriculas(fecha_matricula);

CREATE INDEX idx_modulos_ruta
ON modulos(id_ruta);

CREATE INDEX idx_notas_modulo
ON notas(id_modulo);