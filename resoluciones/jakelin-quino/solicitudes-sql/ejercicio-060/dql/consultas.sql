.headers on
.mode column

-- Ejercicio 060: Biblioteca Sci-Fi
-- 1. Libros prestados actualmente
SELECT p.id, l.titulo, u.nombre AS lector, p.fecha_prestamo FROM prestamos p JOIN libros l ON l.id = p.libro_id JOIN usuarios u ON u.id = p.usuario_id WHERE p.estado = 'prestado';

-- 2. Catalogo completo de libros
SELECT id, titulo, autor FROM libros ORDER BY titulo;

-- 3. Total de prestamos realizados por lector
SELECT u.nombre, COUNT(p.id) AS total_prestamos FROM prestamos p JOIN usuarios u ON u.id = p.usuario_id GROUP BY u.id, u.nombre;