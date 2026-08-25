SELECT
    id_orden,
    id_moto,
    id_servicio,
    fecha,
    kilometraje,
    costo,
    estado
FROM ordenes_servicio;

SELECT
    id_orden,
    costo
FROM ordenes_servicio;

SELECT
    id_orden,
    fecha,
    kilometraje,
    costo
FROM ordenes_servicio
WHERE kilometraje >= 15000;

SELECT
    id_orden,
    fecha,
    estado
FROM ordenes_servicio
ORDER BY fecha DESC;

SELECT
    id_orden,
    costo
FROM ordenes_servicio
ORDER BY costo DESC
LIMIT 5;

SELECT COUNT(*) AS total_ordenes_servicio
FROM ordenes_servicio;

SELECT
    AVG(costo) AS costo_promedio,
    MIN(costo) AS costo_minimo,
    MAX(costo) AS costo_maximo
FROM ordenes_servicio;

SELECT
    estado,
    COUNT(*) AS cantidad_ordenes
FROM ordenes_servicio
GROUP BY estado;

SELECT
    o.id_orden,
    c.nombre AS cliente,
    m.placa,
    m.marca,
    m.modelo,
    s.nombre AS servicio,
    o.fecha,
    o.costo,
    o.estado
FROM ordenes_servicio AS o
JOIN motos AS m
    ON o.id_moto = m.id_moto
JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
JOIN servicios AS s
    ON o.id_servicio = s.id_servicio;

SELECT
    o.id_orden,
    c.nombre AS cliente,
    s.nombre AS servicio,
    o.costo
FROM ordenes_servicio AS o
JOIN motos AS m
    ON o.id_moto = m.id_moto
JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
JOIN servicios AS s
    ON o.id_servicio = s.id_servicio
WHERE o.estado = 'finalizada'
ORDER BY o.costo DESC
LIMIT 5;

SELECT
    s.nombre AS servicio,
    COUNT(o.id_orden) AS servicios_realizados,
    SUM(o.costo) AS ingresos_generados
FROM servicios AS s
JOIN ordenes_servicio AS o
    ON s.id_servicio = o.id_servicio
GROUP BY s.id_servicio, s.nombre
ORDER BY ingresos_generados DESC;

SELECT
    c.nombre AS cliente,
    COUNT(o.id_orden) AS total_servicios,
    SUM(o.costo) AS gasto_total
FROM clientes AS c
JOIN motos AS m
    ON c.id_cliente = m.id_cliente
JOIN ordenes_servicio AS o
    ON m.id_moto = o.id_moto
GROUP BY c.id_cliente, c.nombre
ORDER BY gasto_total DESC;

SELECT
    m.placa,
    m.marca,
    m.modelo,
    m.anio,
    MAX(o.kilometraje) AS ultimo_kilometraje,
    CASE
        WHEN MAX(o.kilometraje) >= 20000 THEN 'Requiere revision prioritaria'
        WHEN MAX(o.kilometraje) >= 15000 THEN 'Programar mantenimiento'
        ELSE 'Mantenimiento regular'
    END AS recomendacion
FROM motos AS m
JOIN ordenes_servicio AS o
    ON m.id_moto = o.id_moto
GROUP BY m.id_moto, m.placa, m.marca, m.modelo, m.anio
ORDER BY ultimo_kilometraje DESC;