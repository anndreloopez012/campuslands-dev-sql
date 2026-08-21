PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS inscripciones;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS instructores;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE instructores (
    id_instructor INTEGER PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    experiencia_anios INTEGER NOT NULL CHECK (experiencia_anios >= 0)
);

CREATE TABLE cursos (
    id_curso INTEGER PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
    duracion_horas INTEGER NOT NULL CHECK (duracion_horas > 0),
    id_categoria INTEGER NOT NULL,
    id_instructor INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE inscripciones (
    id_inscripcion INTEGER PRIMARY KEY,
    id_curso INTEGER NOT NULL,
    nombre_estudiante VARCHAR(150) NOT NULL,
    correo_estudiante VARCHAR(150) NOT NULL,
    fecha_inscripcion TEXT NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Activa'
        CHECK (estado IN ('Activa', 'Completada', 'Cancelada')),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- INDICES DE BUSQUEDA

CREATE INDEX idx_categorias_nombre
ON categorias(nombre);

CREATE INDEX idx_instructores_correo
ON instructores(correo);

CREATE INDEX idx_cursos_nombre
ON cursos(nombre);

CREATE INDEX idx_cursos_categoria
ON cursos(id_categoria);

CREATE INDEX idx_cursos_instructor
ON cursos(id_instructor);

CREATE INDEX idx_inscripciones_curso
ON inscripciones(id_curso);

CREATE INDEX idx_inscripciones_fecha
ON inscripciones(fecha_inscripcion);

CREATE INDEX idx_inscripciones_estado
ON inscripciones(estado);

CREATE INDEX idx_inscripciones_curso_fecha
ON inscripciones(id_curso, fecha_inscripcion);