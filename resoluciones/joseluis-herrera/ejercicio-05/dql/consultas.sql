SELECT
    id_bicicleta,
    id_marca,
    id_proveedor,
    modelo,
    tipo,
    precio,
    stock_actual
FROM bicicletas;

SELECT
    modelo,
    stock_actual
FROM bicicletas;

SELECT
    id_bicicleta,
    modelo,
    precio,
    stock_actual
FROM bicicletas
WHERE precio >= 900;

SELECT
    id_bicicleta,
    modelo,
    precio,
    stock_actual
FROM bicicletas
ORDER BY modelo ASC;

SELECT
    b.modelo,
    SUM(m.cantidad) AS total_movimientos
FROM bicicletas AS b
JOIN movimientos_inventario AS m
    ON b.id_bicicleta = m.id_bicicleta
GROUP BY b.id_bicicleta, b.modelo
ORDER BY total_movimientos DESC
LIMIT 5;

SELECT COUNT(*) AS total_bicicletas
FROM bicicletas;

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM bicicletas;

SELECT
    tipo,
    COUNT(*) AS cantidad_bicicletas,
    ROUND(AVG(precio), 2) AS precio_promedio
FROM bicicletas
GROUP BY tipo;

SELECT
    b.modelo,
    ma.nombre AS marca,
    p.nombre_empresa AS proveedor,
    b.precio,
    b.stock_actual
FROM bicicletas AS b
JOIN marcas AS ma
    ON b.id_marca = ma.id_marca
JOIN proveedores AS p
    ON b.id_proveedor = p.id_proveedor;

SELECT
    id_bicicleta,
    modelo,
    stock_actual,
    precio
FROM bicicletas
WHERE stock_actual > 5
ORDER BY stock_actual DESC
LIMIT 5;

SELECT
    m.id_movimiento AS "Movimiento",
    b.modelo AS "Bicicleta",
    m.tipo_movimiento AS "Tipo",
    m.cantidad AS "Cantidad",
    m.fecha_movimiento AS "Fecha"
FROM movimientos_inventario AS m
JOIN bicicletas AS b
    ON m.id_bicicleta = b.id_bicicleta
ORDER BY m.fecha_movimiento;

SELECT
    b.modelo AS bicicleta,
    b.stock_actual AS stock,
    COALESCE(SUM(
        CASE
            WHEN m.tipo_movimiento = 'ENTRADA' THEN m.cantidad
            ELSE 0
        END
    ), 0) AS entradas,
    COALESCE(SUM(
        CASE
            WHEN m.tipo_movimiento = 'SALIDA' THEN m.cantidad
            ELSE 0
        END
    ), 0) AS salidas,
    CASE
        WHEN b.stock_actual <= 5 THEN 'REABASTECER'
        WHEN b.stock_actual <= 10 THEN 'VIGILAR STOCK'
        ELSE 'STOCK ADECUADO'
    END AS decision
FROM bicicletas AS b
LEFT JOIN movimientos_inventario AS m
    ON b.id_bicicleta = m.id_bicicleta
GROUP BY b.id_bicicleta, b.modelo, b.stock_actual
ORDER BY b.stock_actual ASC;