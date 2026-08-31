.headers on
.mode column

-- Ejercicio 063: Clinica de Tatuajes
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las sesiones con cliente,
-- artista y estilo.
SELECT s.id_sesion,
       c.nombre AS cliente,
       a.nombre AS artista,
       e.nombre AS estilo,
       s.duracion_horas,
       s.estado
FROM sesiones s
JOIN clientes c ON c.id_cliente = s.id_cliente
JOIN artistas a ON a.id_artista = s.id_artista
JOIN estilos e ON e.id_estilo = s.id_estilo;

-- 2. Que registros estan agendados, completados o cancelados.
SELECT id_sesion, estado
FROM sesiones
ORDER BY estado;

-- 3. Que artista tiene mas actividad (ranking por sesiones completadas).
SELECT a.nombre AS artista,
       COUNT(*) AS sesiones_completadas
FROM sesiones s
JOIN artistas a ON a.id_artista = s.id_artista
WHERE s.estado = 'completada'
GROUP BY a.id_artista
ORDER BY sesiones_completadas DESC;

-- 4. Sesiones ordenadas por fecha, de la mas reciente a la mas antigua.
SELECT id_sesion, fecha_sesion, estado
FROM sesiones
ORDER BY fecha_sesion DESC;

-- 5. Reporte para decision de negocio: facturacion por estilo, solo con
-- pagos ya 'pagado', filtrando los estilos que superan Q300 (GROUP BY +
-- HAVING).
SELECT e.nombre AS estilo,
       COUNT(*) AS sesiones_pagadas,
       SUM(pg.monto) AS total_facturado
FROM pagos pg
JOIN sesiones s ON s.id_sesion = pg.id_sesion
JOIN estilos e ON e.id_estilo = s.id_estilo
WHERE pg.estado_pago = 'pagado'
GROUP BY e.id_estilo
HAVING SUM(pg.monto) > 300
ORDER BY total_facturado DESC;
