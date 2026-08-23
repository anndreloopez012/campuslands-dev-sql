.headers on
.mode column

-- Ejercicio 013: Clinica de Tatuajes
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM sesiones;

-- 2. Que sesiones no estan completadas todavia.
SELECT id_sesion, nombre_cliente, fecha_sesion, estado
FROM sesiones
WHERE estado <> 'completada';

-- 3. Que artista tiene mas sesiones completadas.
SELECT a.nombre_artista, COUNT(*) AS sesiones_completadas
FROM artistas a
JOIN sesiones s ON s.id_artista = a.id_artista
WHERE s.estado = 'completada'
GROUP BY a.id_artista, a.nombre_artista
ORDER BY sesiones_completadas DESC;

-- 4. Sesiones ordenadas por fecha.
SELECT id_sesion, nombre_cliente, fecha_sesion, estado
FROM sesiones
ORDER BY fecha_sesion;

-- 5. Cuanto genera cada artista en ingresos (solo sesiones completadas),
--    para decisiones de comision o de agenda.
SELECT
    a.nombre_artista,
    a.estilo_principal,
    SUM(s.monto_pagado) AS ingresos_generados
FROM artistas a
JOIN sesiones s ON s.id_artista = a.id_artista
WHERE s.estado = 'completada'
GROUP BY a.id_artista, a.nombre_artista, a.estilo_principal
ORDER BY ingresos_generados DESC;
