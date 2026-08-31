.headers on
.mode column

-- Ejercicio 085: Biblioteca Sci-Fi
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_resumen_prestamos (creada en ddl/schema.sql).
SELECT *
FROM vista_resumen_prestamos;

-- 2. Que prestamos estan prestados, atrasados, devueltos o perdidos.
SELECT id_prestamo, id_libro, id_lector, estado
FROM prestamos
ORDER BY estado;

-- 3. Que lector tiene mas prestamos (ranking de actividad).
SELECT lec.nombre_lector, COUNT(*) AS total_prestamos
FROM lectores lec
JOIN prestamos pr ON pr.id_lector = lec.id_lector
GROUP BY lec.id_lector, lec.nombre_lector
ORDER BY total_prestamos DESC, lec.nombre_lector;

-- 4. Prestamos ordenados por fecha.
SELECT id_prestamo, fecha_prestamo, estado
FROM prestamos
ORDER BY fecha_prestamo;

-- 5. Reporte para decision de negocio: autor con mas prestamos en
-- total, para decidir de cual comprar mas ejemplares (GROUP BY +
-- HAVING, usando la vista para no repetir el JOIN).
SELECT nombre_autor,
       COUNT(*) AS total_prestamos
FROM vista_resumen_prestamos
GROUP BY nombre_autor
HAVING COUNT(*) >= 1
ORDER BY total_prestamos DESC, nombre_autor;
