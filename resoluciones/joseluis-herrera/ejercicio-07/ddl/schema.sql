PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS estudiantes;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS instructores;

CREATE TABLE instructores (
    id_instructor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    experiencia_anios INTEGER NOT NULL,
    CHECK (experiencia_anios >= 0)
);

CREATE TABLE cursos (
    id_curso INTEGER PRIMARY KEY,
    id_instructor INTEGER NOT NULL,
    nombre TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    duracion_horas INTEGER NOT NULL,
    nivel TEXT NOT NULL,
    FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor),
    CHECK (duracion_horas > 0),
    CHECK (nivel IN ('BASICO', 'INTERMEDIO', 'AVANZADO'))
);

CREATE TABLE estudiantes (
    id_estudiante INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    edad INTEGER NOT NULL,
    fecha_registro TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ACTIVO',
    CHECK (edad BETWEEN 16 AND 70),
    CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

CREATE TABLE matriculas (
    id_matricula INTEGER PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    fecha_matricula TEXT NOT NULL,
    nota_final REAL,
    estado TEXT NOT NULL DEFAULT 'ACTIVA',
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    UNIQUE (id_estudiante, id_curso),
    CHECK (nota_final IS NULL OR nota_final BETWEEN 0 AND 100),
    CHECK (estado IN ('ACTIVA', 'FINALIZADA', 'CANCELADA'))
);