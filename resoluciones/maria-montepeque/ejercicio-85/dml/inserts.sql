PRAGMA foreign_keys = ON;

-- Ejercicio 85: WHERE Nivel Aplicado
-- Datos de prueba.

INSERT INTO medicos (nombre_medico, especialidad) VALUES
    ('Dra. Sofia Ramirez', 'Medicina General'),
    ('Dr. Carlos Perez', 'Pediatria'),
    ('Dra. Marta Lopez', 'Traumatologia');

INSERT INTO pacientes (nombre_paciente, telefono) VALUES
    ('Manuel Estrada', '5555-4401'),
    ('Alejandra Chinchilla', '5555-4402'),
    ('Byron Xicay', '5555-4403'),
    ('Cristina Barrios', '5555-4404'),
    ('Diego Paz', '5555-4405');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita, estado) VALUES
    (1, 1, '2026-08-20', '09:00', 'atendida'),
    (2, 2, '2026-08-20', '10:00', 'atendida'),
    (3, 3, '2026-08-20', '11:00', 'programada'),
    (4, 1, '2026-08-20', '14:00', 'programada'),
    (5, 2, '2026-08-18', '09:00', 'cancelada'),
    (5, 3, '2026-08-19', '10:00', 'cancelada'),
    (1, 1, '2026-08-21', '09:00', 'programada'),
    (3, 2, '2026-08-21', '11:00', 'programada'),
    (2, 3, '2026-08-17', '15:00', 'atendida'),
    (5, 1, '2026-08-22', '10:00', 'programada');
