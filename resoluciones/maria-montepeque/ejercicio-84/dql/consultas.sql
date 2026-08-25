.headers on
.mode column

-- Ejercicio 84: WHERE Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_prestamo, l.titulo, a.nombre_autor, p.nombre_prestatario, p.fecha_prestamo
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN autores a ON a.id_autor = l.id_autor;

-- 2. WHERE con negacion (<>) y agrupacion con parentesis: libros que
-- NO son de categoria 'Arquitectura', y que ademas tienen mas de un
-- ejemplar.
SELECT titulo, categoria, ejemplares_totales
FROM libros
WHERE categoria <> 'Arquitectura'
  AND (ejemplares_totales > 1 OR categoria = 'Algoritmos');

-- 3. Consulta con ORDER BY: libros ordenados por cantidad de
-- ejemplares, de mayor a menor.
SELECT titulo, ejemplares_totales
FROM libros
ORDER BY ejemplares_totales DESC;

-- 4. Conteo o resumen: prestamos activos vs. devueltos, usando
-- IS NULL / IS NOT NULL.
SELECT
    (SELECT COUNT(*) FROM prestamos WHERE fecha_devolucion IS NULL) AS activos,
    (SELECT COUNT(*) FROM prestamos WHERE fecha_devolucion IS NOT NULL) AS devueltos;

-- 5. Validacion especifica de WHERE (nivel intermedio: subconsulta
-- dentro de WHERE con IN). Prestamos activos de libros de categoria
-- 'Arquitectura', combinando IS NULL con una subconsulta que primero
-- filtra los libros de esa categoria.
SELECT p.id_prestamo, p.nombre_prestatario, p.fecha_prestamo
FROM prestamos p
WHERE p.fecha_devolucion IS NULL
  AND p.id_libro IN (
      SELECT id_libro FROM libros WHERE categoria = 'Arquitectura'
  );

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: parentesis sin cerrar en la condicion de WHERE.
-- SELECT * FROM libros WHERE (categoria = 'Arquitectura' AND ejemplares_totales > 1;
