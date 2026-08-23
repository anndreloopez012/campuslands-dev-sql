PRAGMA foreign_keys = ON;

-- 1. REGISTROS PRINCIPALES DE LA ENTIDAD CENTRAL

SELECT
    id_prestamo,
    id_usuario,
    id_libro,
    fecha_prestamo,
    fecha_devolucion,
    estado,
    dias_prestamo
FROM prestamos;

-- 2. DOS COLUMNAS RELEVANTES

SELECT
    fecha_prestamo,
    estado
FROM prestamos;

-- 3. FILTRAR POR CONDICION DE FECHA

SELECT
    id_prestamo,
    id_usuario,
    fecha_prestamo,
    estado
FROM prestamos
WHERE fecha_prestamo >= '2026-03-01';

-- 4. ORDENAR POR FECHA

SELECT
    id_prestamo,
    fecha_prestamo,
    estado
FROM prestamos
ORDER BY fecha_prestamo DESC;

-- 5. CINCO PRESTAMOS CON MAYOR DURACION

SELECT
    id_prestamo,
    id_usuario,
    id_libro,
    dias_prestamo,
    estado
FROM prestamos
ORDER BY dias_prestamo DESC
LIMIT 5;

-- 6. TOTAL DE PRESTAMOS

SELECT
    COUNT(*) AS total_prestamos
FROM prestamos;

-- 7. PROMEDIO, MINIMO Y MAXIMO DE DIAS DE PRESTAMO

SELECT
    ROUND(AVG(dias_prestamo), 2) AS promedio_dias,
    MIN(dias_prestamo) AS minimo_dias,
    MAX(dias_prestamo) AS maximo_dias
FROM prestamos;

-- 8. PRESTAMOS AGRUPADOS POR ESTADO

SELECT
    estado,
    COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY estado
ORDER BY total_prestamos DESC;

-- 9. RELACION ENTRE USUARIOS Y PRESTAMOS

SELECT
    u.nombre_completo,
    p.id_prestamo,
    p.fecha_prestamo,
    p.estado
FROM usuarios u
INNER JOIN prestamos p
    ON p.id_usuario = u.id_usuario
ORDER BY u.nombre_completo;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_prestamo,
    id_usuario,
    dias_prestamo,
    estado
FROM prestamos
WHERE estado IN ('PRESTADO', 'ATRASADO')
ORDER BY dias_prestamo DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    p.id_prestamo AS codigo_prestamo,
    u.nombre_completo AS usuario,
    l.titulo AS libro,
    s.nombre AS sede,
    p.fecha_prestamo AS fecha_prestamo,
    p.fecha_devolucion AS fecha_devolucion,
    p.estado AS estado_prestamo
FROM prestamos p
INNER JOIN usuarios u
    ON u.id_usuario = p.id_usuario
INNER JOIN libros l
    ON l.id_libro = p.id_libro
INNER JOIN sedes s
    ON s.id_sede = u.id_sede
ORDER BY p.fecha_prestamo DESC;

-- 12. DECISION DEL NEGOCIO: LIBROS CON MAYOR DEMANDA

SELECT
    l.titulo AS libro,
    COUNT(p.id_prestamo) AS total_prestamos,
    l.ejemplares AS ejemplares_disponibles,
    CASE
        WHEN COUNT(p.id_prestamo) >= 3 THEN 'Aumentar disponibilidad'
        WHEN COUNT(p.id_prestamo) = 2 THEN 'Mantener disponibilidad'
        ELSE 'Disponibilidad suficiente'
    END AS recomendacion
FROM libros l
LEFT JOIN prestamos p
    ON p.id_libro = l.id_libro
GROUP BY
    l.id_libro,
    l.titulo,
    l.ejemplares
ORDER BY total_prestamos DESC;