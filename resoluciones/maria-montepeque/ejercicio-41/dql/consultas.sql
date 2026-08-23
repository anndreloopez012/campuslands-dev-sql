.headers on
.mode column

-- Ejercicio 41: Tipos de datos Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM productos;

-- 2. Consulta con WHERE (filtra por el BOOLEAN simulado: solo productos activos).
SELECT nombre, precio, stock
FROM productos
WHERE activo = 1;

-- 3. Consulta con ORDER BY (aprovecha que REAL ordena numericamente y TEXT alfabeticamente).
SELECT nombre, precio
FROM productos
ORDER BY precio DESC;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_productos,
    SUM(activo) AS productos_activos,
    ROUND(AVG(precio), 2) AS precio_promedio
FROM productos;

-- 5. Validacion especifica del tema Tipos de datos:
--    a) el DATE simulado (TEXT ISO) ordena correctamente como fecha real
--       usando comparadores de texto ('>=' funciona igual que con DATE).
SELECT id_movimiento, tipo, cantidad, fecha_movimiento
FROM movimientos
WHERE fecha_movimiento >= '2026-07-10'
ORDER BY fecha_movimiento;

--    b) el BOOLEAN simulado permite sumar directamente (SUM(activo)) porque
--       sigue siendo un INTEGER 0/1 por debajo, algo que un TEXT 'si'/'no'
--       no permitiria sin conversion.
SELECT
    (SELECT COUNT(*) FROM productos WHERE activo = 1) AS activos,
    (SELECT COUNT(*) FROM productos WHERE activo = 0) AS inactivos;
