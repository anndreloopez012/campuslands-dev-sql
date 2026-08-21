PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS BOLETOS

SELECT *
FROM boletos;

-- 2. DOS COLUMNAS RELEVANTES DE LA ENTIDAD CENTRAL

SELECT id_boleto, precio
FROM boletos;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT id_boleto, tipo, precio
FROM boletos
WHERE precio >= 300;

-- 4. ORDENAR POR FECHA

SELECT id_boleto, id_evento, fecha_compra
FROM boletos
ORDER BY fecha_compra DESC;

-- 5. CINCO BOLETOS DE MAYOR VALOR

SELECT id_boleto, id_evento, id_asistente, precio
FROM boletos
ORDER BY precio DESC
LIMIT 5;

-- 6. CONTAR BOLETOS TOTALES

SELECT COUNT(*) AS total_boletos
FROM boletos;

-- 7. PROMEDIO, MINIMO Y MAXIMO DEL PRECIO

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM boletos;

-- 8. AGRUPAR BOLETOS POR TIPO

SELECT
    tipo,
    COUNT(*) AS cantidad_boletos,
    ROUND(AVG(precio), 2) AS precio_promedio
FROM boletos
GROUP BY tipo
ORDER BY cantidad_boletos DESC;

-- 9. RELACIONAR BOLETOS CON EVENTOS Y ASISTENTES

SELECT
    b.id_boleto,
    e.nombre AS evento,
    a.nombre_completo AS asistente,
    b.tipo,
    b.precio
FROM boletos AS b
INNER JOIN eventos AS e
    ON e.id_evento = b.id_evento
INNER JOIN asistentes AS a
    ON a.id_asistente = b.id_asistente;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    id_boleto,
    id_evento,
    tipo,
    precio
FROM boletos
WHERE estado = 'activo'
ORDER BY precio DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    e.nombre AS "Evento",
    l.nombre AS "Lugar",
    l.ciudad AS "Ciudad",
    a.nombre_completo AS "Asistente",
    b.tipo AS "Tipo de boleto",
    b.precio AS "Precio"
FROM boletos AS b
INNER JOIN eventos AS e
    ON e.id_evento = b.id_evento
INNER JOIN lugares AS l
    ON l.id_lugar = e.id_lugar
INNER JOIN asistentes AS a
    ON a.id_asistente = b.id_asistente
ORDER BY e.fecha, a.nombre_completo;

-- 12. DECISION DE NEGOCIO: EVENTOS CON MAYOR DEMANDA

SELECT
    e.id_evento,
    e.nombre AS evento,
    COUNT(b.id_boleto) AS boletos_vendidos,
    l.capacidad,
    ROUND(
        COUNT(b.id_boleto) * 100.0 / l.capacidad,
        2
    ) AS porcentaje_ocupacion,
    CASE
        WHEN COUNT(b.id_boleto) * 100.0 / l.capacidad >= 70
            THEN 'Considerar ampliar capacidad o habilitar otra funcion'
        WHEN COUNT(b.id_boleto) * 100.0 / l.capacidad >= 40
            THEN 'Mantener promocion activa'
        ELSE
            'Reforzar promocion'
    END AS recomendacion
FROM eventos AS e
INNER JOIN lugares AS l
    ON l.id_lugar = e.id_lugar
LEFT JOIN boletos AS b
    ON b.id_evento = e.id_evento
    AND b.estado <> 'cancelado'
GROUP BY
    e.id_evento,
    e.nombre,
    l.capacidad
ORDER BY porcentaje_ocupacion DESC;