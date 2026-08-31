.headers on
.mode column

-- Ejercicio 95: JOIN Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales: INNER JOIN productos con su categoria.
SELECT p.id_producto, p.nombre_producto, c.nombre_categoria, p.precio_unitario
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria;

-- 2. Consulta con WHERE: solo los productos con precio mayor a 300.
SELECT id_producto, nombre_producto, precio_unitario
FROM productos
WHERE precio_unitario > 300;

-- 3. Consulta con ORDER BY: productos ordenados por precio, del mas caro al mas barato.
SELECT id_producto, nombre_producto, precio_unitario
FROM productos
ORDER BY precio_unitario DESC;

-- 4. Conteo o resumen: total de productos por categoria.
SELECT id_categoria, COUNT(*) AS total_productos
FROM productos
GROUP BY id_categoria;

-- 5. Validacion especifica de JOIN: LEFT JOIN de categorias hacia
-- productos, para listar TODAS las categorias, incluso las que
-- todavia no tienen ningun producto registrado (como "Redes"). Con
-- INNER JOIN (consulta 1) esa categoria no aparece porque no hay fila
-- de productos que combine con ella; con LEFT JOIN si aparece, con
-- las columnas de productos en NULL.
SELECT c.nombre_categoria, p.nombre_producto, p.precio_unitario
FROM categorias c
LEFT JOIN productos p ON p.id_categoria = c.id_categoria
ORDER BY c.nombre_categoria;

-- Caso comentado que no es recomendable, dejar comentado: JOIN
-- implicito (estilo antiguo, con coma) sin condicion de union. Al no
-- indicar "ON p.id_categoria = c.id_categoria" (ni un WHERE
-- equivalente), SQLite no lanza error, pero genera un producto
-- cartesiano: cada producto se combina con TODAS las categorias, sin
-- importar si de verdad pertenece a ellas. Se verifico con Python
-- (sqlite3) que esta consulta devuelve 20 filas (5 productos x 4
-- categorias) en vez de las 5 filas correctas de la consulta 1.
-- SELECT p.nombre_producto, c.nombre_categoria
-- FROM productos p, categorias c;
