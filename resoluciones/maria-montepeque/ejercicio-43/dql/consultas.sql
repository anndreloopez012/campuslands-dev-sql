.headers on
.mode column

-- Ejercicio 43: Tipos de datos Nivel Aplicado
-- Consultas de validacion y reporte final.

-- 1. Mostrar todos los datos principales.
SELECT * FROM ventas;

-- 2. Consulta con WHERE (filtra por el BOOLEAN simulado: ventas pagadas con tarjeta).
SELECT id_venta, id_producto, cantidad, precio_unitario, fecha_venta
FROM ventas
WHERE pagado_tarjeta = 1;

-- 3. Consulta con ORDER BY (DATE simulado + TIME simulado ordenan como texto correctamente).
SELECT fecha_venta, hora_venta, id_producto, cantidad
FROM ventas
ORDER BY fecha_venta, hora_venta;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_ventas,
    SUM(cantidad) AS unidades_vendidas,
    ROUND(SUM(cantidad * precio_unitario), 2) AS ingresos_totales,
    SUM(pagado_tarjeta) AS ventas_con_tarjeta
FROM ventas;

-- 5. Validacion especifica del tema Tipos de datos:
--    a) REAL permite calcular ingresos con decimales exactos (cantidad
--       INTEGER * precio_unitario REAL).
SELECT
    p.nombre AS producto,
    SUM(v.cantidad) AS unidades,
    ROUND(SUM(v.cantidad * v.precio_unitario), 2) AS ingresos
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto
GROUP BY p.nombre
ORDER BY ingresos DESC;

--    b) DATE simulado agrupa correctamente por dia (texto ISO = fecha real).
SELECT
    fecha_venta,
    COUNT(*) AS ventas_del_dia,
    ROUND(SUM(cantidad * precio_unitario), 2) AS ingresos_del_dia
FROM ventas
GROUP BY fecha_venta
ORDER BY fecha_venta;

-- Reporte final de negocio: ventas por cliente registrado, incluyendo las
-- de mostrador (id_cliente NULL) agrupadas como "Cliente no registrado" con
-- COALESCE, y el BOOLEAN simulado 'frecuente' del catalogo de clientes.
SELECT
    COALESCE(c.nombre, 'Cliente no registrado') AS cliente,
    COALESCE(c.frecuente, 0) AS es_frecuente,
    COUNT(*) AS cantidad_compras,
    ROUND(SUM(v.cantidad * v.precio_unitario), 2) AS total_gastado
FROM ventas v
LEFT JOIN clientes c ON c.id_cliente = v.id_cliente
GROUP BY cliente
ORDER BY total_gastado DESC;
