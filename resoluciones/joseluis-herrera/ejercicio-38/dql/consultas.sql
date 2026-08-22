SELECT
    o.id_orden,
    c.nombre_completo AS comprador,
    GROUP_CONCAT(p.nombre) AS productos,
    cu.codigo AS cupon,
    pa.metodo_pago,
    o.direccion_envio,
    t.nombre AS transportadora,
    o.fecha_orden,
    o.estado AS estado_orden
FROM ordenes o
JOIN compradores c
    ON o.id_comprador = c.id_comprador
LEFT JOIN cupones cu
    ON o.id_cupon = cu.id_cupon
JOIN detalle_orden d
    ON o.id_orden = d.id_orden
JOIN productos p
    ON d.id_producto = p.id_producto
LEFT JOIN pagos pa
    ON o.id_orden = pa.id_orden
LEFT JOIN envios e
    ON o.id_orden = e.id_orden
LEFT JOIN transportadoras t
    ON e.id_transportadora = t.id_transportadora
GROUP BY
    o.id_orden,
    c.nombre_completo,
    cu.codigo,
    pa.metodo_pago,
    o.direccion_envio,
    t.nombre,
    o.fecha_orden,
    o.estado
ORDER BY o.id_orden;

SELECT DISTINCT
    id_comprador,
    nombre_completo,
    documento,
    email
FROM compradores
ORDER BY nombre_completo;

SELECT DISTINCT
    id_producto,
    nombre,
    categoria
FROM productos
ORDER BY nombre;

SELECT DISTINCT
    id_orden,
    fecha_orden,
    estado
FROM ordenes
ORDER BY fecha_orden;

SELECT
    estado,
    COUNT(*) AS cantidad_ordenes
FROM ordenes
GROUP BY estado
ORDER BY cantidad_ordenes DESC;

SELECT
    categoria,
    COUNT(*) AS cantidad_productos,
    ROUND(AVG(precio), 2) AS precio_promedio
FROM productos
GROUP BY categoria
ORDER BY cantidad_productos DESC;

SELECT
    o.id_orden,
    c.nombre_completo AS comprador,
    SUM(d.cantidad * d.precio_unitario) AS total_orden
FROM ordenes o
JOIN compradores c
    ON o.id_comprador = c.id_comprador
JOIN detalle_orden d
    ON o.id_orden = d.id_orden
GROUP BY o.id_orden, c.nombre_completo
ORDER BY total_orden DESC;

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM productos;

SELECT
    ROUND(AVG(monto), 2) AS pago_promedio,
    MIN(monto) AS pago_minimo,
    MAX(monto) AS pago_maximo
FROM pagos
WHERE estado = 'aprobado';

SELECT
    id_producto,
    nombre,
    categoria,
    precio
FROM productos
WHERE nombre LIKE '%Logitech%'
   OR nombre LIKE '%Samsung%'
ORDER BY nombre;

SELECT
    id_comprador,
    nombre_completo,
    email
FROM compradores
WHERE nombre_completo LIKE '%Lopez%'
   OR nombre_completo LIKE '%Carlos%'
ORDER BY nombre_completo;

SELECT
    id_orden,
    id_comprador,
    fecha_orden,
    estado
FROM ordenes
WHERE fecha_orden BETWEEN '2026-08-01' AND '2026-08-10'
ORDER BY fecha_orden;

SELECT
    id_producto,
    nombre,
    precio
FROM productos
WHERE precio BETWEEN 200 AND 2000
ORDER BY precio;

SELECT
    p.id_producto,
    p.nombre,
    SUM(d.cantidad) AS cantidad_vendida
FROM productos p
JOIN detalle_orden d
    ON p.id_producto = d.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;

SELECT
    o.id_orden,
    c.nombre_completo AS comprador,
    SUM(d.cantidad * d.precio_unitario) AS monto_total
FROM ordenes o
JOIN compradores c
    ON o.id_comprador = c.id_comprador
JOIN detalle_orden d
    ON o.id_orden = d.id_orden
GROUP BY o.id_orden, c.nombre_completo
ORDER BY monto_total DESC
LIMIT 5;

SELECT
    p.id_producto,
    p.nombre
FROM productos p
LEFT JOIN detalle_orden d
    ON p.id_producto = d.id_producto
WHERE d.id_detalle IS NULL
ORDER BY p.nombre;

SELECT
    o.id_orden,
    o.fecha_orden,
    c.nombre_completo AS comprador
FROM ordenes o
JOIN compradores c
    ON o.id_comprador = c.id_comprador
LEFT JOIN pagos p
    ON o.id_orden = p.id_orden
WHERE p.id_pago IS NULL
ORDER BY o.fecha_orden;

SELECT
    o.id_orden,
    o.fecha_orden,
    c.nombre_completo AS comprador,
    COALESCE(SUM(d.cantidad * d.precio_unitario), 0) AS total_orden,
    COALESCE(cu.codigo, 'Sin cupon') AS cupon,
    COALESCE(pa.metodo_pago, 'Sin pago') AS metodo_pago,
    COALESCE(e.estado, 'Sin envio') AS estado_envio,
    COALESCE(t.nombre, 'Sin transportadora') AS transportadora,
    o.estado AS estado_orden
FROM ordenes o
JOIN compradores c
    ON o.id_comprador = c.id_comprador
LEFT JOIN detalle_orden d
    ON o.id_orden = d.id_orden
LEFT JOIN cupones cu
    ON o.id_cupon = cu.id_cupon
LEFT JOIN pagos pa
    ON o.id_orden = pa.id_orden
LEFT JOIN envios e
    ON o.id_orden = e.id_orden
LEFT JOIN transportadoras t
    ON e.id_transportadora = t.id_transportadora
GROUP BY
    o.id_orden,
    o.fecha_orden,
    c.nombre_completo,
    cu.codigo,
    pa.metodo_pago,
    e.estado,
    t.nombre,
    o.estado
ORDER BY o.fecha_orden DESC;