PRAGMA foreign_keys = ON;

-- INSERT

INSERT INTO publicaciones (
    id_publicacion,
    usuario_id,
    contenido,
    fecha_publicacion,
    visibilidad
) VALUES (
    11,
    3,
    'Analizando el comportamiento de una red social educativa.',
    '2026-02-24',
    'publica'
);

INSERT INTO comentarios (
    id_comentario,
    publicacion_id,
    usuario_id,
    contenido,
    fecha_comentario
) VALUES (
    11,
    11,
    4,
    'Excelente tema para practicar.',
    '2026-02-24'
);

-- UPDATE

UPDATE usuarios
SET correo = 'carlos.velasco.dev@campus.edu'
WHERE id_usuario = 1;

UPDATE publicaciones
SET visibilidad = 'privada'
WHERE id_publicacion = 10;

-- DELETE

DELETE FROM comentarios
WHERE id_comentario = 10;

DELETE FROM reacciones
WHERE id_reaccion = 10;

-- OPERACIONES INVALIDAS

-- UNIQUE
-- INSERT INTO usuarios (
--     id_usuario,
--     nombre_completo,
--     nombre_usuario,
--     correo,
--     fecha_registro
-- ) VALUES (
--     12,
--     'Usuario Duplicado',
--     'carlos.velasco',
--     'duplicado@campus.edu',
--     '2026-03-01'
-- );

-- FOREIGN KEY
-- INSERT INTO publicaciones (
--     id_publicacion,
--     usuario_id,
--     contenido,
--     fecha_publicacion,
--     visibilidad
-- ) VALUES (
--     12,
--     999,
--     'Publicacion con usuario inexistente.',
--     '2026-03-01',
--     'publica'
-- );