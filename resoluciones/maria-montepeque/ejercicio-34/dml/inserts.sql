-- Ejercicio 34: Normalizacion Clinica Tratamientos
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (pacientes 1-2, especialidades 1-2, medicos 1-2 y las consultas 1-3 con sus
--  tratamientos vienen del CSV original; el resto se agrega para cumplir el
--  minimo de datos del ejercicio)
--
-- Nota sobre el CSV original: las filas id_consulta=1 e id_consulta=3 tienen
-- la misma paciente (Rosa Lima), el mismo medico (Dr. Perez) y la misma
-- especialidad (Dental), pero fechas distintas (2026-06-03 y 2026-06-10):
-- son dos consultas reales en dias diferentes, no una fila duplicada como en
-- otros ejercicios de normalizacion, asi que se mantienen como dos registros
-- separados en `consultas`.

INSERT INTO pacientes (nombre, dpi) VALUES
    ('Rosa Lima', 'DPI-200'),
    ('Mario Leon', 'DPI-201'),
    ('Elena Ruiz', 'DPI-202'),
    ('Hugo Marroquin', 'DPI-203'),
    ('Vivian Castillo', 'DPI-204');

INSERT INTO especialidades (nombre) VALUES
    ('Dental'),
    ('General'),
    ('Pediatria'),
    ('Cardiologia'),
    ('Dermatologia');

INSERT INTO medicos (nombre, id_especialidad) VALUES
    ('Dr. Perez', 1),
    ('Dra. Gomez', 2),
    ('Dr. Salazar', 3),
    ('Dra. Ortiz', 4),
    ('Dr. Ical', 5);

INSERT INTO consultas (id_paciente, id_medico, fecha_consulta) VALUES
    (1, 1, '2026-06-03'),   -- consulta 1 del CSV: Rosa Lima con Dr. Perez
    (2, 2, '2026-06-03'),   -- consulta 2 del CSV: Mario Leon con Dra. Gomez
    (1, 1, '2026-06-10'),   -- consulta 3 del CSV: Rosa Lima con Dr. Perez (otra fecha)
    (3, 3, '2026-06-11'),   -- consulta adicional
    (4, 4, '2026-06-12'),   -- consulta adicional
    (5, 5, '2026-06-13');   -- consulta adicional

INSERT INTO tratamientos (id_consulta, nombre, costo) VALUES
    -- consulta 1 (CSV): Limpieza|Radiografia, 250|180
    (1, 'Limpieza', 250.00),
    (1, 'Radiografia', 180.00),
    -- consulta 2 (CSV): Consulta|Laboratorio, 200|320
    (2, 'Consulta', 200.00),
    (2, 'Laboratorio', 320.00),
    -- consulta 3 (CSV): Calza|Limpieza, 400|250
    (3, 'Calza', 400.00),
    (3, 'Limpieza', 250.00),
    -- consultas adicionales para completar el minimo de 10 lineas de detalle
    (4, 'Consulta', 200.00),
    (4, 'Vacuna', 150.00),
    (5, 'Electrocardiograma', 350.00),
    (5, 'Consulta', 200.00),
    (6, 'Biopsia', 500.00),
    (6, 'Consulta', 200.00);

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (pacientes.dpi): el dpi ya existe
-- INSERT INTO pacientes (nombre, dpi) VALUES ('Duplicado', 'DPI-200');

-- Falla por CHECK (costo > 0)
-- INSERT INTO tratamientos (id_consulta, nombre, costo) VALUES (1, 'Prueba', -10.00);
