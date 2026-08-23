-- Ejercicio 15: Taller de Motos
-- Entidad central: ordenes_servicio

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM ordenes_servicio;

-- 2. Mostrar solo dos columnas relevantes
SELECT estado, costo FROM ordenes_servicio;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM ordenes_servicio WHERE costo > 200;

-- 4. Ordenar resultados por fecha
SELECT * FROM ordenes_servicio ORDER BY fecha;

-- 5. Mostrar las 5 ordenes de mayor costo
SELECT * FROM ordenes_servicio ORDER BY costo DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_ordenes FROM ordenes_servicio;

-- 7. Promedio, minimo y maximo del costo
SELECT
    AVG(costo) AS promedio,
    MIN(costo) AS minimo,
    MAX(costo) AS maximo
FROM ordenes_servicio;

-- 8. Agrupar ordenes por estado
SELECT estado, COUNT(*) AS cantidad_ordenes
FROM ordenes_servicio
GROUP BY estado;

-- 9. Relacionar ordenes, motos y clientes con JOIN
SELECT o.id_orden, c.nombre AS cliente, m.placa AS moto
FROM ordenes_servicio o
JOIN motos m ON m.id_moto = o.id_moto
JOIN clientes c ON c.id_cliente = m.id_cliente;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM ordenes_servicio
WHERE estado = 'completado'
ORDER BY costo DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    m.placa AS moto,
    s.nombre AS servicio,
    o.estado AS estado_orden,
    o.costo AS costo_orden,
    o.fecha AS fecha_orden
FROM ordenes_servicio o
JOIN motos m ON m.id_moto = o.id_moto
JOIN clientes c ON c.id_cliente = m.id_cliente
JOIN servicios s ON s.id_servicio = o.id_servicio;

-- 12. Consulta para decision de negocio: servicio que genera mas ingresos totales
SELECT s.nombre, SUM(o.costo) AS total_generado
FROM ordenes_servicio o
JOIN servicios s ON s.id_servicio = o.id_servicio
GROUP BY s.nombre
ORDER BY total_generado DESC
LIMIT 1;
