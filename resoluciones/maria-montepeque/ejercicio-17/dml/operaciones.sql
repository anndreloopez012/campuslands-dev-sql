-- Ejercicio 17: Red Social Campus
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO usuarios (nombre_usuario, correo, fecha_registro) VALUES
    ('isay', 'ingrid.say@correo.com', '2026-03-10');

INSERT INTO reacciones (id_publicacion, id_usuario, tipo, fecha) VALUES
    (1, 5, 'wow', '2026-07-01 08:40');

-- 2 UPDATE validos
UPDATE reacciones
SET tipo = 'love'
WHERE id_reaccion = 1;

UPDATE publicaciones
SET contenido = 'Empezando el semestre con energia nueva y muchas metas.'
WHERE id_publicacion = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM reacciones
WHERE id_reaccion = 6;

DELETE FROM reacciones
WHERE tipo = 'wow' AND id_reaccion = 4;
