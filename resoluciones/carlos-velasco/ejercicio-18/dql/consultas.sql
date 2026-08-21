.headers on
.mode column

-- 1. LISTADO DE MEDICAMENTOS

SELECT
    id_medicamento,
    id_laboratorio,
    nombre,
    principio_activo,
    precio_venta,
    stock,
    fecha_vencimiento
FROM medicamentos;

-- 2. DOS COLUMNAS RELEVANTES

SELECT
    nombre,
    stock
FROM medicamentos;

-- 3. FILTRO POR CONDICION NUMERICA

SELECT
    nombre,
    stock,
    precio_venta
FROM medicamentos
WHERE stock < 70;

-- 4. ORDENAMIENTO

SELECT
    nombre,
    precio_venta
FROM medicamentos
ORDER BY nombre ASC;

-- 5. CINCO MEDICAMENTOS CON MAYOR STOCK

SELECT
    nombre,
    stock
FROM medicamentos
ORDER BY stock DESC
LIMIT 5;

-- 6. TOTAL DE MEDICAMENTOS

SELECT COUNT(*) AS total_medicamentos
FROM medicamentos;

-- 7. PRECIO PROMEDIO, MINIMO Y MAXIMO

SELECT
    ROUND(AVG(precio_venta), 2) AS precio_promedio,
    MIN(precio_venta) AS precio_minimo,
    MAX(precio_venta) AS precio_maximo
FROM medicamentos;

-- 8. AGRUPACION POR LABORATORIO

SELECT
    l.nombre AS laboratorio,
    COUNT(m.id_medicamento) AS total_medicamentos
FROM laboratorios AS l
LEFT JOIN medicamentos AS m
    ON m.id_laboratorio = l.id_laboratorio
GROUP BY l.id_laboratorio, l.nombre
ORDER BY total_medicamentos DESC;

-- 9. RELACION ENTRE MEDICAMENTOS Y LABORATORIOS

SELECT
    m.nombre AS medicamento,
    l.nombre AS laboratorio,
    m.principio_activo
FROM medicamentos AS m
INNER JOIN laboratorios AS l
    ON l.id_laboratorio = m.id_laboratorio
ORDER BY l.nombre, m.nombre;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    nombre,
    stock,
    precio_venta
FROM medicamentos
WHERE stock >= 60
ORDER BY stock DESC
LIMIT 5;

-- 11. REPORTE DE VENTAS

SELECT
    v.id_venta AS venta,
    m.nombre AS medicamento,
    v.fecha_venta AS fecha,
    v.cantidad AS unidades,
    v.precio_unitario AS precio_unitario,
    ROUND(v.cantidad * v.precio_unitario, 2) AS total_venta,
    v.cliente AS cliente
FROM ventas AS v
INNER JOIN medicamentos AS m
    ON m.id_medicamento = v.id_medicamento
ORDER BY v.fecha_venta;

-- 12. DECISION DE NEGOCIO: MEDICAMENTOS CON STOCK BAJO

SELECT
    m.nombre AS medicamento,
    l.nombre AS laboratorio,
    m.stock AS stock_actual,
    CASE
        WHEN m.stock < 50 THEN 'REABASTECER URGENTE'
        WHEN m.stock < 70 THEN 'PROGRAMAR COMPRA'
        ELSE 'STOCK SUFICIENTE'
    END AS decision
FROM medicamentos AS m
INNER JOIN laboratorios AS l
    ON l.id_laboratorio = m.id_laboratorio
WHERE m.stock < 70
ORDER BY m.stock ASC;

-- REPORTE DE INGRESOS POR MEDICAMENTO

SELECT
    m.nombre AS medicamento,
    SUM(v.cantidad) AS unidades_vendidas,
    ROUND(SUM(v.cantidad * v.precio_unitario), 2) AS ingresos_generados
FROM ventas AS v
INNER JOIN medicamentos AS m
    ON m.id_medicamento = v.id_medicamento
GROUP BY m.id_medicamento, m.nombre
ORDER BY ingresos_generados DESC;