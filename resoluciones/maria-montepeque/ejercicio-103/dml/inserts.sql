PRAGMA foreign_keys = ON;

-- Ejercicio 103: Procedimientos almacenados Nivel Aplicado
-- Datos de prueba: 5 pacientes, 3 medicos, 5 citas.
--
-- Cada INSERT en "citas" pasa primero por trg_validar_choque_agenda
-- (la alternativa ejecutable al procedimiento almacenado). Las 5
-- citas de aqui abajo son validas porque ninguna repite el mismo
-- medico en la misma fecha y hora.

INSERT INTO pacientes (nombre_paciente, telefono) VALUES
    ('Ana Lopez',        '5555-0001'),
    ('Byron Ramirez',    '5555-0002'),
    ('Carla Gomez',      '5555-0003'),
    ('Diego Torres',     '5555-0004'),
    ('Elena Ruiz',       '5555-0005');

INSERT INTO medicos (nombre_medico, especialidad) VALUES
    ('Dra. Sofia Martinez', 'Medicina General'),
    ('Dr. Pedro Ramirez',   'Cardiologia'),
    ('Dra. Lucia Fernandez','Pediatria');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita, estado) VALUES
    (1, 1, '2026-09-01', '09:00', 'programada'),
    (2, 1, '2026-09-01', '10:00', 'programada'),
    (3, 2, '2026-09-01', '09:00', 'programada'),
    (4, 3, '2026-09-02', '11:00', 'programada'),
    (5, 2, '2026-09-02', '09:30', 'programada');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- cita con un estado fuera del catalogo permitido. El
-- CHECK (estado IN (...)) lo rechaza.
-- INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita, estado) VALUES (1, 1, '2026-09-03', '09:00', 'pendiente');
