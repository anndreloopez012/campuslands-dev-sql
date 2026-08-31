PRAGMA foreign_keys = ON;

-- Ejercicio 105: Triggers Nivel Intermedio
-- Datos de prueba: 4 pacientes, 2 medicos, 4 citas, 2 cambios de estado validos.

INSERT INTO pacientes (nombre_paciente, telefono) VALUES
    ('Ana Lopez',      '5555-0001'),
    ('Byron Ramirez',  '5555-0002'),
    ('Carla Gomez',    '5555-0003'),
    ('Diego Torres',   '5555-0004');

INSERT INTO medicos (nombre_medico, especialidad) VALUES
    ('Dra. Sofia Martinez', 'Medicina General'),
    ('Dr. Pedro Ramirez',   'Cardiologia');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita, estado) VALUES
    (1, 1, '2026-09-01', '09:00', 'programada'),
    (2, 1, '2026-09-01', '10:00', 'programada'),
    (3, 2, '2026-09-02', '09:00', 'atendida'),
    (4, 2, '2026-09-02', '10:00', 'programada');

-- Cada UPDATE de aqui abajo dispara trg_auditar_cambio_estado_cita y
-- deja una fila nueva en citas_auditoria, sin ningun INSERT manual
-- sobre esa tabla.
UPDATE citas SET estado = 'cancelada' WHERE id_cita = 2; -- Byron Ramirez cancela su cita
UPDATE citas SET estado = 'atendida'  WHERE id_cita = 1; -- Ana Lopez fue atendida

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- cita con un estado fuera del catalogo permitido. El
-- CHECK (estado IN (...)) lo rechaza.
-- INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita, estado) VALUES (1, 1, '2026-09-03', '09:00', 'pendiente');
