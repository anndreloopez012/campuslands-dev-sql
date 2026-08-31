.headers on
.mode column

-- Ejercicio 64: AUTO_INCREMENT Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (prestamos con libro y autor).
SELECT p.id_prestamo, l.titulo AS libro, a.nombre AS autor,
       p.prestatario, p.fecha_prestamo, p.estado
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN autores a ON a.id_autor = l.id_autor;

-- 2. Consulta con WHERE: prestamos que aun no se han devuelto.
SELECT id_prestamo, prestatario, estado
FROM prestamos
WHERE estado IN ('prestado', 'atrasado');

-- 3. Consulta con ORDER BY: prestamos ordenados por fecha.
SELECT id_prestamo, fecha_prestamo, estado
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen: total de prestamos por estado.
SELECT estado, COUNT(*) AS total
FROM prestamos
GROUP BY estado;

-- 5. Validacion especifica de AUTO_INCREMENT: el comprobante 3
-- (anulado) nunca vuelve a aparecer, y el ultimo prestamo insertado
-- recibio un comprobante nuevo (7), no el que quedo libre.
SELECT id_prestamo, prestatario
FROM prestamos
ORDER BY id_prestamo;

SELECT id_prestamo
FROM prestamos
WHERE id_prestamo = 3;
-- Debe devolver 0 filas: el comprobante 3 quedo libre pero AUTOINCREMENT no lo reutilizo.

-- 6. Consulta de decision de negocio (nivel aplicado): libro con mas
-- prestamos historicos, para decidir si conviene comprar mas ejemplares.
SELECT l.titulo AS libro,
       COUNT(*) AS total_prestamos
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
GROUP BY l.id_libro
ORDER BY total_prestamos DESC
LIMIT 1;
