INSERT INTO trainers (
    id_trainer,
    nombre_completo,
    email,
    especialidad,
    fecha_ingreso
) VALUES
(1, 'Carlos Mendoza', 'carlos.mendoza@campuslands.com', 'JavaScript', '2025-01-15'),
(2, 'Laura Ramirez', 'laura.ramirez@campuslands.com', 'Bases de Datos', '2025-02-10'),
(3, 'Andres Castillo', 'andres.castillo@campuslands.com', 'Python', '2025-03-05'),
(4, 'Sofia Herrera', 'sofia.herrera@campuslands.com', 'Frontend', '2025-04-12'),
(5, 'Miguel Torres', 'miguel.torres@campuslands.com', 'Backend', '2025-05-20');

INSERT INTO rutas (
    id_ruta,
    nombre,
    tecnologia_principal,
    duracion_meses,
    nivel
) VALUES
(1, 'Desarrollo Web', 'JavaScript', 6, 'basico'),
(2, 'Backend Profesional', 'NodeJS', 7, 'intermedio'),
(3, 'Data Engineering', 'Python', 8, 'avanzado'),
(4, 'Bases de Datos', 'SQL', 5, 'intermedio'),
(5, 'Frontend Moderno', 'ReactJS', 6, 'avanzado');

INSERT INTO campers (
    id_camper,
    id_ruta,
    nombre_completo,
    email,
    fecha_ingreso,
    estado
) VALUES
(1, 1, 'Jose Perez', 'jose.perez@campus.com', '2026-01-10', 'activo'),
(2, 1, 'Maria Lopez', 'maria.lopez@campus.com', '2026-01-12', 'activo'),
(3, 2, 'Carlos Gomez', 'carlos.gomez@campus.com', '2026-01-15', 'activo'),
(4, 2, 'Ana Martinez', 'ana.martinez@campus.com', '2026-01-18', 'activo'),
(5, 3, 'Luis Ramirez', 'luis.ramirez@campus.com', '2026-01-20', 'activo');

INSERT INTO modulos (
    id_modulo,
    id_ruta,
    id_trainer,
    nombre,
    horas,
    fecha_inicio,
    fecha_fin
) VALUES
(1, 1, 1, 'JavaScript Fundamentos', 60, '2026-02-01', '2026-03-01'),
(2, 1, 4, 'HTML y CSS', 50, '2026-03-05', '2026-04-01'),
(3, 2, 5, 'NodeJS', 70, '2026-02-05', '2026-03-10'),
(4, 2, 2, 'PostgreSQL', 60, '2026-03-15', '2026-04-15'),
(5, 3, 3, 'Python para Datos', 80, '2026-02-10', '2026-03-20');

INSERT INTO evaluaciones (
    id_evaluacion,
    id_camper,
    id_modulo,
    fecha_evaluacion,
    nota,
    tipo
) VALUES
(1, 1, 1, '2026-03-01', 92, 'practica'),
(2, 2, 1, '2026-03-01', 85, 'practica'),
(3, 3, 3, '2026-03-10', 78, 'teorica'),
(4, 4, 3, '2026-03-10', 88, 'proyecto'),
(5, 5, 5, '2026-03-20', 95, 'proyecto'),
(6, 1, 2, '2026-04-01', 90, 'teorica'),
(7, 2, 2, '2026-04-01', 82, 'proyecto'),
(8, 3, 4, '2026-04-15', 76, 'practica'),
(9, 4, 4, '2026-04-15', 91, 'proyecto'),
(10, 5, 5, '2026-03-25', 89, 'teorica');

INSERT INTO asistencias (
    id_asistencia,
    id_camper,
    id_modulo,
    fecha,
    estado
) VALUES
(1, 1, 1, '2026-02-10', 'presente'),
(2, 1, 1, '2026-02-11', 'presente'),
(3, 2, 1, '2026-02-10', 'ausente'),
(4, 2, 1, '2026-02-11', 'presente'),
(5, 3, 3, '2026-02-12', 'presente'),
(6, 3, 3, '2026-02-13', 'justificada'),
(7, 4, 3, '2026-02-12', 'presente'),
(8, 4, 3, '2026-02-13', 'presente'),
(9, 5, 5, '2026-02-15', 'presente'),
(10, 5, 5, '2026-02-16', 'presente');