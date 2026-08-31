PRAGMA foreign_keys = ON;

-- Ejercicio 89: GROUP BY Nivel Basico
-- Datos de prueba.

INSERT INTO medicos (nombre_medico, especialidad) VALUES
    ('Dra. Sofia Ramirez', 'Medicina General'),
    ('Dr. Carlos Perez', 'Pediatria'),
    ('Dra. Marta Lopez', 'Traumatologia');

INSERT INTO pacientes (nombre_paciente, telefono) VALUES
    ('Manuel Estrada', '5555-4601'),
    ('Alejandra Chinchilla', '5555-4602'),
    ('Byron Xicay', '5555-4603'),
    ('Cristina Barrios', '5555-4604');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, duracion_minutos, estado) VALUES
    (1, 1, '2026-08-20', 30, 'atendida'),
    (2, 1, '2026-08-20', 20, 'atendida'),
    (3, 2, '2026-08-20', 45, 'programada'),
    (4, 1, '2026-08-21', 30, 'programada'),
    (1, 2, '2026-08-21', 60, 'programada'),
    (2, 3, '2026-08-22', 40, 'cancelada'),
    (3, 3, '2026-08-22', 30, 'programada');
