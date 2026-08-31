.headers on
.mode column

-- Ejercicio 68: DROP Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT id_libro, titulo, categoria, disponible FROM libros;

-- 2. Consulta con WHERE.
SELECT titulo, categoria
FROM libros
WHERE disponible = 1;

-- 3. Consulta con ORDER BY.
SELECT titulo, categoria
FROM libros
ORDER BY categoria, titulo;

-- 4. Conteo o resumen.
SELECT categoria, COUNT(*) AS total_libros
FROM libros
GROUP BY categoria;

-- 5. Validacion especifica de DROP: la tabla temporal, el indice y la
-- vista que se usaron y luego se eliminaron ya no existen en el
-- catalogo de la base de datos, pero los libros migrados si siguen ahi.
SELECT name, type
FROM sqlite_master
WHERE name IN ('libros_importacion_temporal', 'idx_libros_categoria', 'vista_libros_programacion');
-- Debe devolver 0 filas: los 3 objetos se eliminaron con DROP.

SELECT titulo, categoria
FROM libros
WHERE titulo IN ('Clean Code', 'Redes de Computadoras', 'Designing Data-Intensive Applications');
-- Los 3 libros migrados desde la tabla temporal siguen disponibles.
