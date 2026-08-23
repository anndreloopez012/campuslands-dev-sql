PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO pacientes (
    id_paciente,
    nombre_completo,
    documento,
    fecha_nacimiento,
    telefono,
    correo
) VALUES
(6, 'Daniela Vargas Cruz', 'DOC-1006', '1991-09-12', '5551-1006', 'daniela.vargas@email.com');

INSERT INTO citas (
    id_cita,
    id_paciente,
    id_medico,
    id_consultorio,
    fecha_hora,
    motivo,
    estado
) VALUES
(11, 6, 5, 5, '2026-08-23 09:00', 'Consulta de seguimiento', 'Programada');

-- UPDATES

UPDATE pacientes
SET telefono = '5551-9001'
WHERE id_paciente = 1;

UPDATE citas
SET estado = 'Confirmada'
WHERE id_cita = 2;

-- DELETES

DELETE FROM citas
WHERE id_cita = 11;

DELETE FROM pacientes
WHERE id_paciente = 6;

-- OPERACIONES INVALIDAS

-- UNIQUE: documento duplicado
-- INSERT INTO pacientes (
--     id_paciente,
--     nombre_completo,
--     documento,
--     fecha_nacimiento,
--     telefono,
--     correo
-- ) VALUES (
--     7,
--     'Paciente Documento Duplicado',
--     'DOC-1001',
--     '1995-04-10',
--     '5551-1007',
--     'duplicado@email.com'
-- );

-- FOREIGN KEY: medico inexistente
-- INSERT INTO citas (
--     id_cita,
--     id_paciente,
--     id_medico,
--     id_consultorio,
--     fecha_hora,
--     motivo,
--     estado
-- ) VALUES (
--     12,
--     1,
--     99,
--     1,
--     '2026-08-23 10:00',
--     'Cita con medico inexistente',
--     'Programada'
-- );