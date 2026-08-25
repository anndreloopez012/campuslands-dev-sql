SELECT
    l.titulo AS libro,
    GROUP_CONCAT(DISTINCT a.nombre_completo) AS autores,
    GROUP_CONCAT(DISTINCT g.nombre) AS generos,
    u.nombre_completo AS usuario,
    p.fecha_prestamo AS fecha_prestamo,
    p.fecha_devolucion_prevista AS fecha_devolucion,
    p.estado
FROM prestamos p
JOIN usuarios u
    ON p.id_usuario = u.id_usuario
JOIN detalle_prestamo dp
    ON p.id_prestamo = dp.id_prestamo
JOIN libros l
    ON dp.id_libro = l.id_libro
LEFT JOIN libro_autor la
    ON l.id_libro = la.id_libro
LEFT JOIN autores a
    ON la.id_autor = a.id_autor
LEFT JOIN libro_genero lg
    ON l.id_libro = lg.id_libro
LEFT JOIN generos g
    ON lg.id_genero = g.id_genero
GROUP BY
    p.id_prestamo,
    dp.id_detalle,
    l.id_libro,
    l.titulo,
    u.nombre_completo,
    p.fecha_prestamo,
    p.fecha_devolucion_prevista,
    p.estado
ORDER BY p.id_prestamo, l.titulo;

SELECT DISTINCT
    id_libro,
    titulo,
    isbn
FROM libros
ORDER BY titulo;

SELECT DISTINCT
    id_autor,
    nombre_completo AS autor
FROM autores
ORDER BY nombre_completo;

SELECT DISTINCT
    id_genero,
    nombre AS genero
FROM generos
ORDER BY nombre;

SELECT DISTINCT
    id_usuario,
    nombre_completo AS usuario
FROM usuarios
ORDER BY nombre_completo;

SELECT
    estado,
    COUNT(*) AS cantidad_prestamos
FROM prestamos
GROUP BY estado
ORDER BY cantidad_prestamos DESC;

SELECT
    g.nombre AS genero,
    COUNT(DISTINCT lg.id_libro) AS cantidad_libros
FROM generos g
LEFT JOIN libro_genero lg
    ON g.id_genero = lg.id_genero
GROUP BY g.id_genero, g.nombre
ORDER BY cantidad_libros DESC;

SELECT
    p.id_prestamo,
    u.nombre_completo AS usuario,
    COUNT(dp.id_detalle) AS cantidad_libros
FROM prestamos p
JOIN usuarios u
    ON p.id_usuario = u.id_usuario
JOIN detalle_prestamo dp
    ON p.id_prestamo = dp.id_prestamo
GROUP BY p.id_prestamo, u.nombre_completo
ORDER BY cantidad_libros DESC;

SELECT
    p.id_prestamo,
    u.nombre_completo AS usuario,
    COUNT(dp.id_detalle) AS cantidad_libros,
    SUM(l.ejemplares) AS ejemplares_referenciados
FROM prestamos p
JOIN usuarios u
    ON p.id_usuario = u.id_usuario
JOIN detalle_prestamo dp
    ON p.id_prestamo = dp.id_prestamo
JOIN libros l
    ON dp.id_libro = l.id_libro
GROUP BY p.id_prestamo, u.nombre_completo
ORDER BY cantidad_libros DESC;

SELECT
    ROUND(AVG(ejemplares), 2) AS promedio_ejemplares,
    MIN(ejemplares) AS minimo_ejemplares,
    MAX(ejemplares) AS maximo_ejemplares
FROM libros;

SELECT
    COUNT(*) AS total_libros,
    COUNT(DISTINCT id_autor) AS autores
FROM libro_autor;

SELECT
    id_libro,
    titulo,
    isbn
FROM libros
WHERE titulo LIKE '%amor%'
   OR titulo LIKE '%agua%'
   OR titulo LIKE '%Aleph%'
ORDER BY titulo;

SELECT
    id_autor,
    nombre_completo
FROM autores
WHERE nombre_completo LIKE '%Garcia%'
   OR nombre_completo LIKE '%Luis%'
ORDER BY nombre_completo;

SELECT
    id_prestamo,
    id_usuario,
    fecha_prestamo,
    fecha_devolucion_prevista,
    estado
FROM prestamos
WHERE fecha_prestamo BETWEEN '2026-08-01' AND '2026-08-10'
ORDER BY fecha_prestamo;

SELECT
    id_libro,
    titulo,
    anio_publicacion,
    ejemplares
FROM libros
WHERE anio_publicacion BETWEEN 1940 AND 1980
ORDER BY anio_publicacion;

SELECT
    l.titulo AS libro,
    COUNT(dp.id_detalle) AS veces_prestado
FROM libros l
JOIN detalle_prestamo dp
    ON l.id_libro = dp.id_libro
GROUP BY l.id_libro, l.titulo
ORDER BY veces_prestado DESC
LIMIT 5;

SELECT
    u.nombre_completo AS usuario,
    COUNT(p.id_prestamo) AS cantidad_prestamos
FROM usuarios u
LEFT JOIN prestamos p
    ON u.id_usuario = p.id_usuario
GROUP BY u.id_usuario, u.nombre_completo
ORDER BY cantidad_prestamos DESC
LIMIT 5;

SELECT
    l.id_libro,
    l.titulo
FROM libros l
LEFT JOIN detalle_prestamo dp
    ON l.id_libro = dp.id_libro
WHERE dp.id_detalle IS NULL
ORDER BY l.titulo;

SELECT
    a.id_autor,
    a.nombre_completo AS autor
FROM autores a
LEFT JOIN libro_autor la
    ON a.id_autor = la.id_autor
WHERE la.id_libro IS NULL
ORDER BY a.nombre_completo;

SELECT
    p.id_prestamo,
    u.nombre_completo AS usuario,
    COUNT(dp.id_detalle) AS libros_prestados,
    p.fecha_prestamo,
    p.fecha_devolucion_prevista,
    p.estado
FROM prestamos p
JOIN usuarios u
    ON p.id_usuario = u.id_usuario
LEFT JOIN detalle_prestamo dp
    ON p.id_prestamo = dp.id_prestamo
GROUP BY
    p.id_prestamo,
    u.nombre_completo,
    p.fecha_prestamo,
    p.fecha_devolucion_prevista,
    p.estado
ORDER BY p.fecha_prestamo DESC;

SELECT
    l.titulo AS libro,
    GROUP_CONCAT(DISTINCT a.nombre_completo) AS autores,
    GROUP_CONCAT(DISTINCT g.nombre) AS generos,
    COUNT(DISTINCT dp.id_prestamo) AS veces_prestado,
    l.ejemplares AS ejemplares_disponibles,
    l.estado AS estado_libro
FROM libros l
LEFT JOIN libro_autor la
    ON l.id_libro = la.id_libro
LEFT JOIN autores a
    ON la.id_autor = a.id_autor
LEFT JOIN libro_genero lg
    ON l.id_libro = lg.id_libro
LEFT JOIN generos g
    ON lg.id_genero = g.id_genero
LEFT JOIN detalle_prestamo dp
    ON l.id_libro = dp.id_libro
GROUP BY
    l.id_libro,
    l.titulo,
    l.ejemplares,
    l.estado
ORDER BY veces_prestado DESC, l.titulo;