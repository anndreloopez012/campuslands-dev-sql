PRAGMA foreign_keys = ON;

-- Ejercicio 51: UNIQUE Nivel Intermedio
-- Datos de prueba para validar el tema UNIQUE.

INSERT INTO pacientes (nombre, documento) VALUES
    ('Jorge Alvarado', 'DPI-7001'),
    ('Rosa Mendez', 'DPI-7002'),
    ('Tomas Blanco', 'DPI-7003'),
    ('Ivonne Castro', 'DPI-7004'),
    ('Julio Perez', 'DPI-7005');

INSERT INTO medicos (nombre, correo) VALUES
    ('Dra. Marta Solis', 'marta.solis@clinica.com'),
    ('Dr. Ernesto Diaz', 'ernesto.diaz@clinica.com'),
    ('Dra. Carla Nunez', 'carla.nunez@clinica.com'),
    ('Dr. Felipe Ramos', 'felipe.ramos@clinica.com'),
    ('Dra. Silvia Ortiz', 'silvia.ortiz@clinica.com');

-- Caso valido que demuestra el UNIQUE compuesto: el mismo medico (Dra.
-- Marta Solis, id_medico = 1) atiende varias citas, en horas DISTINTAS
-- (eso es valido: id_medico solo, sin la fecha_hora, no es UNIQUE). Y a la
-- misma hora '2026-08-05 08:00' hay citas de DOS medicos distintos (1 y 2):
-- tambien valido, porque fecha_hora sola tampoco es UNIQUE.
INSERT INTO citas (id_paciente, id_medico, fecha_hora, estado) VALUES
    (1, 1, '2026-08-05 08:00', 'atendida'),
    (2, 2, '2026-08-05 08:00', 'atendida'),
    (3, 1, '2026-08-05 09:00', 'programada'),
    (4, 3, '2026-08-05 09:00', 'programada'),
    (5, 4, '2026-08-05 10:00', 'programada'),
    (1, 5, '2026-08-06 08:00', 'programada'),
    (2, 1, '2026-08-06 09:00', 'programada'),
    (3, 2, '2026-08-06 10:00', 'programada'),
    (4, 3, '2026-08-07 08:00', 'programada'),
    (5, 4, '2026-08-07 09:00', 'programada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- la Dra. Marta Solis (id_medico = 1) YA tiene una cita a las
-- '2026-08-05 08:00' (ver arriba). Agendarla otra vez a esa misma hora, con
-- otro paciente, viola el UNIQUE compuesto (id_medico, fecha_hora): es
-- exactamente la doble reserva que esta restriccion existe para evitar.
-- INSERT INTO citas (id_paciente, id_medico, fecha_hora, estado) VALUES (3, 1, '2026-08-05 08:00', 'programada');

-- Otro caso comentado que debe fallar: repetir el correo de un medico ya
-- registrado (UNIQUE simple).
-- INSERT INTO medicos (nombre, correo) VALUES ('Dr. Nuevo Medico', 'marta.solis@clinica.com');
