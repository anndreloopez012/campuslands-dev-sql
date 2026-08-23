-- Ejercicio 20: Eventos Boletos
-- Entidad central: boletos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM boletos;

-- 2. Mostrar solo dos columnas relevantes
SELECT precio, estado FROM boletos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM boletos WHERE precio > 100;

-- 4. Ordenar resultados por fecha
SELECT * FROM boletos ORDER BY fecha_compra;

-- 5. Mostrar los 5 boletos de mayor precio
SELECT * FROM boletos ORDER BY precio DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_boletos FROM boletos;

-- 7. Promedio, minimo y maximo del precio de los boletos
SELECT
    AVG(precio) AS promedio,
    MIN(precio) AS minimo,
    MAX(precio) AS maximo
FROM boletos;

-- 8. Agrupar boletos por estado
SELECT estado, COUNT(*) AS cantidad_boletos
FROM boletos
GROUP BY estado;

-- 9. Relacionar boletos, eventos y lugares con JOIN
SELECT b.id_boleto, e.nombre AS evento, l.nombre AS lugar
FROM boletos b
JOIN eventos e ON e.id_evento = b.id_evento
JOIN lugares l ON l.id_lugar = e.id_lugar;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM boletos
WHERE estado = 'vendido'
ORDER BY precio DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    a.nombre AS asistente,
    e.nombre AS evento,
    l.nombre AS lugar,
    b.precio AS precio_boleto,
    b.estado AS estado_boleto,
    b.fecha_compra AS fecha_compra
FROM boletos b
JOIN asistentes a ON a.id_asistente = b.id_asistente
JOIN eventos e ON e.id_evento = b.id_evento
JOIN lugares l ON l.id_lugar = e.id_lugar;

-- 12. Consulta para decision de negocio: evento con mayores ingresos por boletos vendidos
SELECT e.nombre, SUM(b.precio) AS total_ingresos
FROM boletos b
JOIN eventos e ON e.id_evento = b.id_evento
WHERE b.estado = 'vendido'
GROUP BY e.nombre
ORDER BY total_ingresos DESC
LIMIT 1;
