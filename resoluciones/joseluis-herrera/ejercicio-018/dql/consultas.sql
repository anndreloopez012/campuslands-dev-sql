SELECT
    id_medicamento,
    id_laboratorio,
    nombre,
    principio_activo,
    precio_venta,
    stock,
    fecha_vencimiento
FROM medicamentos;

SELECT
    nombre,
    stock
FROM medicamentos;

SELECT
    id_medicamento,
    nombre,
    stock,
    fecha_vencimiento
FROM medicamentos
WHERE stock < 100;

SELECT
    id_medicamento,
    nombre,
    precio_venta,
    fecha_vencimiento
FROM medicamentos
ORDER BY fecha_vencimiento ASC;

SELECT
    id_medicamento,
    nombre,
    stock
FROM medicamentos
ORDER BY stock DESC
LIMIT 5;

SELECT
    COUNT(*) AS total_medicamentos
FROM medicamentos;

SELECT
    AVG(precio_venta) AS precio_promedio,
    MIN(precio_venta) AS precio_minimo,
    MAX(precio_venta) AS precio_maximo
FROM medicamentos;

SELECT
    l.nombre AS laboratorio,
    COUNT(m.id_medicamento) AS cantidad_medicamentos
FROM laboratorios AS l
JOIN medicamentos AS m
    ON l.id_laboratorio = m.id_laboratorio
GROUP BY l.id_laboratorio, l.nombre
ORDER BY cantidad_medicamentos DESC;

SELECT
    m.nombre AS medicamento,
    l.nombre AS laboratorio,
    m.precio_venta,
    m.stock
FROM medicamentos AS m
JOIN laboratorios AS l
    ON m.id_laboratorio = l.id_laboratorio;

SELECT
    m.nombre AS medicamento,
    SUM(v.cantidad) AS unidades_vendidas
FROM medicamentos AS m
JOIN ventas AS v
    ON m.id_medicamento = v.id_medicamento
WHERE v.cantidad > 5
GROUP BY m.id_medicamento, m.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

SELECT
    m.nombre AS medicamento,
    COUNT(v.id_venta) AS cantidad_ventas,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * v.precio_unitario) AS ingresos
FROM medicamentos AS m
LEFT JOIN ventas AS v
    ON m.id_medicamento = v.id_medicamento
GROUP BY m.id_medicamento, m.nombre
ORDER BY ingresos DESC;

SELECT
    m.nombre AS medicamento,
    SUM(c.cantidad) AS unidades_compradas
FROM medicamentos AS m
JOIN compras AS c
    ON m.id_medicamento = c.id_medicamento
GROUP BY m.id_medicamento, m.nombre
ORDER BY unidades_compradas DESC;

SELECT
    m.nombre AS medicamento,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * v.precio_unitario) AS ingresos_generados
FROM medicamentos AS m
JOIN ventas AS v
    ON m.id_medicamento = v.id_medicamento
GROUP BY m.id_medicamento, m.nombre
HAVING SUM(v.cantidad) >= 15
ORDER BY unidades_vendidas DESC;

SELECT
    m.nombre AS medicamento,
    m.stock AS stock_actual,
    COALESCE(SUM(v.cantidad), 0) AS unidades_vendidas,
    CASE
        WHEN m.stock < 70 THEN 'Reponer inventario'
        WHEN COALESCE(SUM(v.cantidad), 0) >= 20 THEN 'Mantener seguimiento'
        ELSE 'Stock suficiente'
    END AS decision_inventario
FROM medicamentos AS m
LEFT JOIN ventas AS v
    ON m.id_medicamento = v.id_medicamento
GROUP BY m.id_medicamento, m.nombre, m.stock
ORDER BY
    CASE
        WHEN m.stock < 70 THEN 1
        WHEN COALESCE(SUM(v.cantidad), 0) >= 20 THEN 2
        ELSE 3
    END,
    m.stock ASC;