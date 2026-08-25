INSERT INTO estudiantes (
    id_estudiante,
    nombre_completo,
    documento,
    correo,
    fecha_nacimiento
) VALUES
(1, 'Carlos Ramirez', '10010001', 'carlos.ramirez@universidad.edu', '2003-04-15'),
(2, 'Ana Lopez', '10010002', 'ana.lopez@universidad.edu', '2002-08-20'),
(3, 'Luis Martinez', '10010003', 'luis.martinez@universidad.edu', '2003-01-10'),
(4, 'Sofia Garcia', '10010004', 'sofia.garcia@universidad.edu', '2002-11-05'),
(5, 'Diego Castillo', '10010005', 'diego.castillo@universidad.edu', '2003-06-25');

INSERT INTO profesores (
    id_profesor,
    nombre_completo,
    documento,
    correo,
    especialidad
) VALUES
(1, 'Miguel Hernandez', '20020001', 'miguel.hernandez@universidad.edu', 'Bases de Datos'),
(2, 'Laura Gonzalez', '20020002', 'laura.gonzalez@universidad.edu', 'Programacion'),
(3, 'Andres Perez', '20020003', 'andres.perez@universidad.edu', 'Matematicas'),
(4, 'Carolina Torres', '20020004', 'carolina.torres@universidad.edu', 'Sistemas'),
(5, 'Fernando Morales', '20020005', 'fernando.morales@universidad.edu', 'Ingles');

INSERT INTO materias (
    id_materia,
    nombre,
    creditos,
    semestre
) VALUES
(1, 'Bases de Datos', 4, 3),
(2, 'Programacion Web', 4, 3),
(3, 'Matematicas Discretas', 3, 2),
(4, 'Sistemas Operativos', 4, 4),
(5, 'Ingles Tecnico', 2, 2);

INSERT INTO notas (
    id_nota,
    id_estudiante,
    id_materia,
    id_profesor,
    nota,
    fecha_nota
) VALUES
(1, 1, 1, 1, 4.5, '2026-08-01'),
(2, 1, 2, 2, 4.2, '2026-08-02'),
(3, 2, 1, 1, 3.8, '2026-08-03'),
(4, 2, 3, 3, 4.6, '2026-08-04'),
(5, 3, 2, 2, 3.5, '2026-08-05'),
(6, 3, 4, 4, 4.0, '2026-08-06'),
(7, 4, 1, 1, 4.8, '2026-08-07'),
(8, 4, 5, 5, 4.4, '2026-08-08'),
(9, 5, 3, 3, 3.2, '2026-08-09'),
(10, 5, 4, 4, 4.7, '2026-08-10');