PRAGMA foreign_keys = ON;

CREATE TABLE instructores (
    id_instructor INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE
);

CREATE TABLE cursos (
    id_curso INTEGER PRIMARY KEY AUTOINCREMENT,
    id_instructor INTEGER NOT NULL,
    nombre TEXT NOT NULL UNIQUE,
    duracion_horas INTEGER NOT NULL CHECK (duracion_horas > 0),
    modalidad TEXT NOT NULL CHECK (modalidad IN ('presencial', 'virtual', 'hibrida')),
    FOREIGN KEY (id_instructor) REFERENCES instructores (id_instructor)
);

CREATE TABLE estudiantes (
    id_estudiante INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE
);

CREATE TABLE matriculas (
    id_matricula INTEGER PRIMARY KEY AUTOINCREMENT,
    id_estudiante INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    fecha_matricula TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    nota_final REAL CHECK (nota_final >= 0 AND nota_final <= 100),
    estado TEXT NOT NULL DEFAULT 'activa' CHECK (estado IN ('activa', 'aprobada', 'reprobada', 'retirada')),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos (id_curso),
    UNIQUE (id_estudiante, id_curso)
);
