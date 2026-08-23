PRAGMA foreign_keys = ON;

-- TRAINERS

INSERT INTO trainers (
    id_trainer,
    nombre_completo,
    correo,
    especialidad,
    fecha_ingreso,
    estado
) VALUES
    (1, 'Laura Gomez', 'laura.gomez@campuslands.com', 'Desarrollo Backend', '2025-01-15', 'Activo'),
    (2, 'Andres Ramirez', 'andres.ramirez@campuslands.com', 'Bases de Datos', '2025-02-10', 'Activo'),
    (3, 'Sofia Martinez', 'sofia.martinez@campuslands.com', 'Desarrollo Frontend', '2025-03-05', 'Activo'),
    (4, 'Diego Hernandez', 'diego.hernandez@campuslands.com', 'DevOps', '2025-04-12', 'Activo'),
    (5, 'Valentina Lopez', 'valentina.lopez@campuslands.com', 'Metodologias Agiles', '2025-05-20', 'Activo');

-- RUTAS

INSERT INTO rutas (
    id_ruta,
    nombre,
    nivel,
    modalidad,
    id_trainer,
    fecha_inicio,
    estado
) VALUES
    (1, 'Desarrollo Backend', 'Avanzado', 'Presencial', 1, '2026-01-15', 'Activa'),
    (2, 'Bases de Datos', 'Intermedio', 'Presencial', 2, '2026-01-20', 'Activa'),
    (3, 'Desarrollo Frontend', 'Basico', 'Hibrida', 3, '2026-02-01', 'Activa'),
    (4, 'DevOps y Cloud', 'Avanzado', 'Virtual', 4, '2026-02-10', 'Activa'),
    (5, 'Gestion de Proyectos', 'Intermedio', 'Hibrida', 5, '2026-02-15', 'Activa');

-- CAMPERS

INSERT INTO campers (
    id_camper,
    nombre_completo,
    correo,
    telefono,
    fecha_ingreso,
    estado
) VALUES
    (1, 'Carlos Velasco', 'carlos.velasco@example.com', '555-1001', '2026-01-10', 'Activo'),
    (2, 'Ana Martinez', 'ana.martinez@example.com', '555-1002', '2026-01-12', 'Activo'),
    (3, 'Miguel Castillo', 'miguel.castillo@example.com', '555-1003', '2026-01-15', 'Activo'),
    (4, 'Daniela Torres', 'daniela.torres@example.com', '555-1004', '2026-01-18', 'Activo'),
    (5, 'Jorge Ramirez', 'jorge.ramirez@example.com', '555-1005', '2026-01-20', 'Activo');

-- MODULOS

INSERT INTO modulos (
    id_modulo,
    id_ruta,
    nombre,
    orden,
    horas,
    estado
) VALUES
    (1, 1, 'Fundamentos de Programacion', 1, 40, 'Activo'),
    (2, 1, 'Java y Programacion Orientada a Objetos', 2, 50, 'Activo'),
    (3, 2, 'Fundamentos de Bases de Datos', 1, 40, 'Activo'),
    (4, 2, 'SQL y Consultas Avanzadas', 2, 50, 'Activo'),
    (5, 3, 'HTML y CSS', 1, 35, 'Activo'),
    (6, 3, 'JavaScript', 2, 50, 'Activo'),
    (7, 4, 'Linux y Administracion de Sistemas', 1, 40, 'Activo'),
    (8, 4, 'Docker y Cloud', 2, 45, 'Activo'),
    (9, 5, 'Scrum y Metodologias Agiles', 1, 30, 'Activo'),
    (10, 5, 'Gestion de Proyectos', 2, 35, 'Activo');

-- EVALUACIONES

INSERT INTO evaluaciones (
    id_evaluacion,
    id_camper,
    id_modulo,
    fecha_evaluacion,
    nota,
    tipo,
    estado
) VALUES
    (1, 1, 1, '2026-02-05', 92.00, 'Practica', 'Calificada'),
    (2, 2, 1, '2026-02-05', 88.00, 'Practica', 'Calificada'),
    (3, 3, 3, '2026-02-10', 95.00, 'Teorica', 'Calificada'),
    (4, 4, 3, '2026-02-10', 78.00, 'Teorica', 'Calificada'),
    (5, 5, 4, '2026-02-20', 91.00, 'Practica', 'Calificada'),
    (6, 1, 2, '2026-02-25', 87.00, 'Proyecto', 'Calificada'),
    (7, 2, 4, '2026-02-25', 83.00, 'Practica', 'Calificada'),
    (8, 3, 5, '2026-03-05', 96.00, 'Practica', 'Calificada'),
    (9, 4, 6, '2026-03-15', 89.00, 'Proyecto', 'Calificada'),
    (10, 5, 7, '2026-03-20', 76.00, 'Teorica', 'Calificada');

-- ASISTENCIAS

INSERT INTO asistencias (
    id_asistencia,
    id_camper,
    id_modulo,
    fecha,
    estado,
    observacion
) VALUES
    (1, 1, 1, '2026-02-02', 'Presente', 'Asistencia completa'),
    (2, 2, 1, '2026-02-02', 'Presente', 'Asistencia completa'),
    (3, 3, 3, '2026-02-06', 'Presente', 'Asistencia completa'),
    (4, 4, 3, '2026-02-06', 'Ausente', 'Sin justificacion'),
    (5, 5, 4, '2026-02-16', 'Presente', 'Asistencia completa'),
    (6, 1, 2, '2026-02-20', 'Presente', 'Asistencia completa'),
    (7, 2, 4, '2026-02-20', 'Justificada', 'Cita medica'),
    (8, 3, 5, '2026-03-01', 'Presente', 'Asistencia completa'),
    (9, 4, 6, '2026-03-10', 'Presente', 'Asistencia completa'),
    (10, 5, 7, '2026-03-15', 'Ausente', 'Inasistencia reportada');