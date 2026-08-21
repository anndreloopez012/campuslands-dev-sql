-- Ejercicio 21: Logistica Envios
-- Entidad central: envios

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM envios;

-- 2. Mostrar solo dos columnas relevantes
SELECT estado, costo FROM envios;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM envios WHERE costo > 100;

-- 4. Ordenar resultados por fecha
SELECT * FROM envios ORDER BY fecha_envio;

-- 5. Mostrar los 5 envios de mayor costo
SELECT * FROM envios ORDER BY costo DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_envios FROM envios;

-- 7. Promedio, minimo y maximo del costo de envio
SELECT
    AVG(costo) AS promedio,
    MIN(costo) AS minimo,
    MAX(costo) AS maximo
FROM envios;

-- 8. Agrupar envios por estado
SELECT estado, COUNT(*) AS cantidad_envios
FROM envios
GROUP BY estado;

-- 9. Relacionar envios, paquetes y clientes con JOIN
SELECT e.id_envio, c.nombre AS cliente, p.descripcion AS paquete
FROM envios e
JOIN paquetes p ON p.id_paquete = e.id_paquete
JOIN clientes c ON c.id_cliente = p.id_cliente;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM envios
WHERE estado = 'entregado'
ORDER BY costo DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    p.descripcion AS paquete,
    r.origen AS origen,
    r.destino AS destino,
    e.estado AS estado_envio,
    e.costo AS costo_envio,
    e.fecha_envio AS fecha_envio
FROM envios e
JOIN paquetes p ON p.id_paquete = e.id_paquete
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN rutas r ON r.id_ruta = e.id_ruta;

-- 12. Consulta para decision de negocio: ruta con mayores ingresos por envios entregados
SELECT r.origen, r.destino, SUM(e.costo) AS total_ingresos
FROM envios e
JOIN rutas r ON r.id_ruta = e.id_ruta
WHERE e.estado = 'entregado'
GROUP BY r.id_ruta
ORDER BY total_ingresos DESC
LIMIT 1;
