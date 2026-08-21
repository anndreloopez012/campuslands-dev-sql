PRAGMA foreign_keys = ON;

-- Ejercicio 67: ALTER TABLE Nivel Aplicado
-- Se ejecuta despues de los ALTER TABLE de ddl/schema.sql, por eso ya se
-- pueden usar las columnas nuevas (estado, motivo, consultorio) y el
-- nombre nuevo de columna (fecha_hora_cita).

-- Los 2 medicos llegaron con consultorio = 'Sin asignar' por el DEFAULT
-- del ALTER TABLE. Se asigna su consultorio real.
UPDATE medicos SET consultorio = 'Consultorio 1' WHERE nombre = 'Dra. Sofia Ramirez';
UPDATE medicos SET consultorio = 'Consultorio 2' WHERE nombre = 'Dr. Carlos Perez';

-- Las citas ya pasadas se marcan como atendidas (llegaron con
-- estado = 'programada' por el DEFAULT).
UPDATE citas SET estado = 'atendida' WHERE id_cita IN (1, 2, 3);

-- Paciente y cita nuevos, ya con la estructura final (todas las
-- columnas indicadas de forma explicita).
INSERT INTO pacientes (nombre, telefono) VALUES
    ('Cristina Barrios', '5555-6004');

INSERT INTO citas (id_paciente, id_medico, fecha_hora_cita, estado, motivo) VALUES
    (4, 1, '2026-08-05 09:30', 'programada', 'control de presion arterial');
