.headers on
.mode column

-- Ejercicio 46: PRIMARY KEY Nivel Aplicado
-- Consultas de validacion y reporte final.

-- 1. Mostrar todos los datos principales.
SELECT * FROM prestamos;

-- 2. Consulta con WHERE (prestamos activos, sin devolver).
SELECT id_prestamo, id_libro, prestatario, fecha_prestamo
FROM prestamos
WHERE fecha_devolucion IS NULL;

-- 3. Consulta con ORDER BY.
SELECT id_prestamo, id_libro, prestatario, fecha_prestamo
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_prestamos,
    SUM(CASE WHEN fecha_devolucion IS NULL THEN 1 ELSE 0 END) AS prestamos_activos,
    COUNT(DISTINCT id_libro) AS libros_distintos_prestados
FROM prestamos;

-- 5. Validacion especifica del tema PRIMARY KEY:
--    a) el mismo id_libro (FOREIGN KEY hacia la PRIMARY KEY de libros) se
--       repite en varios prestamos; cada fila sigue siendo unica gracias a
--       su propia PRIMARY KEY (id_prestamo). Se ve con "Clean Code"
--       (id_libro = 1), prestado 3 veces, 2 de ellas al mismo prestatario.
SELECT id_prestamo, prestatario, fecha_prestamo, fecha_devolucion
FROM prestamos
WHERE id_libro = 1
ORDER BY fecha_prestamo;

--    b) ninguna fila de prestamos se pierde ni se confunde entre si, aunque
--       existan combinaciones repetidas de libro y prestatario: cada
--       id_prestamo (PRIMARY KEY) las distingue sin ambiguedad.
SELECT id_libro, prestatario, COUNT(*) AS veces_prestado_a_esa_persona
FROM prestamos
GROUP BY id_libro, prestatario
HAVING COUNT(*) > 1;

-- Reporte final de negocio: libro mas prestado y autor con mas prestamos
-- totales, apoyandose en las PRIMARY KEY para unir las tres tablas sin
-- ambiguedad.
SELECT
    l.titulo AS libro,
    a.nombre AS autor,
    COUNT(*) AS veces_prestado
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN autores a ON a.id_autor = l.id_autor
GROUP BY l.titulo, a.nombre
ORDER BY veces_prestado DESC
LIMIT 5;
