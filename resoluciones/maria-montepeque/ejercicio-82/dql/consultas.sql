.headers on
.mode column

-- Ejercicio 82: SELECT Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales: prestamos con su libro y su
-- autor, con alias descriptivos.
SELECT p.id_prestamo,
       l.titulo AS libro,
       a.nombre_autor AS autor,
       p.nombre_prestatario,
       p.fecha_prestamo,
       p.fecha_devolucion
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN autores a ON a.id_autor = l.id_autor;

-- 2. Consulta con WHERE: solo los prestamos activos (todavia no se
-- devuelve el libro).
SELECT id_prestamo, id_libro, nombre_prestatario, fecha_prestamo
FROM prestamos
WHERE fecha_devolucion IS NULL;

-- 3. Consulta con ORDER BY: prestamos ordenados por fecha.
SELECT id_prestamo, fecha_prestamo, fecha_devolucion
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen: total de prestamos por libro.
SELECT id_libro, COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY id_libro;

-- 5. Caso de negocio con reporte final (nivel aplicado): disponibi-
-- lidad real de cada libro, calculada con una subconsulta correla-
-- cionada (ejemplares totales menos prestamos activos de ese libro
-- especifico) y un CASE WHEN que traduce el numero a un estado
-- legible. Esto demuestra que SELECT puede combinar varias tecnicas
-- para responder una pregunta de negocio real: "que libros quedan
-- disponibles ahora mismo".
SELECT l.titulo,
       l.ejemplares_totales,
       l.ejemplares_totales - (
           SELECT COUNT(*)
           FROM prestamos p
           WHERE p.id_libro = l.id_libro AND p.fecha_devolucion IS NULL
       ) AS ejemplares_disponibles,
       CASE
           WHEN l.ejemplares_totales - (
               SELECT COUNT(*)
               FROM prestamos p
               WHERE p.id_libro = l.id_libro AND p.fecha_devolucion IS NULL
           ) > 0 THEN 'disponible'
           ELSE 'agotado'
       END AS estado_disponibilidad
FROM libros l
ORDER BY l.titulo;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: escribir mal el nombre de una funcion de agregacion
-- (COUN en vez de COUNT).
-- SELECT COUN(*) FROM libros;
