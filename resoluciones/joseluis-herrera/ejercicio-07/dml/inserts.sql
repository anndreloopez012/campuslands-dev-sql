INSERT INTO instructores (
    id_instructor,
    nombre_completo,
    correo,
    especialidad,
    experiencia_anios
) VALUES
    (1, 'Ana Martinez', 'ana.martinez@academia.com', 'Python', 6),
    (2, 'Carlos Ramirez', 'carlos.ramirez@academia.com', 'JavaScript', 5),
    (3, 'Laura Gonzalez', 'laura.gonzalez@academia.com', 'Bases de Datos', 8),
    (4, 'Miguel Torres', 'miguel.torres@academia.com', 'Desarrollo Web', 7),
    (5, 'Sofia Castillo', 'sofia.castillo@academia.com', 'Backend', 4);

INSERT INTO cursos (
    id_curso,
    id_instructor,
    nombre,
    categoria,
    duracion_horas,
    nivel
) VALUES
    (1, 1, 'Python desde Cero', 'Programacion', 40, 'BASICO'),
    (2, 2, 'JavaScript Moderno', 'Programacion', 45, 'INTERMEDIO'),
    (3, 3, 'SQL y Bases de Datos', 'Bases de Datos', 35, 'INTERMEDIO'),
    (4, 4, 'Desarrollo Web Full Stack', 'Desarrollo Web', 60, 'AVANZADO'),
    (5, 5, 'APIs con Node.js', 'Backend', 50, 'AVANZADO');

INSERT INTO estudiantes (
    id_estudiante,
    nombre_completo,
    correo,
    edad,
    fecha_registro,
    estado
) VALUES
    (1, 'Jose Herrera', 'jose.herrera@email.com', 20, '2026-01-10', 'ACTIVO'),
    (2, 'Maria Lopez', 'maria.lopez@email.com', 22, '2026-01-12', 'ACTIVO'),
    (3, 'Diego Perez', 'diego.perez@email.com', 19, '2026-01-15', 'ACTIVO'),
    (4, 'Andrea Morales', 'andrea.morales@email.com', 24, '2026-01-18', 'ACTIVO'),
    (5, 'Luis Gomez', 'luis.gomez@email.com', 21, '2026-01-20', 'ACTIVO');

INSERT INTO matriculas (
    id_matricula,
    id_estudiante,
    id_curso,
    fecha_matricula,
    nota_final,
    estado
) VALUES
    (1, 1, 1, '2026-02-01', 92.5, 'FINALIZADA'),
    (2, 1, 3, '2026-02-03', 88.0, 'FINALIZADA'),
    (3, 2, 2, '2026-02-05', 95.0, 'FINALIZADA'),
    (4, 2, 4, '2026-02-08', 86.5, 'FINALIZADA'),
    (5, 3, 1, '2026-02-10', 78.0, 'FINALIZADA'),
    (6, 3, 5, '2026-02-12', 91.0, 'FINALIZADA'),
    (7, 4, 2, '2026-02-15', 89.5, 'FINALIZADA'),
    (8, 4, 3, '2026-02-18', 94.0, 'FINALIZADA'),
    (9, 5, 4, '2026-02-20', 82.5, 'FINALIZADA'),
    (10, 5, 5, '2026-02-22', 90.0, 'FINALIZADA');