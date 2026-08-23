.headers on
.mode column

-- Ejercicio 59: DEFAULT Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM productos;

-- 2. Consulta con WHERE.
SELECT sku, nombre_producto, stock
FROM productos
WHERE estado = 'disponible';

-- 3. Consulta con ORDER BY.
SELECT sku, nombre_producto, fecha_registro
FROM productos
ORDER BY fecha_registro;

-- 4. Conteo o resumen: productos por estado.
SELECT estado, COUNT(*) AS total
FROM productos
GROUP BY estado
ORDER BY estado;

-- 5. Validacion especifica del tema DEFAULT: los productos que se
--    insertaron SIN indicar estado, stock, es_fragil ni fecha_registro
--    (LAP-002, MON-002, PER-001) igual quedaron con esos campos completos,
--    gracias a los valores por defecto.
SELECT
    sku,
    estado,
    stock,
    es_fragil,
    fecha_registro IS NOT NULL AS tiene_fecha_registro
FROM productos
WHERE sku IN ('LAP-002', 'MON-002', 'PER-001');
