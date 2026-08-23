-- Ejercicio 37: Normalizacion Biblioteca Multiautor

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (autores y generos de cada libro concatenados con '|', como en el CSV original)
SELECT
    p.id_prestamo,
    l.titulo AS libro,
    (SELECT GROUP_CONCAT(a.nombre, '|')
        FROM libro_autor la JOIN autores a ON a.id_autor = la.id_autor
        WHERE la.id_libro = l.id_libro) AS autores,
    (SELECT GROUP_CONCAT(g.nombre, '|')
        FROM libro_genero lg JOIN generos g ON g.id_genero = lg.id_genero
        WHERE lg.id_libro = l.id_libro) AS generos,
    u.nombre AS usuario,
    p.fecha_devolucion AS fecha_devolucion
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN usuarios u ON u.id_usuario = p.id_usuario
ORDER BY p.id_prestamo;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre FROM autores;
SELECT DISTINCT nombre FROM generos;
SELECT DISTINCT titulo FROM libros;
SELECT DISTINCT nombre FROM usuarios;

-- 3. Contar registros por categoria o estado (libros por genero)
SELECT g.nombre AS genero, COUNT(*) AS cantidad_libros
FROM libro_genero lg
JOIN generos g ON g.id_genero = lg.id_genero
GROUP BY g.nombre;

-- 4. Calcular un total por transaccion (cantidad de autores por libro)
SELECT l.titulo AS libro, COUNT(*) AS cantidad_autores
FROM libro_autor la
JOIN libros l ON l.id_libro = la.id_libro
GROUP BY l.titulo;

-- 5. Calcular promedio, minimo y maximo (prestamos por libro)
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM (
    SELECT id_libro, COUNT(*) AS cantidad
    FROM prestamos
    GROUP BY id_libro
);

-- 6. Buscar registros por texto con LIKE
SELECT * FROM libros WHERE titulo LIKE '%Datos%';
SELECT * FROM autores WHERE nombre LIKE 'A.%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM prestamos WHERE fecha_devolucion >= '2026-06-24';

-- 8. Mostrar top 5 por cantidad o monto (libros mas prestados)
SELECT l.titulo AS libro, COUNT(*) AS veces_prestado
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
GROUP BY l.titulo
ORDER BY veces_prestado DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (libros sin autor asignado)
SELECT l.id_libro, l.titulo
FROM libros l
LEFT JOIN libro_autor la ON la.id_libro = l.id_libro
WHERE la.id_autor IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    l.titulo AS libro,
    (SELECT GROUP_CONCAT(a.nombre, ', ')
        FROM libro_autor la JOIN autores a ON a.id_autor = la.id_autor
        WHERE la.id_libro = l.id_libro) AS autores,
    (SELECT GROUP_CONCAT(g.nombre, ', ')
        FROM libro_genero lg JOIN generos g ON g.id_genero = lg.id_genero
        WHERE lg.id_libro = l.id_libro) AS generos,
    u.nombre AS usuario,
    p.fecha_devolucion AS fecha_devolucion
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN usuarios u ON u.id_usuario = p.id_usuario
ORDER BY p.id_prestamo;
