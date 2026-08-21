PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS ENVIOS

SELECT
    id_envio,
    id_paquete,
    id_ruta,
    fecha_envio,
    fecha_entrega,
    estado,
    costo
FROM envios;

-- 2. DOS COLUMNAS RELEVANTES DE ENVIOS

SELECT
    id_envio,
    estado
FROM envios;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_envio,
    costo,
    estado
FROM envios
WHERE costo > 70;

-- 4. ORDENAR POR FECHA

SELECT
    id_envio,
    fecha_envio,
    estado
FROM envios
ORDER BY fecha_envio DESC;

-- 5. CINCO ENVIOS CON MAYOR COSTO

SELECT
    id_envio,
    id_paquete,
    costo
FROM envios
ORDER BY costo DESC
LIMIT 5;

-- 6. CONTAR ENVIOS

SELECT
    COUNT(*) AS total_envios
FROM envios;

-- 7. PROMEDIO, MINIMO Y MAXIMO DEL COSTO

SELECT
    ROUND(AVG(costo), 2) AS costo_promedio,
    MIN(costo) AS costo_minimo,
    MAX(costo) AS costo_maximo
FROM envios;

-- 8. AGRUPAR ENVIOS POR ESTADO

SELECT
    estado,
    COUNT(*) AS cantidad_envios
FROM envios
GROUP BY estado
ORDER BY cantidad_envios DESC;

-- 9. RELACIONAR CLIENTES, PAQUETES Y ENVIOS

SELECT
    c.nombre_completo,
    p.id_paquete,
    e.id_envio,
    e.estado
FROM clientes AS c
INNER JOIN paquetes AS p
    ON p.id_cliente = c.id_cliente
INNER JOIN envios AS e
    ON e.id_paquete = p.id_paquete
ORDER BY c.nombre_completo, e.id_envio;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_envio,
    fecha_envio,
    costo,
    estado
FROM envios
WHERE estado IN ('PENDIENTE', 'EN_TRANSITO')
ORDER BY costo DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    e.id_envio AS "Numero de envio",
    c.nombre_completo AS "Cliente",
    r.origen AS "Origen",
    r.destino AS "Destino",
    e.fecha_envio AS "Fecha de envio",
    e.estado AS "Estado",
    e.costo AS "Costo del envio"
FROM envios AS e
INNER JOIN paquetes AS p
    ON p.id_paquete = e.id_paquete
INNER JOIN clientes AS c
    ON c.id_cliente = p.id_cliente
INNER JOIN rutas AS r
    ON r.id_ruta = e.id_ruta
ORDER BY e.fecha_envio;

-- 12. DECISION DE NEGOCIO: RUTAS CON MAYOR DEMANDA

SELECT
    r.id_ruta,
    r.origen,
    r.destino,
    COUNT(e.id_envio) AS cantidad_envios,
    ROUND(AVG(e.costo), 2) AS costo_promedio
FROM rutas AS r
LEFT JOIN envios AS e
    ON e.id_ruta = r.id_ruta
GROUP BY
    r.id_ruta,
    r.origen,
    r.destino
HAVING COUNT(e.id_envio) > 0
ORDER BY cantidad_envios DESC, costo_promedio DESC;