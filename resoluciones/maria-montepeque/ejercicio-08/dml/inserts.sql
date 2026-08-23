-- Ejercicio 08: Clinica de Citas
-- Datos base: 5 pacientes, 5 medicos, 5 consultorios, 10 citas

INSERT INTO pacientes (nombre, correo, telefono) VALUES
    ('Jorge Alvarado', 'jorge.alvarado@correo.com', '5553001'),
    ('Rosa Mendez', 'rosa.mendez@correo.com', '5553002'),
    ('Tomas Blanco', 'tomas.blanco@correo.com', '5553003'),
    ('Ivonne Castro', 'ivonne.castro@correo.com', '5553004'),
    ('Julio Perez', 'julio.perez@correo.com', '5553005');

INSERT INTO medicos (nombre, especialidad, colegiado) VALUES
    ('Dra. Marta Solis', 'Medicina general', 'COL-1001'),
    ('Dr. Ernesto Diaz', 'Pediatria', 'COL-1002'),
    ('Dra. Carla Nunez', 'Dermatologia', 'COL-1003'),
    ('Dr. Felipe Ramos', 'Cardiologia', 'COL-1004'),
    ('Dra. Silvia Ortiz', 'Ginecologia', 'COL-1005');

INSERT INTO consultorios (numero, piso) VALUES
    (101, 1),
    (102, 1),
    (201, 2),
    (202, 2),
    (301, 3);

INSERT INTO citas (id_paciente, id_medico, id_consultorio, fecha_hora, estado) VALUES
    (1, 1, 1, '2026-08-05 08:00', 'atendida'),
    (2, 2, 2, '2026-08-05 09:00', 'atendida'),
    (3, 3, 3, '2026-08-05 10:00', 'programada'),
    (4, 4, 4, '2026-08-05 11:00', 'programada'),
    (5, 5, 5, '2026-08-05 12:00', 'programada'),
    (1, 2, 2, '2026-08-06 08:30', 'programada'),
    (2, 1, 1, '2026-08-06 09:30', 'cancelada'),
    (3, 4, 4, '2026-08-06 10:30', 'programada'),
    (4, 3, 3, '2026-08-06 11:30', 'atendida'),
    (5, 1, 1, '2026-08-07 08:00', 'programada');
