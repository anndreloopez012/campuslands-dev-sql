-- Ejercicio 08: Clinica de Citas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO medicos (nombre, especialidad, colegiado) VALUES
    ('Dr. Manuel Pineda', 'Traumatologia', 'COL-1006');

INSERT INTO citas (id_paciente, id_medico, id_consultorio, fecha_hora, estado) VALUES
    (2, 5, 5, '2026-08-07 09:00', 'programada');

-- 2 UPDATE validos
UPDATE citas
SET estado = 'atendida'
WHERE id_cita = 4;

UPDATE pacientes
SET telefono = '5559000'
WHERE id_paciente = 3;

-- 2 DELETE controlados con WHERE
DELETE FROM citas
WHERE estado = 'cancelada';

DELETE FROM citas
WHERE id_cita = 11;
