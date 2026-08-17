-- Ejercicio 05: Inventario de Bicicletas
-- Entidad central: movimientos_inventario

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM movimientos_inventario;

-- 2. Mostrar solo dos columnas relevantes
SELECT tipo_movimiento, cantidad FROM movimientos_inventario;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM movimientos_inventario WHERE fecha_movimiento >= '2026-07-10';

-- 4. Ordenar resultados por fecha
SELECT * FROM movimientos_inventario ORDER BY fecha_movimiento;

-- 5. Mostrar los 5 movimientos con mayor cantidad
SELECT * FROM movimientos_inventario ORDER BY cantidad DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_movimientos FROM movimientos_inventario;

-- 7. Promedio, minimo y maximo de cantidad movida
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM movimientos_inventario;

-- 8. Agrupar movimientos por tipo
SELECT tipo_movimiento, COUNT(*) AS cantidad_movimientos
FROM movimientos_inventario
GROUP BY tipo_movimiento;

-- 9. Relacionar movimientos, bicicletas y proveedores con JOIN
SELECT m.id_movimiento, b.modelo, pr.nombre AS proveedor
FROM movimientos_inventario m
JOIN bicicletas b ON b.id_bicicleta = m.id_bicicleta
JOIN proveedores pr ON pr.id_proveedor = m.id_proveedor;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM movimientos_inventario
WHERE tipo_movimiento = 'entrada'
ORDER BY cantidad DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    b.modelo AS bicicleta,
    pr.nombre AS proveedor,
    m.tipo_movimiento AS tipo,
    m.cantidad AS unidades,
    m.fecha_movimiento AS fecha
FROM movimientos_inventario m
JOIN bicicletas b ON b.id_bicicleta = m.id_bicicleta
JOIN proveedores pr ON pr.id_proveedor = m.id_proveedor;

-- 12. Consulta para decision de negocio: bicicleta con mas salidas (mas vendida)
SELECT b.modelo, SUM(m.cantidad) AS unidades_vendidas
FROM movimientos_inventario m
JOIN bicicletas b ON b.id_bicicleta = m.id_bicicleta
WHERE m.tipo_movimiento = 'salida'
GROUP BY b.modelo
ORDER BY unidades_vendidas DESC
LIMIT 1;
