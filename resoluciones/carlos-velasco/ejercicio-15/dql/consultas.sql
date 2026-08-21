PRAGMA foreign_keys = ON;

-- 1. Listar todos los registros principales de la entidad central

SELECT
    o.id_orden,
    o.id_moto,
    o.id_servicio,
    o.fecha_servicio,
    o.kilometraje,
    o.estado,
    o.precio_final,
    o.observaciones
FROM ordenes_servicio AS o;

-- 2. Mostrar solo dos columnas relevantes de la entidad central

SELECT
    fecha_servicio,
    estado
FROM ordenes_servicio;

-- 3. Filtrar registros por una condicion numerica o de fecha

SELECT
    id_orden,
    id_moto,
    fecha_servicio,
    kilometraje,
    estado
FROM ordenes_servicio
WHERE kilometraje >= 20000;

-- 4. Ordenar resultados por fecha

SELECT
    id_orden,
    fecha_servicio,
    estado,
    precio_final
FROM ordenes_servicio
ORDER BY fecha_servicio ASC;

-- 5. Mostrar los 5 registros mas importantes segun precio

SELECT
    id_orden,
    id_moto,
    id_servicio,
    precio_final,
    estado
FROM ordenes_servicio
ORDER BY precio_final DESC
LIMIT 5;

-- 6. Contar registros totales

SELECT
    COUNT(*) AS total_ordenes
FROM ordenes_servicio;

-- 7. Calcular promedio, minimo y maximo del precio

SELECT
    ROUND(AVG(precio_final), 2) AS precio_promedio,
    MIN(precio_final) AS precio_minimo,
    MAX(precio_final) AS precio_maximo
FROM ordenes_servicio;

-- 8. Agrupar registros con GROUP BY

SELECT
    estado,
    COUNT(*) AS cantidad_ordenes
FROM ordenes_servicio
GROUP BY estado
ORDER BY cantidad_ordenes DESC;

-- 9. Relacionar minimo dos tablas con JOIN

SELECT
    o.id_orden,
    c.nombre_completo AS cliente,
    m.placa,
    m.marca,
    m.modelo,
    s.nombre AS servicio,
    o.fecha_servicio,
    o.precio_final
FROM ordenes_servicio AS o
INNER JOIN motos AS m
    ON o.id_moto = m.id_moto
INNER JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
INNER JOIN servicios AS s
    ON o.id_servicio = s.id_servicio;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    o.id_orden,
    o.fecha_servicio,
    o.estado,
    o.precio_final
FROM ordenes_servicio AS o
WHERE o.precio_final >= 250
ORDER BY o.precio_final DESC
LIMIT 5;

-- 11. Reporte con alias legibles

SELECT
    o.id_orden AS 'Numero de orden',
    c.nombre_completo AS 'Cliente',
    m.placa AS 'Placa',
    s.nombre AS 'Servicio realizado',
    o.fecha_servicio AS 'Fecha del servicio',
    o.estado AS 'Estado',
    o.precio_final AS 'Precio final'
FROM ordenes_servicio AS o
INNER JOIN motos AS m
    ON o.id_moto = m.id_moto
INNER JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
INNER JOIN servicios AS s
    ON o.id_servicio = s.id_servicio
ORDER BY o.fecha_servicio;

-- 12. Consulta para apoyar una decision del negocio

SELECT
    s.nombre AS servicio,
    COUNT(o.id_orden) AS cantidad_realizada,
    ROUND(SUM(o.precio_final), 2) AS ingresos_generados,
    CASE
        WHEN COUNT(o.id_orden) >= 2 THEN 'Priorizar inventario y capacidad'
        ELSE 'Monitorear demanda'
    END AS recomendacion
FROM servicios AS s
LEFT JOIN ordenes_servicio AS o
    ON s.id_servicio = o.id_servicio
GROUP BY s.id_servicio, s.nombre
ORDER BY cantidad_realizada DESC, ingresos_generados DESC;