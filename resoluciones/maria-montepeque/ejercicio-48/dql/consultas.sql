.headers on
.mode column

-- Ejercicio 48: FOREIGN KEY Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM prestamos;

-- 2. Consulta con WHERE.
SELECT id_prestamo, id_libro, prestatario
FROM prestamos
WHERE fecha_devolucion IS NULL;

-- 3. Consulta con ORDER BY.
SELECT id_prestamo, id_libro, prestatario, fecha_prestamo
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_prestamos,
    COUNT(DISTINCT id_libro) AS libros_distintos_prestados
FROM prestamos;

-- 5. Validacion especifica del tema FOREIGN KEY:
--    a) ON DELETE RESTRICT protege el catalogo: ningun autor con libros
--       puede borrarse (se demuestra en el caso comentado del DML; aqui se
--       confirma que Robert Martin sigue teniendo 2 libros).
SELECT a.nombre AS autor, COUNT(*) AS cantidad_libros
FROM libros l
JOIN autores a ON a.id_autor = l.id_autor
GROUP BY a.nombre
ORDER BY cantidad_libros DESC;

--    b) ON DELETE CASCADE ya se ejecuto en el DML (se borro el libro
--       "Design Patterns", id_libro = 5): esta consulta confirma que sus 2
--       prestamos desaparecieron junto con el, sin dejar filas huerfanas.
--       Total esperado: 8 prestamos (10 originales - 2 eliminados en cascada).
SELECT COUNT(*) AS total_prestamos_tras_cascada FROM prestamos;

SELECT * FROM prestamos WHERE id_libro = 5;   -- debe devolver 0 filas

-- Reporte: libros con su autor y cantidad de prestamos, apoyado en las dos
-- relaciones FOREIGN KEY encadenadas (prestamos -> libros -> autores).
SELECT
    l.titulo AS libro,
    a.nombre AS autor,
    COUNT(p.id_prestamo) AS veces_prestado
FROM libros l
JOIN autores a ON a.id_autor = l.id_autor
LEFT JOIN prestamos p ON p.id_libro = l.id_libro
GROUP BY l.titulo, a.nombre
ORDER BY veces_prestado DESC;
