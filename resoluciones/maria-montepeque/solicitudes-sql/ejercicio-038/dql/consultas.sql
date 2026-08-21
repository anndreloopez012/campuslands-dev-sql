.headers on
.mode column

-- Ejercicio 038: Clinica de Tatuajes
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    cliente y el artista en vez de solo los id).
SELECT
    s.id_sesion,
    c.nombre_cliente,
    a.nombre_artista,
    s.fecha_sesion,
    s.costo_total,
    s.monto_pagado,
    s.estado
FROM sesiones s
JOIN clientes c ON c.id_cliente = s.id_cliente
JOIN artistas a ON a.id_artista = s.id_artista;

-- 2. Que sesiones no estan completadas todavia.
SELECT id_sesion, id_cliente, id_artista, fecha_sesion, estado
FROM sesiones
WHERE estado <> 'completada';

-- 3. Ranking de artistas por total de sesiones.
SELECT a.nombre_artista, COUNT(*) AS total_sesiones
FROM artistas a
JOIN sesiones s ON s.id_artista = a.id_artista
GROUP BY a.id_artista, a.nombre_artista
ORDER BY total_sesiones DESC, a.nombre_artista;

-- 4. Sesiones ordenadas por fecha.
SELECT c.nombre_cliente, a.nombre_artista, s.fecha_sesion
FROM sesiones s
JOIN clientes c ON c.id_cliente = s.id_cliente
JOIN artistas a ON a.id_artista = s.id_artista
ORDER BY s.fecha_sesion;

-- 5. Sesiones con saldo pendiente de pago (casos pendientes que hay
--    que cobrar), sin contar las canceladas.
SELECT
    c.nombre_cliente,
    a.nombre_artista,
    s.fecha_sesion,
    (s.costo_total - s.monto_pagado) AS saldo_pendiente
FROM sesiones s
JOIN clientes c ON c.id_cliente = s.id_cliente
JOIN artistas a ON a.id_artista = s.id_artista
WHERE s.estado <> 'cancelada' AND (s.costo_total - s.monto_pagado) > 0
ORDER BY saldo_pendiente DESC;
