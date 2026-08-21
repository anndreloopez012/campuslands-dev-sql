.headers on
.mode column

-- Ejercicio 65: ALTER TABLE Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (ya con las columnas nuevas).
SELECT id_producto, nombre, precio_unitario, categoria, disponible
FROM productos;

-- 2. Consulta con WHERE.
SELECT nombre, precio_unitario, categoria
FROM productos
WHERE disponible = 1;

-- 3. Consulta con ORDER BY.
SELECT nombre, precio_unitario
FROM productos
ORDER BY precio_unitario DESC;

-- 4. Conteo o resumen.
SELECT categoria, COUNT(*) AS total_productos
FROM productos
GROUP BY categoria;

-- 5. Validacion especifica de ALTER TABLE: los 3 productos creados
-- antes de las modificaciones conservaron su precio original (ahora en
-- la columna renombrada precio_unitario) y quedaron con categoria y
-- disponible generados por el DEFAULT del ALTER TABLE.
SELECT nombre, precio_unitario, categoria, disponible
FROM productos
WHERE nombre IN ('Cafe Americano', 'Capuchino', 'Pastel de Chocolate');
