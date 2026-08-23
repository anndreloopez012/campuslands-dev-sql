PRAGMA foreign_keys = ON;

-- Ejercicio 49: FOREIGN KEY Nivel Aplicado
-- Datos de prueba para validar el tema FOREIGN KEY.

INSERT INTO pacientes (nombre, documento) VALUES
    ('Jorge Alvarado', 'DPI-7001'),
    ('Rosa Mendez', 'DPI-7002'),
    ('Tomas Blanco', 'DPI-7003'),
    ('Ivonne Castro', 'DPI-7004'),
    ('Julio Perez', 'DPI-7005');

INSERT INTO medicos (nombre, especialidad) VALUES
    ('Dra. Marta Solis', 'Medicina general'),
    ('Dr. Ernesto Diaz', 'Pediatria'),
    ('Dra. Carla Nunez', 'Dermatologia'),
    ('Dr. Felipe Ramos', 'Cardiologia'),
    ('Dra. Silvia Ortiz', 'Ginecologia');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, estado) VALUES
    (1, 1, '2026-08-05', 'atendida'),
    (2, 2, '2026-08-05', 'atendida'),
    (3, 3, '2026-08-05', 'programada'),
    (4, 4, '2026-08-05', 'programada'),
    (5, 5, '2026-08-05', 'programada'),
    (1, 2, '2026-08-06', 'programada'),
    (2, 4, '2026-08-06', 'atendida'),
    (3, 4, '2026-08-06', 'programada'),
    (4, 3, '2026-08-07', 'programada'),
    (5, 1, '2026-08-07', 'programada');

-- Caso valido que demuestra ON DELETE SET NULL: el "Dr. Felipe Ramos"
-- (id_medico = 4) deja de trabajar en la clinica. Sus 3 citas (a Ivonne
-- Castro, Rosa Mendez y Tomas Blanco) NO se eliminan ni bloquean el borrado:
-- quedan con id_medico = NULL, conservando el historial del paciente.
-- Verificado antes y despues en dql/consultas.sql (punto 5.b).
DELETE FROM medicos WHERE id_medico = 4;

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- Jorge Alvarado (id_paciente = 1) tiene citas registradas. ON DELETE
-- RESTRICT en citas.id_paciente lo impide (a diferencia del SET NULL de
-- arriba, aqui el historial clinico se protege sin excepcion).
-- DELETE FROM pacientes WHERE id_paciente = 1;

-- Otro caso comentado que debe fallar: registrar una cita de un paciente
-- que no existe en el catalogo.
-- INSERT INTO citas (id_paciente, id_medico, fecha_cita, estado) VALUES (999, 1, '2026-08-10', 'programada');
