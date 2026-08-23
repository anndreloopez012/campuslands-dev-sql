PRAGMA foreign_keys = ON;

-- ESTUDIANTES

INSERT INTO estudiantes
(id_estudiante, nombre_completo, correo, fecha_ingreso, semestre)
VALUES
(1, 'Ana Martinez', 'ana.martinez@campus.edu', '2024-01-15', 5),
(2, 'Carlos Perez', 'carlos.perez@campus.edu', '2023-01-15', 6),
(3, 'Maria Gomez', 'maria.gomez@campus.edu', '2024-01-15', 4),
(4, 'Luis Ramirez', 'luis.ramirez@campus.edu', '2022-08-15', 8),
(5, 'Sofia Castillo', 'sofia.castillo@campus.edu', '2023-01-15', 6);

-- PROFESORES

INSERT INTO profesores
(id_profesor, nombre_completo, correo, especialidad)
VALUES
(1, 'Laura Hernandez', 'laura.hernandez@campus.edu', 'Matematicas'),
(2, 'Diego Morales', 'diego.morales@campus.edu', 'Programacion'),
(3, 'Patricia Torres', 'patricia.torres@campus.edu', 'Bases de Datos'),
(4, 'Jorge Ramirez', 'jorge.ramirez@campus.edu', 'Fisica'),
(5, 'Valeria Mendoza', 'valeria.mendoza@campus.edu', 'Ingles');

-- MATERIAS

INSERT INTO materias
(id_materia, id_profesor, codigo, nombre, creditos)
VALUES
(1, 1, 'MAT101', 'Calculo I', 4),
(2, 2, 'PRG201', 'Programacion II', 4),
(3, 3, 'BDD301', 'Bases de Datos', 3),
(4, 4, 'FIS101', 'Fisica General', 4),
(5, 5, 'ING201', 'Ingles Tecnico', 3);

-- NOTAS

INSERT INTO notas
(id_nota, id_estudiante, id_materia, calificacion, fecha_evaluacion, tipo_evaluacion)
VALUES
(1, 1, 1, 4.5, '2026-05-10', 'Parcial'),
(2, 1, 2, 4.8, '2026-05-15', 'Proyecto'),
(3, 2, 1, 3.2, '2026-05-10', 'Parcial'),
(4, 2, 3, 4.1, '2026-05-18', 'Final'),
(5, 3, 2, 2.8, '2026-05-15', 'Proyecto'),
(6, 3, 4, 3.7, '2026-05-20', 'Parcial'),
(7, 4, 3, 4.9, '2026-05-18', 'Final'),
(8, 4, 5, 4.6, '2026-05-22', 'Final'),
(9, 5, 1, 3.9, '2026-05-10', 'Parcial'),
(10, 5, 4, 4.3, '2026-05-20', 'Parcial');