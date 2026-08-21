.headers on
.mode column

-- Ejercicio 012: Club Futbol Sala
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM eventos;

-- 2. Que eventos no estan pagados todavia (registrados o anulados).
SELECT id_evento, nombre_jugador, tipo_evento, fecha_partido, estado
FROM eventos
WHERE estado <> 'pagado';

-- 3. Que jugador tiene mas eventos registrados.
SELECT nombre_jugador, COUNT(*) AS total_eventos
FROM eventos
GROUP BY nombre_jugador
ORDER BY total_eventos DESC;

-- 4. Eventos ordenados por fecha del partido.
SELECT id_evento, nombre_jugador, tipo_evento, fecha_partido
FROM eventos
ORDER BY fecha_partido;

-- 5. Cuanto dinero representa cada tipo de evento (sin contar los
--    anulados), para saber cuanto se debe en bonos y cuanto se recauda
--    en multas.
SELECT
    tipo_evento,
    SUM(monto) AS total_dinero,
    COUNT(*) AS total_eventos
FROM eventos
WHERE estado <> 'anulado'
GROUP BY tipo_evento
ORDER BY total_dinero DESC;
