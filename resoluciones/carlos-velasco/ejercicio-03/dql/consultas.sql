PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. Listar todos los registros principales
-- Entidad central: prestamos
-- =========================================================

SELECT
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    fecha_devolucion,
    estado
FROM prestamos;

-- =========================================================
-- 2. Mostrar solo dos columnas relevantes
-- =========================================================

SELECT
    titulo,
    paginas
FROM libros;

-- =========================================================
-- 3. Filtrar por condición de fecha
-- Préstamos realizados desde julio de 2026
-- =========================================================

SELECT
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    estado
FROM prestamos
WHERE fecha_prestamo >= '2026-07-01';

-- =========================================================
-- 4. Ordenar resultados por fecha
-- =========================================================

SELECT
    id_prestamo,
    fecha_prestamo,
    fecha_devolucion,
    estado
FROM prestamos
ORDER BY fecha_prestamo DESC;

-- =========================================================
-- 5. Mostrar los 5 registros más importantes
-- Libros con mayor cantidad de préstamos
-- =========================================================

SELECT
    l.id_libro,
    l.titulo,
    COUNT(p.id_prestamo) AS total_prestamos
FROM libros AS l
LEFT JOIN prestamos AS p
    ON l.id_libro = p.id_libro
GROUP BY
    l.id_libro,
    l.titulo
ORDER BY total_prestamos DESC
LIMIT 5;

-- =========================================================
-- 6. Contar registros totales
-- =========================================================

SELECT
    COUNT(*) AS total_prestamos
FROM prestamos;

-- =========================================================
-- 7. Calcular promedio, mínimo y máximo
-- =========================================================

SELECT
    ROUND(AVG(paginas), 2) AS promedio_paginas,
    MIN(paginas) AS minimo_paginas,
    MAX(paginas) AS maximo_paginas
FROM libros;

-- =========================================================
-- 8. Agrupar registros con GROUP BY
-- Cantidad de préstamos por estado
-- =========================================================

SELECT
    estado,
    COUNT(*) AS cantidad_prestamos
FROM prestamos
GROUP BY estado;

-- =========================================================
-- 9. Relacionar mínimo dos tablas con JOIN
-- =========================================================

SELECT
    p.id_prestamo,
    c.nombre_completo AS camper,
    l.titulo AS libro,
    p.fecha_prestamo,
    p.estado
FROM prestamos AS p
INNER JOIN campers AS c
    ON p.id_camper = c.id_camper
INNER JOIN libros AS l
    ON p.id_libro = l.id_libro;

-- =========================================================
-- 10. WHERE + ORDER BY + LIMIT
-- Préstamos actualmente activos
-- =========================================================

SELECT
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    estado
FROM prestamos
WHERE estado = 'PRESTADO'
ORDER BY fecha_prestamo ASC
LIMIT 5;

-- =========================================================
-- 11. Reporte con alias legibles
-- =========================================================

SELECT
    p.id_prestamo AS 'ID Prestamo',
    c.nombre_completo AS 'Nombre Camper',
    l.titulo AS 'Libro',
    a.nombre_completo AS 'Autor',
    p.fecha_prestamo AS 'Fecha Prestamo',
    p.fecha_devolucion AS 'Fecha Devolucion',
    p.estado AS 'Estado'
FROM prestamos AS p
INNER JOIN campers AS c
    ON p.id_camper = c.id_camper
INNER JOIN libros AS l
    ON p.id_libro = l.id_libro
INNER JOIN autores AS a
    ON l.id_autor = a.id_autor
ORDER BY p.fecha_prestamo DESC;

-- =========================================================
-- 12. Consulta para apoyar una decisión de negocio
-- Identificar los libros con mayor demanda.
-- Si un libro tiene 2 o más préstamos, se considera
-- candidato para adquirir más ejemplares.
-- =========================================================

SELECT
    l.titulo AS 'Libro',
    COUNT(p.id_prestamo) AS 'Total Prestamos',
    CASE
        WHEN COUNT(p.id_prestamo) >= 2
            THEN 'Priorizar adquisicion de ejemplares'
        ELSE 'Inventario actual suficiente'
    END AS 'Decision'
FROM libros AS l
LEFT JOIN prestamos AS p
    ON l.id_libro = p.id_libro
GROUP BY
    l.id_libro,
    l.titulo
ORDER BY COUNT(p.id_prestamo) DESC;