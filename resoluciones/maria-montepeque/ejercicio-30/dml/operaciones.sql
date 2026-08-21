-- Ejercicio 30: Proyecto Integrador SQL
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO campers (id_ruta, nombre, correo, fecha_ingreso) VALUES
    (5, 'Ingrid Say', 'ingrid.say@correo.com', '2026-02-01');

INSERT INTO evaluaciones (id_camper, id_modulo, nota, fecha) VALUES
    (2, 3, 88.0, '2026-03-25');

-- 2 UPDATE validos
UPDATE evaluaciones
SET nota = 82.0
WHERE id_evaluacion = 5;

UPDATE modulos
SET horas = 65
WHERE id_modulo = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM asistencias
WHERE id_asistencia = 5;

DELETE FROM evaluaciones
WHERE id_camper = 3 AND id_evaluacion = 4;
