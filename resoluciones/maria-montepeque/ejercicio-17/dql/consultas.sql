-- Ejercicio 17: Red Social Campus
-- Entidad central: reacciones

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM reacciones;

-- 2. Mostrar solo dos columnas relevantes
SELECT tipo, fecha FROM reacciones;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM reacciones WHERE fecha >= '2026-07-03';

-- 4. Ordenar resultados por fecha
SELECT * FROM reacciones ORDER BY fecha;

-- 5. Mostrar las 5 publicaciones con mas reacciones
SELECT id_publicacion, COUNT(*) AS total_reacciones
FROM reacciones
GROUP BY id_publicacion
ORDER BY total_reacciones DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_reacciones FROM reacciones;

-- 7. Contar reacciones por tipo (frecuencia de cada tipo)
SELECT tipo, COUNT(*) AS cantidad
FROM reacciones
GROUP BY tipo;

-- 8. Agrupar reacciones por usuario
SELECT id_usuario, COUNT(*) AS total_reacciones
FROM reacciones
GROUP BY id_usuario;

-- 9. Relacionar reacciones, publicaciones y usuarios con JOIN
SELECT r.id_reaccion, u.nombre_usuario AS usuario, p.contenido AS publicacion
FROM reacciones r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN publicaciones p ON p.id_publicacion = r.id_publicacion;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM reacciones
WHERE tipo = 'like'
ORDER BY fecha DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    u.nombre_usuario AS usuario,
    p.contenido AS publicacion,
    r.tipo AS tipo_reaccion,
    r.fecha AS fecha_reaccion
FROM reacciones r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN publicaciones p ON p.id_publicacion = r.id_publicacion;

-- 12. Consulta para decision de negocio: publicacion con mas interacciones totales (reacciones + comentarios)
SELECT p.id_publicacion, p.contenido,
    (SELECT COUNT(*) FROM reacciones WHERE id_publicacion = p.id_publicacion) AS total_reacciones,
    (SELECT COUNT(*) FROM comentarios WHERE id_publicacion = p.id_publicacion) AS total_comentarios,
    (SELECT COUNT(*) FROM reacciones WHERE id_publicacion = p.id_publicacion)
    + (SELECT COUNT(*) FROM comentarios WHERE id_publicacion = p.id_publicacion) AS total_interacciones
FROM publicaciones p
ORDER BY total_interacciones DESC
LIMIT 1;
