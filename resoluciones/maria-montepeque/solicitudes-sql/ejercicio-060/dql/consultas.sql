.headers on
.mode column

-- Ejercicio 060: Biblioteca Sci-Fi
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: libro,
--    autor y lector).
SELECT
    p.id_prestamo,
    l.nombre_lector,
    b.titulo,
    a.nombre_autor,
    p.fecha_prestamo,
    p.fecha_devolucion_esperada,
    p.estado
FROM prestamos p
JOIN lectores l ON l.id_lector = p.id_lector
JOIN libros b ON b.id_libro = p.id_libro
JOIN autores a ON a.id_autor = b.id_autor;

-- 2. Que prestamos no estan devueltos todavia.
SELECT id_prestamo, id_libro, id_lector, fecha_devolucion_esperada, estado
FROM prestamos
WHERE estado <> 'devuelto';

-- 3. Que lector tiene mas prestamos.
SELECT l.nombre_lector, COUNT(*) AS total_prestamos
FROM lectores l
JOIN prestamos p ON p.id_lector = l.id_lector
GROUP BY l.id_lector, l.nombre_lector
ORDER BY total_prestamos DESC, l.nombre_lector;

-- 4. Prestamos ordenados por fecha.
SELECT l.nombre_lector, b.titulo, p.fecha_prestamo
FROM prestamos p
JOIN lectores l ON l.id_lector = p.id_lector
JOIN libros b ON b.id_libro = p.id_libro
ORDER BY p.fecha_prestamo;

-- 5. Que autor tiene mas prestamos en total, para decidir de cual
--    comprar mas ejemplares.
SELECT a.nombre_autor, COUNT(*) AS total_prestamos
FROM autores a
JOIN libros b ON b.id_autor = a.id_autor
JOIN prestamos p ON p.id_libro = b.id_libro
GROUP BY a.id_autor, a.nombre_autor
ORDER BY total_prestamos DESC, a.nombre_autor;
