INSERT INTO pacientes (
    id_paciente,
    nombre_completo,
    documento,
    fecha_nacimiento,
    telefono,
    estado
) VALUES (
    6,
    'Daniel Fernandez',
    'DOC1006',
    '1999-05-12',
    '55510006',
    'ACTIVO'
);

INSERT INTO citas (
    id_cita,
    id_paciente,
    id_medico,
    id_consultorio,
    fecha_hora,
    motivo,
    estado
) VALUES (
    11,
    6,
    2,
    2,
    '2026-08-10 09:00',
    'Consulta pediatrica',
    'PROGRAMADA'
);

UPDATE pacientes
SET telefono = '55510999'
WHERE id_paciente = 6;

UPDATE citas
SET motivo = 'Control medico general'
WHERE id_cita = 11;

DELETE FROM citas
WHERE id_cita = 11;

DELETE FROM pacientes
WHERE id_paciente = 6;

-- Operacion invalida: UNIQUE
-- INSERT INTO pacientes (
--     id_paciente, nombre_completo, documento, fecha_nacimiento, telefono, estado
-- ) VALUES (
--     7, 'Paciente Duplicado', 'DOC1001', '1990-01-01', '55510007', 'ACTIVO'
-- );

-- Operacion invalida: CHECK
-- INSERT INTO consultorios (
--     id_consultorio, numero, piso, especialidad, estado
-- ) VALUES (
--     6, 0, 1, 'Cardiologia', 'DISPONIBLE'
-- );