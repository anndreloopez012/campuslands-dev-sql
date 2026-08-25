INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    nombre_usuario,
    email,
    fecha_registro
) VALUES (
    6,
    'Maria Hernandez',
    'maria_hernandez',
    'maria@campus.com',
    '2026-08-13'
);

INSERT INTO publicaciones (
    id_publicacion,
    id_usuario,
    contenido,
    fecha_publicacion,
    vistas,
    estado
) VALUES (
    6,
    6,
    'Nuevo contenido sobre bases de datos',
    '2026-08-13 10:00:00',
    100,
    'publicada'
);

UPDATE usuarios
SET nombre_completo = 'Maria Isabel Hernandez'
WHERE id_usuario = 6;

UPDATE publicaciones
SET vistas = 175
WHERE id_publicacion = 6;

DELETE FROM publicaciones
WHERE id_publicacion = 6;

DELETE FROM usuarios
WHERE id_usuario = 6;

-- INSERT INTO usuarios (
--     id_usuario,
--     nombre_completo,
--     nombre_usuario,
--     email,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Usuario Duplicado',
--     'carlos_ramirez',
--     'duplicado@campus.com',
--     '2026-08-14'
-- );

-- INSERT INTO publicaciones (
--     id_publicacion,
--     id_usuario,
--     contenido,
--     fecha_publicacion,
--     vistas,
--     estado
-- ) VALUES (
--     7,
--     999,
--     'Publicacion con usuario inexistente',
--     '2026-08-14 10:00:00',
--     50,
--     'publicada'
-- );