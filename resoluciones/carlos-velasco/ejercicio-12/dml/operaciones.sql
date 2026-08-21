PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO canciones (
    id_cancion,
    id_album,
    titulo,
    duracion_segundos,
    numero_pista
) VALUES
(26, 3, 'Nueva Frecuencia', 285, 6);

INSERT INTO reproducciones (
    id_reproduccion,
    id_cancion,
    fecha_hora,
    dispositivo,
    segundos_escuchados
) VALUES
(16, 26, '2026-08-21 08:00', 'Movil', 285);

-- UPDATES

UPDATE canciones
SET duracion_segundos = 290
WHERE id_cancion = 26;

UPDATE reproducciones
SET dispositivo = 'Desktop'
WHERE id_reproduccion = 16;

-- DELETES

DELETE FROM reproducciones
WHERE id_reproduccion = 16;

DELETE FROM canciones
WHERE id_cancion = 26;

-- OPERACIONES INVALIDAS

-- UNIQUE: artista duplicado
-- INSERT INTO artistas (
--     id_artista,
--     nombre,
--     genero_principal,
--     pais_origen,
--     anio_inicio
-- ) VALUES (
--     6,
--     'Luna Nova',
--     'Rock',
--     'Chile',
--     2020
-- );

-- FOREIGN KEY: album inexistente
-- INSERT INTO canciones (
--     id_cancion,
--     id_album,
--     titulo,
--     duracion_segundos,
--     numero_pista
-- ) VALUES (
--     27,
--     99,
--     'Cancion Invalida',
--     200,
--     1
-- );