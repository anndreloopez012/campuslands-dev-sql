PRAGMA foreign_keys = ON;

-- =========================================================
-- CURSOS
-- =========================================================

INSERT INTO cursos (
    id_curso,
    nombre,
    categoria,
    duracion_horas,
    nivel
) VALUES
    (1, 'Fundamentos de Python', 'Programacion', 60, 'BASICO'),
    (2, 'JavaScript Moderno', 'Programacion', 70, 'INTERMEDIO'),
    (3, 'Bases de Datos SQL', 'Bases de Datos', 50, 'INTERMEDIO'),
    (4, 'Desarrollo Web Full Stack', 'Desarrollo Web', 100, 'AVANZADO'),
    (5, 'Git y GitHub Profesional', 'Herramientas', 40, 'BASICO');

-- =========================================================
-- INSTRUCTORES
-- =========================================================

INSERT INTO instructores (
    id_instructor,
    nombre_completo,
    email,
    especialidad
) VALUES
    (1, 'Laura Martinez', 'laura.martinez@academia.com', 'Python'),
    (2, 'Andres Rodriguez', 'andres.rodriguez@academia.com', 'JavaScript'),
    (3, 'Camila Torres', 'camila.torres@academia.com', 'Bases de Datos'),
    (4, 'Daniel Herrera', 'daniel.herrera@academia.com', 'Desarrollo Web'),
    (5, 'Sofia Morales', 'sofia.morales@academia.com', 'Git y DevOps');

-- =========================================================
-- ESTUDIANTES
-- =========================================================

INSERT INTO estudiantes (
    id_estudiante,
    nombre_completo,
    email,
    fecha_nacimiento,
    ciudad
) VALUES
    (1, 'Carlos Mendoza', 'carlos.mendoza@email.com', '2002-05-14', 'Guatemala'),
    (2, 'Ana Lopez', 'ana.lopez@email.com', '2001-08-21', 'Guatemala'),
    (3, 'Miguel Castillo', 'miguel.castillo@email.com', '2003-02-10', 'Mixco'),
    (4, 'Valentina Perez', 'valentina.perez@email.com', '2000-11-30', 'Villa Nueva'),
    (5, 'Diego Ramirez', 'diego.ramirez@email.com', '2002-07-18', 'Guatemala');

-- =========================================================
-- MATRICULAS
-- =========================================================

INSERT INTO matriculas (
    id_matricula,
    id_estudiante,
    id_curso,
    id_instructor,
    fecha_matricula,
    progreso,
    estado
) VALUES
    (1, 1, 1, 1, '2026-06-01', 85, 'ACTIVA'),
    (2, 1, 3, 3, '2026-06-05', 70, 'ACTIVA'),
    (3, 2, 2, 2, '2026-06-02', 100, 'FINALIZADA'),
    (4, 2, 5, 5, '2026-06-08', 90, 'ACTIVA'),
    (5, 3, 1, 1, '2026-06-03', 55, 'ACTIVA'),
    (6, 3, 4, 4, '2026-06-10', 40, 'ACTIVA'),
    (7, 4, 2, 2, '2026-06-04', 100, 'FINALIZADA'),
    (8, 4, 3, 3, '2026-06-12', 75, 'ACTIVA'),
    (9, 5, 4, 4, '2026-06-06', 65, 'ACTIVA'),
    (10, 5, 5, 5, '2026-06-15', 100, 'FINALIZADA');