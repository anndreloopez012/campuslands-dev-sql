PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS estudiantes;
DROP TABLE IF EXISTS instructores;
DROP TABLE IF EXISTS cursos;

CREATE TABLE cursos (
    id_curso INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    duracion_horas INTEGER NOT NULL,
    nivel TEXT NOT NULL,

    CONSTRAINT chk_curso_nombre
        CHECK (length(trim(nombre)) >= 3),

    CONSTRAINT chk_curso_duracion
        CHECK (duracion_horas > 0),

    CONSTRAINT chk_curso_nivel
        CHECK (
            nivel IN (
                'BASICO',
                'INTERMEDIO',
                'AVANZADO'
            )
        )
);

CREATE TABLE instructores (
    id_instructor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,

    CONSTRAINT chk_instructor_nombre
        CHECK (length(trim(nombre_completo)) >= 5),

    CONSTRAINT chk_instructor_email
        CHECK (
            email LIKE '%@%.%'
        )
);

CREATE TABLE estudiantes (
    id_estudiante INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_nacimiento TEXT NOT NULL,
    ciudad TEXT NOT NULL,

    CONSTRAINT chk_estudiante_nombre
        CHECK (length(trim(nombre_completo)) >= 5),

    CONSTRAINT chk_estudiante_fecha
        CHECK (
            fecha_nacimiento GLOB
            '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        )
);

CREATE TABLE matriculas (
    id_matricula INTEGER PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    id_instructor INTEGER NOT NULL,
    fecha_matricula TEXT NOT NULL,
    progreso INTEGER NOT NULL DEFAULT 0,
    estado TEXT NOT NULL,

    FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante),

    FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso),

    FOREIGN KEY (id_instructor)
        REFERENCES instructores(id_instructor),

    CONSTRAINT uq_matricula
        UNIQUE (id_estudiante, id_curso),

    CONSTRAINT chk_matricula_fecha
        CHECK (
            fecha_matricula GLOB
            '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        ),

    CONSTRAINT chk_matricula_progreso
        CHECK (
            progreso BETWEEN 0 AND 100
        ),

    CONSTRAINT chk_matricula_estado
        CHECK (
            estado IN (
                'ACTIVA',
                'FINALIZADA',
                'CANCELADA'
            )
        )
);