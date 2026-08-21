.headers on
.mode column

-- Ejercicio 66: ALTER TABLE Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (prestamos con libro y
-- escritor, ya con la estructura final).
SELECT p.id_prestamo, l.titulo AS libro, e.nombre AS escritor,
       p.nombre_prestatario, p.fecha_prestamo, p.estado
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN escritores e ON e.id_autor = l.id_autor;

-- 2. Consulta con WHERE: libros de la categoria 'programacion'.
SELECT titulo, categoria, ejemplares_disponibles
FROM libros
WHERE categoria = 'programacion';

-- 3. Consulta con ORDER BY: prestamos ordenados por fecha.
SELECT id_prestamo, nombre_prestatario, fecha_prestamo
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen: total de libros por categoria.
SELECT categoria, COUNT(*) AS total_libros
FROM libros
GROUP BY categoria;

-- 5. Validacion especifica de ALTER TABLE: los 2 libros y los 2
-- prestamos creados antes de las modificaciones conservaron sus datos
-- originales, ahora con las columnas nuevas y renombradas.
SELECT l.titulo, l.categoria, l.ejemplares_disponibles
FROM libros l
WHERE l.titulo IN ('Clean Code', 'Redes de Computadoras');

SELECT p.id_prestamo, p.nombre_prestatario, p.estado
FROM prestamos p
WHERE p.id_prestamo IN (1, 2);

-- La FOREIGN KEY de libros.id_autor sigue funcionando despues de
-- renombrar autores a escritores.
SELECT l.titulo, e.nombre AS escritor
FROM libros l
JOIN escritores e ON e.id_autor = l.id_autor;
