PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. Listar todos los registros principales
-- Entidad central: movimientos_inventario
-- =========================================================

SELECT
    id_movimiento,
    id_bicicleta,
    id_proveedor,
    tipo_movimiento,
    cantidad,
    fecha_movimiento,
    observacion
FROM movimientos_inventario;

-- =========================================================
-- 2. Mostrar solo dos columnas relevantes
-- =========================================================

SELECT
    modelo,
    precio
FROM bicicletas;

-- =========================================================
-- 3. Filtrar por condición numérica
-- Bicicletas cuyo precio supera los 900.
-- =========================================================

SELECT
    id_bicicleta,
    codigo,
    modelo,
    precio
FROM bicicletas
WHERE precio > 900;

-- =========================================================
-- 4. Ordenar resultados alfabéticamente
-- =========================================================

SELECT
    id_bicicleta,
    modelo,
    categoria,
    precio
FROM bicicletas
ORDER BY modelo ASC;

-- =========================================================
-- 5. Top 5 bicicletas según unidades movidas
-- =========================================================

SELECT
    b.modelo,
    SUM(mi.cantidad) AS unidades_movidas
FROM bicicletas AS b
INNER JOIN movimientos_inventario AS mi
    ON b.id_bicicleta = mi.id_bicicleta
GROUP BY
    b.id_bicicleta,
    b.modelo
ORDER BY unidades_movidas DESC
LIMIT 5;

-- =========================================================
-- 6. Contar registros totales
-- =========================================================

SELECT
    COUNT(*) AS total_movimientos
FROM movimientos_inventario;

-- =========================================================
-- 7. Promedio, mínimo y máximo del precio
-- =========================================================

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM bicicletas;

-- =========================================================
-- 8. Agrupar movimientos por tipo
-- =========================================================

SELECT
    tipo_movimiento,
    COUNT(*) AS cantidad_movimientos,
    SUM(cantidad) AS unidades
FROM movimientos_inventario
GROUP BY tipo_movimiento;

-- =========================================================
-- 9. JOIN entre bicicletas y marcas
-- =========================================================

SELECT
    b.id_bicicleta,
    b.modelo,
    m.nombre AS marca,
    b.categoria,
    b.precio
FROM bicicletas AS b
INNER JOIN marcas AS m
    ON b.id_marca = m.id_marca;

-- =========================================================
-- 10. WHERE + ORDER BY + LIMIT
-- Últimas salidas registradas.
-- =========================================================

SELECT
    id_movimiento,
    id_bicicleta,
    cantidad,
    fecha_movimiento
FROM movimientos_inventario
WHERE tipo_movimiento = 'SALIDA'
ORDER BY fecha_movimiento DESC
LIMIT 5;

-- =========================================================
-- 11. Reporte con alias legibles
-- =========================================================

SELECT
    mi.id_movimiento AS 'ID Movimiento',
    b.modelo AS 'Bicicleta',
    m.nombre AS 'Marca',
    pr.nombre AS 'Proveedor',
    mi.tipo_movimiento AS 'Tipo Movimiento',
    mi.cantidad AS 'Cantidad',
    mi.fecha_movimiento AS 'Fecha Movimiento'
FROM movimientos_inventario AS mi
INNER JOIN bicicletas AS b
    ON mi.id_bicicleta = b.id_bicicleta
INNER JOIN marcas AS m
    ON b.id_marca = m.id_marca
INNER JOIN proveedores AS pr
    ON mi.id_proveedor = pr.id_proveedor
ORDER BY mi.fecha_movimiento DESC;

-- =========================================================
-- 12. Consulta para apoyar una decisión de negocio
-- Calcular existencia estimada por bicicleta y clasificar
-- el nivel de inventario.
-- =========================================================

SELECT
    b.modelo AS 'Bicicleta',
    COALESCE(
        SUM(
            CASE
                WHEN mi.tipo_movimiento = 'ENTRADA'
                    THEN mi.cantidad
                WHEN mi.tipo_movimiento = 'SALIDA'
                    THEN -mi.cantidad
            END
        ),
        0
    ) AS 'Existencia Actual',
    CASE
        WHEN COALESCE(
            SUM(
                CASE
                    WHEN mi.tipo_movimiento = 'ENTRADA'
                        THEN mi.cantidad
                    WHEN mi.tipo_movimiento = 'SALIDA'
                        THEN -mi.cantidad
                END
            ),
            0
        ) <= 2
            THEN 'Generar reposicion'
        WHEN COALESCE(
            SUM(
                CASE
                    WHEN mi.tipo_movimiento = 'ENTRADA'
                        THEN mi.cantidad
                    WHEN mi.tipo_movimiento = 'SALIDA'
                        THEN -mi.cantidad
                END
            ),
            0
        ) <= 5
            THEN 'Monitorear inventario'
        ELSE 'Stock suficiente'
    END AS 'Decision'
FROM bicicletas AS b
LEFT JOIN movimientos_inventario AS mi
    ON b.id_bicicleta = mi.id_bicicleta
GROUP BY
    b.id_bicicleta,
    b.modelo
ORDER BY
    [Existencia Actual] ASC;