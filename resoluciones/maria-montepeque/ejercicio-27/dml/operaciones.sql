-- Ejercicio 27: Indices y Busquedas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO categorias (nombre) VALUES
    ('Contabilidad');

INSERT INTO inscripciones (id_curso, estudiante_nombre, estudiante_correo, fecha_inscripcion, estado) VALUES
    (2, 'Ingrid Say', 'ingrid.say@correo.com', '2026-07-15', 'inscrito');

-- 2 UPDATE validos
UPDATE inscripciones
SET estado = 'completado'
WHERE id_inscripcion = 4;

UPDATE cursos
SET precio = 320.00
WHERE id_curso = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM inscripciones
WHERE id_inscripcion = 6;

DELETE FROM inscripciones
WHERE estado = 'inscrito' AND id_inscripcion = 9;
