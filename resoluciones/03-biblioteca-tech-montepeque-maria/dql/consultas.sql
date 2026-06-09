.headers on .mode column

-- Ejercicio 03: Biblioteca Tech

-- 1. Listar todos los registros principales.

SELECT * FROM libros;

-- 2. Mostrar solo dos columnas relevantes.

SELECT titulo, precio FROM libros;

-- 3. Filtrar por condicion numerica o de fecha.

SELECT titulo, precio FROM libros WHERE precio > 400;

-- 4. Ordenar resultados.

SELECT titulo, precio FROM libros ORDER BY precio DESC;

-- 5. Mostrar top 5 por una metrica

SELECT titulo, precio FROM libros ORDER BY precio DESC LIMIT 5;

-- 6. Contar registros totales.

SELECT COUNT(*) AS total_libros FROM libros;

-- 7. Calcular promedio, minimo o maximo.

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM libros;

-- 8. Agrupar con GROUP BY

SELECT c.nombre AS categoria, COUNT(l.id) AS cantidad_libros
FROM categorias c
    LEFT JOIN libros l ON l.categoria_id = c.id
GROUP BY
    c.id,
    c.nombre
ORDER BY cantidad_libros DESC;

-- 9. Relacionar minimo dos tablas con JOIN

SELECT l.titulo AS libro, c.nombre AS categoria, a.nombre AS autor
FROM
    libros l
    JOIN categorias c ON l.categoria_id = c.id
    JOIN autores a ON l.autor_id = a.id
ORDER BY l.titulo;

-- 10. Usar WHERE, ORDER BY y LIMIT

SELECT titulo, precio, stock
FROM libros
WHERE
    estado = 'disponible'
ORDER BY precio ASC
LIMIT 3;

-- 11. Crear reporte con alias

SELECT
    s.nombre AS socio,
    l.titulo AS libro_prestado,
    p.fecha_prestamo AS desde,
    p.estado AS situacion
FROM
    prestamos p
    JOIN socios s ON p.socio_id = s.id
    JOIN libros l ON p.libro_id = l.id
WHERE
    p.fecha_devolucion IS NULL
ORDER BY p.fecha_prestamo;

-- 12. Consulta para decision del negocio

SELECT
    l.titulo AS libro,
    COUNT(p.id) AS veces_prestado,
    l.stock AS stock_actual
FROM libros l
    JOIN prestamos p ON p.libro_id = l.id
GROUP BY
    l.id,
    l.titulo,
    l.stock
ORDER BY veces_prestado DESC
LIMIT 5;