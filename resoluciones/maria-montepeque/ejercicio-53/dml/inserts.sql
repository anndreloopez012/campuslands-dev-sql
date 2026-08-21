PRAGMA foreign_keys = ON;

-- Ejercicio 53: NOT NULL Nivel Basico
-- Datos de prueba para validar el tema NOT NULL.

-- correo se deja NULL para Karla Diaz: es un campo opcional, y NOT NULL no
-- lo exige.
INSERT INTO pacientes (nombre, telefono, correo) VALUES
    ('Jorge Alvarado', '5553001', 'jorge.alvarado@correo.com'),
    ('Rosa Mendez', '5553002', 'rosa.mendez@correo.com'),
    ('Tomas Blanco', '5553003', 'tomas.blanco@correo.com'),
    ('Karla Diaz', '5553004', NULL),
    ('Julio Perez', '5553005', 'julio.perez@correo.com');

INSERT INTO medicos (nombre, especialidad) VALUES
    ('Dra. Marta Solis', 'Medicina general'),
    ('Dr. Ernesto Diaz', 'Pediatria'),
    ('Dra. Carla Nunez', 'Dermatologia'),
    ('Dr. Felipe Ramos', 'Cardiologia'),
    ('Dra. Silvia Ortiz', 'Ginecologia');

-- notas se deja NULL en las citas que todavia no se atienden: es opcional
-- hasta que el medico realmente atienda al paciente.
INSERT INTO citas (id_paciente, id_medico, fecha_hora, estado, notas) VALUES
    (1, 1, '2026-08-05 08:00', 'atendida', 'Paciente estable, control en 3 meses'),
    (2, 2, '2026-08-05 09:00', 'programada', NULL),
    (3, 3, '2026-08-05 10:00', 'programada', NULL),
    (4, 4, '2026-08-06 08:00', 'atendida', 'Se receta tratamiento por 2 semanas'),
    (5, 5, '2026-08-06 09:00', 'programada', NULL),
    (1, 3, '2026-08-07 08:00', 'cancelada', NULL),
    (2, 1, '2026-08-07 09:00', 'programada', NULL);

-- Caso valido: correo y notas pueden faltar (NULL) sin problema, porque no
-- llevan NOT NULL.
INSERT INTO pacientes (nombre, telefono, correo) VALUES
    ('Ingrid Say', '5553006', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- nombre es NOT NULL en pacientes; omitirlo (o pasar NULL explicito) falla.
-- INSERT INTO pacientes (nombre, telefono, correo) VALUES (NULL, '5553007', 'sin.nombre@correo.com');

-- Otro caso comentado que debe fallar: fecha_hora es NOT NULL en citas; una
-- cita sin fecha no tiene sentido de negocio y la base la rechaza.
-- INSERT INTO citas (id_paciente, id_medico, fecha_hora) VALUES (1, 1, NULL);
