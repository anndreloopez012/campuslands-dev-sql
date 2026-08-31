.headers on
.mode column

-- Ejercicio 83: WHERE Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT v.id_venta, c.nombre_cliente, p.nombre_producto, v.cantidad, v.fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. WHERE por texto: productos cuyo nombre empieza con "Ca"
-- (Cafe Americano, Cappuccino), usando LIKE con comodin.
SELECT nombre_producto, precio
FROM productos
WHERE nombre_producto LIKE 'Ca%';

-- 3. Consulta con ORDER BY: ventas ordenadas por fecha.
SELECT id_venta, fecha_venta
FROM ventas
ORDER BY fecha_venta;

-- 4. Conteo o resumen: ventas por categoria de producto.
SELECT p.categoria, COUNT(*) AS total_ventas
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto
GROUP BY p.categoria;

-- 5. Validacion especifica de WHERE: filtro por numero (BETWEEN),
-- por fecha (comparacion de texto en formato ISO) y con operadores
-- logicos combinados (AND, IN), todo en la misma consulta.
--    - precio BETWEEN 12 AND 18: solo productos de rango medio.
--    - fecha_venta >= '2026-08-02': solo ventas desde esa fecha.
--    - id_cliente IN (1, 2): solo esos dos clientes.
SELECT v.id_venta, c.nombre_cliente, p.nombre_producto, p.precio, v.fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto
WHERE p.precio BETWEEN 12 AND 18
  AND v.fecha_venta >= '2026-08-02'
  AND v.id_cliente IN (1, 2);

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: escribir mal el nombre de una columna en el WHERE
-- (typo: "preci" en vez de "precio").
-- SELECT * FROM productos WHERE preci > 15;
