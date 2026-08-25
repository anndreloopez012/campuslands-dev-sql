.headers on
.mode column

-- Ejercicio 088: Clinica de Tatuajes
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_resumen_sesiones (creada en ddl/schema.sql).
SELECT *
FROM vista_resumen_sesiones;

-- 2. Que sesiones estan programadas (casos pendientes), en curso,
-- finalizadas o canceladas.
SELECT id_sesion, id_cliente, estado
FROM sesiones
ORDER BY estado;

-- 3. Ranking: que artista tiene mas sesiones (ORDER BY + LIMIT, tal
-- como pidio el cliente).
SELECT ar.nombre_artista, COUNT(*) AS total_sesiones
FROM artistas ar
JOIN sesiones s ON s.id_artista = ar.id_artista
GROUP BY ar.id_artista, ar.nombre_artista
ORDER BY total_sesiones DESC, ar.nombre_artista
LIMIT 3;

-- 4. Sesiones ordenadas por fecha y, como segundo criterio, por
-- duracion (de mas a menos horas).
SELECT id_sesion, fecha_sesion, duracion_horas
FROM sesiones
ORDER BY fecha_sesion, duracion_horas DESC;

-- 5. Totales: ingresos totales por artista, para decidir a quien
-- asignar mas horarios (GROUP BY + HAVING, usando la vista para no
-- repetir el JOIN).
SELECT nombre_artista,
       SUM(monto_pagado) AS ingresos_totales
FROM vista_resumen_sesiones
WHERE monto_pagado IS NOT NULL
GROUP BY nombre_artista
HAVING SUM(monto_pagado) > 0
ORDER BY ingresos_totales DESC;
