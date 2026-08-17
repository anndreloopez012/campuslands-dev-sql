-- Ejercicio 12: Streaming Musica
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO artistas (nombre, pais) VALUES
    ('Eco Norte', 'Chile');

INSERT INTO reproducciones (id_cancion, usuario, fecha_hora, dispositivo) VALUES
    (4, 'usuario06', '2026-08-04 20:15', 'web');

-- 2 UPDATE validos
UPDATE canciones
SET genero = 'Pop Latino'
WHERE id_cancion = 3;

UPDATE reproducciones
SET dispositivo = 'movil'
WHERE id_reproduccion = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM reproducciones
WHERE dispositivo = 'tablet';

DELETE FROM reproducciones
WHERE id_reproduccion = 11;
