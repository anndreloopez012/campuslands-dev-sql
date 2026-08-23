PRAGMA foreign_keys = ON;

-- 1. LISTAR TODAS LAS PUBLICACIONES

SELECT
    id_publicacion,
    usuario_id,
    contenido,
    fecha_publicacion,
    visibilidad
FROM publicaciones;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    id_publicacion,
    fecha_publicacion
FROM publicaciones;

-- 3. FILTRAR POR FECHA

SELECT
    id_publicacion,
    contenido,
    fecha_publicacion
FROM publicaciones
WHERE fecha_publicacion >= '2026-02-15';

-- 4. ORDENAR POR FECHA

SELECT
    id_publicacion,
    contenido,
    fecha_publicacion
FROM publicaciones
ORDER BY fecha_publicacion ASC;

-- 5. TOP 5 PUBLICACIONES POR INTERACCIONES

SELECT
    p.id_publicacion,
    p.contenido,
    COUNT(DISTINCT c.id_comentario) + COUNT(DISTINCT r.id_reaccion) AS total_interacciones
FROM publicaciones p
LEFT JOIN comentarios c
    ON c.publicacion_id = p.id_publicacion
LEFT JOIN reacciones r
    ON r.publicacion_id = p.id_publicacion
GROUP BY
    p.id_publicacion,
    p.contenido
ORDER BY total_interacciones DESC
LIMIT 5;

-- 6. CONTAR PUBLICACIONES

SELECT COUNT(*) AS total_publicaciones
FROM publicaciones;

-- 7. PROMEDIO DE COMENTARIOS POR PUBLICACION

SELECT
    AVG(total_comentarios) AS promedio_comentarios
FROM (
    SELECT
        p.id_publicacion,
        COUNT(c.id_comentario) AS total_comentarios
    FROM publicaciones p
    LEFT JOIN comentarios c
        ON c.publicacion_id = p.id_publicacion
    GROUP BY p.id_publicacion
);

-- 8. AGRUPAR PUBLICACIONES POR VISIBILIDAD

SELECT
    visibilidad,
    COUNT(*) AS total_publicaciones
FROM publicaciones
GROUP BY visibilidad;

-- 9. RELACIONAR USUARIOS Y PUBLICACIONES

SELECT
    u.nombre_completo,
    u.nombre_usuario,
    p.id_publicacion,
    p.contenido
FROM usuarios u
INNER JOIN publicaciones p
    ON p.usuario_id = u.id_usuario
ORDER BY u.nombre_completo ASC;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    id_publicacion,
    usuario_id,
    contenido,
    fecha_publicacion
FROM publicaciones
WHERE visibilidad = 'publica'
ORDER BY fecha_publicacion DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    u.nombre_completo AS autor,
    p.contenido AS publicacion,
    p.fecha_publicacion AS fecha,
    COUNT(DISTINCT c.id_comentario) AS comentarios,
    COUNT(DISTINCT r.id_reaccion) AS reacciones
FROM publicaciones p
INNER JOIN usuarios u
    ON u.id_usuario = p.usuario_id
LEFT JOIN comentarios c
    ON c.publicacion_id = p.id_publicacion
LEFT JOIN reacciones r
    ON r.publicacion_id = p.id_publicacion
GROUP BY
    p.id_publicacion,
    u.nombre_completo,
    p.contenido,
    p.fecha_publicacion
ORDER BY reacciones DESC, comentarios DESC;

-- 12. DECISION DE NEGOCIO: PUBLICACIONES CON MAYOR INTERACCION

SELECT
    p.id_publicacion,
    u.nombre_usuario AS autor,
    p.contenido,
    COUNT(DISTINCT c.id_comentario) AS comentarios,
    COUNT(DISTINCT r.id_reaccion) AS reacciones,
    CASE
        WHEN COUNT(DISTINCT c.id_comentario) + COUNT(DISTINCT r.id_reaccion) >= 2
            THEN 'Alta interaccion'
        ELSE 'Baja interaccion'
    END AS nivel_interaccion
FROM publicaciones p
INNER JOIN usuarios u
    ON u.id_usuario = p.usuario_id
LEFT JOIN comentarios c
    ON c.publicacion_id = p.id_publicacion
LEFT JOIN reacciones r
    ON r.publicacion_id = p.id_publicacion
GROUP BY
    p.id_publicacion,
    u.nombre_usuario,
    p.contenido
ORDER BY
    (COUNT(DISTINCT c.id_comentario) + COUNT(DISTINCT r.id_reaccion)) DESC;