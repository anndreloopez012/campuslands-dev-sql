PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS materias;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS estudiantes;

CREATE TABLE estudiantes (
    id_estudiante INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    fecha_ingreso TEXT NOT NULL,
    semestre INTEGER NOT NULL,
    CHECK (length(nombre_completo) >= 5),
    CHECK (semestre BETWEEN 1 AND 12),
    CHECK (date(fecha_ingreso) IS NOT NULL)
);

CREATE TABLE profesores (
    id_profesor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    CHECK (length(nombre_completo) >= 5),
    CHECK (length(especialidad) >= 4)
);

CREATE TABLE materias (
    id_materia INTEGER PRIMARY KEY,
    id_profesor INTEGER NOT NULL,
    codigo TEXT NOT NULL UNIQUE,
    nombre TEXT NOT NULL,
    creditos INTEGER NOT NULL,
    CHECK (creditos BETWEEN 1 AND 6),
    CHECK (length(nombre) >= 4),
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor)
);

CREATE TABLE notas (
    id_nota INTEGER PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    calificacion REAL NOT NULL,
    fecha_evaluacion TEXT NOT NULL,
    tipo_evaluacion TEXT NOT NULL,
    UNIQUE (id_estudiante, id_materia, fecha_evaluacion, tipo_evaluacion),
    CHECK (calificacion BETWEEN 0 AND 5),
    CHECK (
        tipo_evaluacion IN (
            'Parcial',
            'Final',
            'Proyecto',
            'Tarea',
            'Quiz'
        )
    ),
    CHECK (date(fecha_evaluacion) IS NOT NULL),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);

CREATE INDEX idx_materias_profesor
ON materias(id_profesor);

CREATE INDEX idx_notas_estudiante
ON notas(id_estudiante);

CREATE INDEX idx_notas_materia
ON notas(id_materia);

CREATE INDEX idx_notas_fecha
ON notas(fecha_evaluacion);