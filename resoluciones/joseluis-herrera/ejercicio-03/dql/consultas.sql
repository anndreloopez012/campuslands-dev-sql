SELECT
    p.id_prestamo,
    l.titulo AS libro,
    c.nombre_completo AS camper,
    p.fecha_prestamo,
    p.fecha_devolucion,
    p.estado
FROM prestamos AS p
JOIN libros AS l
    ON p.id_libro = l.id_libro
JOIN campers AS c
    ON p.id_camper = c.id_camper;

SELECT
    titulo,
    isbn
FROM libros;

SELECT
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    estado
FROM prestamos
WHERE fecha_prestamo >= '2026-04-01';

SELECT
    id_prestamo,
    fecha_prestamo,
    fecha_devolucion,
    estado
FROM prestamos
ORDER BY fecha_prestamo ASC;

SELECT
    l.titulo AS libro,
    COUNT(p.id_prestamo) AS cantidad_prestamos
FROM libros AS l
LEFT JOIN prestamos AS p
    ON l.id_libro = p.id_libro
GROUP BY l.id_libro, l.titulo
ORDER BY cantidad_prestamos DESC
LIMIT 5;

SELECT COUNT(*) AS total_prestamos
FROM prestamos;

SELECT
    ROUND(AVG(julianday(fecha_devolucion) - julianday(fecha_prestamo)), 2) AS promedio_dias_prestamo,
    MIN(julianday(fecha_devolucion) - julianday(fecha_prestamo)) AS minimo_dias_prestamo,
    MAX(julianday(fecha_devolucion) - julianday(fecha_prestamo)) AS maximo_dias_prestamo
FROM prestamos
WHERE fecha_devolucion IS NOT NULL;

SELECT
    estado,
    COUNT(*) AS cantidad_prestamos
FROM prestamos
GROUP BY estado;

SELECT
    p.id_prestamo,
    l.titulo AS libro,
    c.nombre_completo AS camper,
    p.fecha_prestamo,
    p.estado
FROM prestamos AS p
JOIN libros AS l
    ON p.id_libro = l.id_libro
JOIN campers AS c
    ON p.id_camper = c.id_camper;

SELECT
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    estado
FROM prestamos
WHERE estado = 'DEVUELTO'
ORDER BY fecha_devolucion DESC
LIMIT 5;

SELECT
    l.titulo AS "Libro",
    a.nombre_completo AS "Autor",
    COUNT(p.id_prestamo) AS "Veces prestado"
FROM libros AS l
JOIN autores AS a
    ON l.id_autor = a.id_autor
LEFT JOIN prestamos AS p
    ON l.id_libro = p.id_libro
GROUP BY l.id_libro, l.titulo, a.nombre_completo
ORDER BY "Veces prestado" DESC;

SELECT
    l.titulo AS libro,
    l.ejemplares_disponibles AS ejemplares_disponibles,
    COUNT(
        CASE
            WHEN p.estado = 'PRESTADO' THEN 1
        END
    ) AS prestamos_activos,
    CASE
        WHEN l.ejemplares_disponibles = 0 THEN 'REABASTECER'
        WHEN l.ejemplares_disponibles <= 2 THEN 'VIGILAR INVENTARIO'
        ELSE 'DISPONIBILIDAD ADECUADA'
    END AS decision
FROM libros AS l
LEFT JOIN prestamos AS p
    ON l.id_libro = p.id_libro
GROUP BY l.id_libro, l.titulo, l.ejemplares_disponibles
ORDER BY l.ejemplares_disponibles ASC;