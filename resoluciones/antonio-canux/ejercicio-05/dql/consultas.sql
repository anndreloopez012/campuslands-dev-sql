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