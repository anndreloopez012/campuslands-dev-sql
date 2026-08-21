.headers on
.mode column

-- Ejercicio 010: Biblioteca Sci-Fi
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM prestamos;

-- 2. Que prestamos no estan devueltos todavia.
SELECT id_prestamo, id_libro, nombre_lector, fecha_prestamo, estado
FROM prestamos
WHERE estado <> 'devuelto';

-- 3. Que lector tiene mas prestamos.
SELECT nombre_lector, COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY nombre_lector
ORDER BY total_prestamos DESC;

-- 4. Prestamos ordenados por fecha.
SELECT id_prestamo, nombre_lector, fecha_prestamo, estado
FROM prestamos
ORDER BY fecha_prestamo;

-- 5. Que libros son los mas prestados historicamente, para decidir si
--    comprar mas copias.
SELECT l.titulo, l.autor, COUNT(p.id_prestamo) AS veces_prestado
FROM libros l
JOIN prestamos p ON p.id_libro = l.id_libro
GROUP BY l.id_libro, l.titulo, l.autor
ORDER BY veces_prestado DESC;
