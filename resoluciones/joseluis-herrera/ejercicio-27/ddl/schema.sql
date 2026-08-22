PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS inscripciones;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS instructores;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    CHECK (length(trim(nombre)) >= 3)
);

CREATE TABLE instructores (
    id_instructor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (instrutores_email_valido(email))
);

CREATE TABLE cursos (
    id_curso INTEGER PRIMARY KEY,
    id_categoria INTEGER NOT NULL,
    id_instructor INTEGER NOT NULL,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    precio REAL NOT NULL,
    fecha_inicio TEXT NOT NULL,
    cupo_maximo INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor),
    CHECK (precio > 0),
    CHECK (cupo_maximo > 0),
    CHECK (date(fecha_inicio) IS NOT NULL)
);

CREATE TABLE inscripciones (
    id_inscripcion INTEGER PRIMARY KEY,
    id_curso INTEGER NOT NULL,
    nombre_estudiante TEXT NOT NULL,
    email_estudiante TEXT NOT NULL,
    fecha_inscripcion TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activa',
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    UNIQUE (id_curso, email_estudiante),
    CHECK (estado IN ('activa', 'cancelada', 'finalizada')),
    CHECK (date(fecha_inscripcion) IS NOT NULL)
);

CREATE INDEX idx_cursos_categoria
ON cursos(id_categoria);

CREATE INDEX idx_cursos_instructor
ON cursos(id_instructor);

CREATE INDEX idx_cursos_precio
ON cursos(precio);

CREATE INDEX idx_inscripciones_curso
ON inscripciones(id_curso);

CREATE INDEX idx_inscripciones_fecha
ON inscripciones(fecha_inscripcion);