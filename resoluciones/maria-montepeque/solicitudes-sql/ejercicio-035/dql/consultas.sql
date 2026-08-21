.headers on
.mode column

-- Ejercicio 035: Biblioteca Sci-Fi
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    lector y el libro en vez de solo los id).
SELECT
    p.id_prestamo,
    l.nombre_lector,
    b.titulo,
    p.fecha_prestamo,
    p.fecha_devolucion_esperada,
    p.estado
FROM prestamos p
JOIN lectores l ON l.id_lector = p.id_lector
JOIN libros b ON b.id_libro = p.id_libro;

-- 2. Que prestamos no estan devueltos todavia.
SELECT id_prestamo, id_libro, id_lector, fecha_devolucion_esperada, estado
FROM prestamos
WHERE estado <> 'devuelto';

-- 3. Que lector tiene mas prestamos en total.
SELECT l.nombre_lector, COUNT(*) AS total_prestamos
FROM lectores l
JOIN prestamos p ON p.id_lector = l.id_lector
GROUP BY l.id_lector, l.nombre_lector
ORDER BY total_prestamos DESC, l.nombre_lector;

-- 4. Prestamos ordenados por fecha de prestamo.
SELECT l.nombre_lector, b.titulo, p.fecha_prestamo
FROM prestamos p
JOIN lectores l ON l.id_lector = p.id_lector
JOIN libros b ON b.id_libro = p.id_libro
ORDER BY p.fecha_prestamo;

-- 5. Que lectores tienen libros atrasados o perdidos, para decidir a
--    quien contactar esta semana. Ordenado por la fecha en que debio
--    volver el libro (los mas viejos primero).
SELECT l.nombre_lector, b.titulo, p.fecha_devolucion_esperada, p.estado
FROM prestamos p
JOIN lectores l ON l.id_lector = p.id_lector
JOIN libros b ON b.id_libro = p.id_libro
WHERE p.estado IN ('atrasado', 'perdido')
ORDER BY p.fecha_devolucion_esperada;
