.headers on
.mode column

-- Ejercicio 86: ORDER BY Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_prestamo, l.titulo, a.nombre_autor, p.nombre_prestatario, p.fecha_prestamo
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN autores a ON a.id_autor = l.id_autor;

-- 2. Consulta con WHERE: solo los prestamos activos.
SELECT id_prestamo, id_libro, nombre_prestatario
FROM prestamos
WHERE fecha_devolucion IS NULL;

-- 3. Consulta con ORDER BY ascendente (por defecto): libros
-- ordenados por cantidad de ejemplares, de menor a mayor.
SELECT titulo, ejemplares_totales
FROM libros
ORDER BY ejemplares_totales;

-- 4. Conteo o resumen: total de libros por categoria.
SELECT categoria, COUNT(*) AS total_libros
FROM libros
GROUP BY categoria;

-- 5. Validacion especifica de ORDER BY: orden descendente
-- (`DESC`) y orden por varias columnas a la vez. Primero se agrupan
-- los libros por categoria (ascendente, orden alfabetico por
-- defecto) y, dentro de cada categoria, se ordenan por cantidad de
-- ejemplares de mayor a menor (DESC). Esto demuestra que ORDER BY
-- puede combinar mas de una columna, cada una con su propia
-- direccion.
SELECT titulo, categoria, ejemplares_totales
FROM libros
ORDER BY categoria ASC, ejemplares_totales DESC;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: ordenar por la posicion de una columna que no existe en
-- el resultado (la consulta solo tiene 2 columnas, no 5). Ordenar por
-- posicion numerica en vez de por nombre es fragil: si el SELECT
-- cambia de orden, el ORDER BY termina apuntando a otra columna sin
-- avisar.
-- SELECT titulo, categoria FROM libros ORDER BY 5;
