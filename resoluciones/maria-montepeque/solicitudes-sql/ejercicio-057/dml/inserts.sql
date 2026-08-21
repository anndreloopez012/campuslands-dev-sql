PRAGMA foreign_keys = ON;

-- Ejercicio 057: Academia Kickboxing
-- Datos de prueba.

INSERT INTO planes (nombre_plan, precio_mensual, clases_por_semana) VALUES
    ('Plan Basico', 350.00, 2),
    ('Plan Intermedio', 500.00, 3),
    ('Plan Avanzado', 650.00, 5),
    ('Plan Competencia', 800.00, 6);

INSERT INTO entrenadores (nombre_entrenador, especialidad) VALUES
    ('Coach Manuel Xoc', 'kickboxing'),
    ('Coach Deisy Pu', 'muay_thai'),
    ('Coach Fernando Ac', 'boxeo'),
    ('Coach Lorena Say', 'defensa_personal');

-- Bryan Ical (id_alumno = 5) ya esta 'inactivo' (se dio de baja).
INSERT INTO alumnos (nombre_alumno, id_plan, fecha_inscripcion, estado) VALUES
    ('Kevin Aju', 2, '2026-06-01', 'activo'),
    ('Paola Ramos', 3, '2026-06-15', 'activo'),
    ('Diego Chavajay', 1, '2026-07-01', 'suspendido'),
    ('Fernanda Us', 4, '2026-05-10', 'activo'),
    ('Bryan Ical', 2, '2026-07-10', 'inactivo'),
    ('Ninoska Cux', 3, '2026-06-20', 'activo');

-- La asistencia 11 es un duplicado por error de digitacion (mismo
-- alumno, entrenador, fecha y estado que la asistencia 1): se
-- corrige en dml/operaciones.sql. La asistencia 9 es una inasistencia
-- de Bryan Ical, que ya esta 'inactivo': se borrara de forma
-- controlada.
INSERT INTO asistencias (id_alumno, id_entrenador, fecha_clase, estado) VALUES
    (1, 1, '2026-08-01', 'presente'),
    (2, 2, '2026-08-01', 'presente'),
    (4, 3, '2026-08-02', 'presente'),
    (1, 1, '2026-08-03', 'ausente'),
    (6, 4, '2026-08-03', 'presente'),
    (2, 2, '2026-08-04', 'justificada'),
    (4, 3, '2026-08-05', 'presente'),
    (3, 1, '2026-08-05', 'ausente'),
    (5, 2, '2026-08-06', 'ausente'),
    (1, 1, '2026-08-07', 'presente'),
    (1, 1, '2026-08-01', 'presente');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_alumno ya existe, viola el UNIQUE.
-- INSERT INTO alumnos (nombre_alumno, id_plan, fecha_inscripcion) VALUES ('Kevin Aju', 1, '2026-08-08');

-- 2) Valor fuera de rango: precio_mensual = 0 no es un plan valido, viola el CHECK.
-- INSERT INTO planes (nombre_plan, precio_mensual, clases_por_semana) VALUES ('Plan Prueba', 0, 1);
