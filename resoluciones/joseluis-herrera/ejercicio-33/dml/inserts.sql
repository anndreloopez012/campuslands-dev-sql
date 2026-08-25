INSERT INTO estudiantes (id_estudiante, documento, nombre_completo, correo, estado) VALUES
(1, '10010001', 'Ana Martínez', 'ana.martinez@gmail.com', 'activo'),
(2, '10010002', 'Carlos Vega', 'carlos.vega@gmail.com', 'activo'),
(3, '10010003', 'Luisa Herrera', 'luisa.herrera@gmail.com', 'activo'),
(4, '10010004', 'Gustavo Ríos', 'gustavo.rios@gmail.com', 'activo'),
(5, '10010005', 'Sofía López', 'sofia.lopez@gmail.com', 'activo'),
(6, '10010006', 'Mariana Torres', 'mariana.torres@gmail.com', 'activo'),
(7, '10010007', 'Andrés Ramírez', 'andres.ramirez@gmail.com', 'activo'),
(8, '10010008', 'Camila Duarte', 'camila.duarte@gmail.com', 'activo');

INSERT INTO trainers (id_trainer, nombre_completo, correo, especialidad, estado) VALUES
(1, 'Laura Gómez', 'laura.gomez@campuslands.com', 'Programación', 'activo'),
(2, 'Daniel Castro', 'daniel.castro@campuslands.com', 'Bases de datos', 'activo'),
(3, 'Paula Mendoza', 'paula.mendoza@campuslands.com', 'Desarrollo web', 'activo'),
(4, 'Ricardo López', 'ricardo.lopez@campuslands.com', 'Programación', 'activo'),
(5, 'Natalia Vargas', 'natalia.vargas@campuslands.com', 'Backend', 'activo');

INSERT INTO rutas (id_ruta, nombre, jornada, estado) VALUES
(1, 'Desarrollo Web', 'manana', 'activa'),
(2, 'Programación Backend', 'tarde', 'activa'),
(3, 'Bases de Datos', 'noche', 'activa'),
(4, 'Desarrollo Frontend', 'manana', 'activa'),
(5, 'Análisis de Datos', 'tarde', 'activa'),
(6, 'DevOps', 'noche', 'activa');

INSERT INTO modulos (id_modulo, id_ruta, nombre, orden, horario) VALUES
(1, 1, 'Fundamentos de programación', 1, '08:00-10:00'),
(2, 1, 'HTML y CSS', 2, '10:00-12:00'),
(3, 1, 'JavaScript', 3, '08:00-10:00'),
(4, 2, 'Python', 1, '14:00-16:00'),
(5, 2, 'APIs REST', 2, '16:00-18:00'),
(6, 2, 'Node.js', 3, '14:00-16:00'),
(7, 3, 'Modelo relacional', 1, '18:00-20:00'),
(8, 3, 'SQL', 2, '20:00-22:00'),
(9, 4, 'React', 1, '08:00-10:00'),
(10, 4, 'TypeScript', 2, '10:00-12:00'),
(11, 5, 'Python para datos', 1, '14:00-16:00'),
(12, 5, 'Estadística', 2, '16:00-18:00'),
(13, 6, 'Linux', 1, '18:00-20:00'),
(14, 6, 'Contenedores', 2, '20:00-22:00');

INSERT INTO matriculas (id_matricula, id_estudiante, id_ruta, id_trainer, fecha_matricula, estado) VALUES
(1, 1, 1, 1, '2026-01-15', 'activa'),
(2, 2, 1, 1, '2026-01-16', 'activa'),
(3, 3, 2, 3, '2026-01-17', 'activa'),
(4, 4, 2, 3, '2026-01-18', 'activa'),
(5, 5, 3, 2, '2026-01-20', 'activa'),
(6, 6, 4, 3, '2026-01-21', 'activa'),
(7, 7, 4, 3, '2026-01-22', 'activa'),
(8, 8, 5, 5, '2026-01-24', 'activa'),
(9, 1, 3, 2, '2026-02-10', 'activa'),
(10, 2, 4, 3, '2026-02-11', 'finalizada'),
(11, 4, 5, 5, '2026-02-12', 'activa'),
(12, 5, 6, 4, '2026-02-13', 'activa');

INSERT INTO notas (id_matricula, id_modulo, nota) VALUES
(1, 1, 88),
(1, 2, 92),
(1, 3, 85),
(2, 1, 76),
(2, 2, 84),
(3, 4, 91),
(3, 5, 87),
(4, 4, 79),
(4, 5, 90),
(5, 7, 95),
(5, 8, 89),
(6, 9, 93),
(6, 10, 91),
(7, 9, 82),
(7, 10, 88),
(8, 11, 86),
(8, 12, 90),
(9, 7, 78),
(9, 8, 85),
(10, 9, 94),
(10, 10, 96),
(11, 11, 89),
(11, 12, 92),
(12, 13, 87),
(12, 14, 90);

-- CASOS INVALIDOS

-- INSERT INTO estudiantes (id_estudiante, documento, nombre_completo, correo, estado)
-- VALUES (9, '10010001', 'Pedro López', 'pedro.lopez@gmail.com', 'activo');

-- INSERT INTO notas (id_matricula, id_modulo, nota)
-- VALUES (1, 1, 105);