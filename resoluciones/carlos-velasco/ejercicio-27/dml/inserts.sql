PRAGMA foreign_keys = ON;

INSERT INTO categorias (id_categoria, nombre) VALUES
    (1, 'Programacion'),
    (2, 'Bases de Datos'),
    (3, 'Desarrollo Web'),
    (4, 'DevOps'),
    (5, 'Ciencia de Datos');

INSERT INTO instructores (
    id_instructor,
    nombre_completo,
    correo,
    experiencia_anios
) VALUES
    (1, 'Ana Martinez', 'ana.martinez@campuslands.com', 8),
    (2, 'Carlos Ramirez', 'carlos.ramirez@campuslands.com', 6),
    (3, 'Laura Gomez', 'laura.gomez@campuslands.com', 10),
    (4, 'Diego Hernandez', 'diego.hernandez@campuslands.com', 7),
    (5, 'Sofia Lopez', 'sofia.lopez@campuslands.com', 5);

INSERT INTO cursos (
    id_curso,
    nombre,
    codigo,
    precio,
    duracion_horas,
    id_categoria,
    id_instructor
) VALUES
    (1, 'Java desde Cero', 'CUR-JAV-001', 180.00, 40, 1, 1),
    (2, 'Python Profesional', 'CUR-PYT-001', 220.00, 45, 1, 2),
    (3, 'SQL y Bases de Datos', 'CUR-SQL-001', 160.00, 35, 2, 3),
    (4, 'MySQL Avanzado', 'CUR-MYS-001', 200.00, 30, 2, 3),
    (5, 'HTML y CSS', 'CUR-WEB-001', 120.00, 25, 3, 4);

INSERT INTO inscripciones (
    id_inscripcion,
    id_curso,
    nombre_estudiante,
    correo_estudiante,
    fecha_inscripcion,
    estado
) VALUES
    (1, 1, 'Miguel Castillo', 'miguel.castillo@example.com', '2026-08-01', 'Activa'),
    (2, 2, 'Valeria Perez', 'valeria.perez@example.com', '2026-08-02', 'Activa'),
    (3, 3, 'Andres Lopez', 'andres.lopez@example.com', '2026-08-03', 'Completada'),
    (4, 4, 'Daniela Morales', 'daniela.morales@example.com', '2026-08-04', 'Activa'),
    (5, 5, 'Jorge Ramirez', 'jorge.ramirez@example.com', '2026-08-05', 'Completada'),
    (6, 1, 'Camila Torres', 'camila.torres@example.com', '2026-08-06', 'Activa'),
    (7, 2, 'Mateo Garcia', 'mateo.garcia@example.com', '2026-08-07', 'Completada'),
    (8, 3, 'Sofia Castillo', 'sofia.castillo@example.com', '2026-08-08', 'Activa'),
    (9, 4, 'Nicolas Herrera', 'nicolas.herrera@example.com', '2026-08-09', 'Activa'),
    (10, 5, 'Paula Mendoza', 'paula.mendoza@example.com', '2026-08-10', 'Cancelada');