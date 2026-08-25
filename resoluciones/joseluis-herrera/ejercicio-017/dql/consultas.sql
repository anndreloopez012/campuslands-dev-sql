SELECT
    id_publicacion,
    id_usuario,
    contenido,
    fecha_publicacion,
    vistas,
    estado
FROM publicaciones;

SELECT
    id_publicacion,
    contenido
FROM publicaciones;

SELECT
    id_publicacion,
    contenido,
    vistas,
    fecha_publicacion
FROM publicaciones
WHERE vistas >= 300;

SELECT
    id_publicacion,
    contenido,
    fecha_publicacion
FROM publicaciones
ORDER BY fecha_publicacion DESC;

SELECT
    id_publicacion,
    contenido,
    vistas
FROM publicaciones
ORDER BY vistas DESC
LIMIT 5;

SELECT COUNT(*) AS total_publicaciones
FROM publicaciones;

SELECT
    AVG(vistas) AS promedio_vistas,
    MIN(vistas) AS minimo_vistas,
    MAX(vistas) AS maximo_vistas
FROM publicaciones;

SELECT
    estado,
    COUNT(*) AS cantidad_publicaciones
FROM publicaciones
GROUP BY estado;

SELECT
    p.id_publicacion,
    u.nombre_usuario AS autor,
    p.contenido,
    p.fecha_publicacion,
    p.vistas
FROM publicaciones AS p
JOIN usuarios AS u
    ON p.id_usuario = u.id_usuario;

SELECT
    p.id_publicacion,
    u.nombre_usuario AS autor,
    p.contenido,
    p.vistas
FROM publicaciones AS p
JOIN usuarios AS u
    ON p.id_usuario = u.id_usuario
WHERE p.estado = 'publicada'
ORDER BY p.vistas DESC
LIMIT 5;

SELECT
    p.id_publicacion AS publicacion,
    u.nombre_usuario AS autor,
    COUNT(DISTINCT c.id_comentario) AS comentarios,
    COUNT(DISTINCT r.id_reaccion) AS reacciones,
    p.vistas AS vistas
FROM publicaciones AS p
JOIN usuarios AS u
    ON p.id_usuario = u.id_usuario
LEFT JOIN comentarios AS c
    ON p.id_publicacion = c.id_publicacion
LEFT JOIN reacciones AS r
    ON p.id_publicacion = r.id_publicacion
GROUP BY
    p.id_publicacion,
    u.nombre_usuario,
    p.vistas
ORDER BY reacciones DESC;

SELECT
    r.tipo AS tipo_reaccion,
    COUNT(*) AS cantidad
FROM reacciones AS r
GROUP BY r.tipo
ORDER BY cantidad DESC;

SELECT
    u.nombre_usuario AS usuario,
    COUNT(DISTINCT c.id_comentario) AS comentarios_realizados,
    COUNT(DISTINCT r.id_reaccion) AS reacciones_realizadas,
    COUNT(DISTINCT c.id_comentario) + COUNT(DISTINCT r.id_reaccion) AS interacciones
FROM usuarios AS u
LEFT JOIN comentarios AS c
    ON u.id_usuario = c.id_usuario
LEFT JOIN reacciones AS r
    ON u.id_usuario = r.id_usuario
GROUP BY u.id_usuario, u.nombre_usuario
ORDER BY interacciones DESC;

SELECT
    p.id_publicacion AS publicacion,
    u.nombre_usuario AS autor,
    p.vistas,
    COUNT(DISTINCT c.id_comentario) AS comentarios,
    COUNT(DISTINCT r.id_reaccion) AS reacciones,
    CASE
        WHEN p.vistas >= 400
             AND COUNT(DISTINCT r.id_reaccion) >= 2
            THEN 'Contenido de alto impacto'
        WHEN p.vistas >= 250
            THEN 'Contenido con buen alcance'
        ELSE 'Considerar mejorar contenido'
    END AS decision_contenido
FROM publicaciones AS p
JOIN usuarios AS u
    ON p.id_usuario = u.id_usuario
LEFT JOIN comentarios AS c
    ON p.id_publicacion = c.id_publicacion
LEFT JOIN reacciones AS r
    ON p.id_publicacion = r.id_publicacion
WHERE p.estado = 'publicada'
GROUP BY
    p.id_publicacion,
    u.nombre_usuario,
    p.vistas
ORDER BY p.vistas DESC;