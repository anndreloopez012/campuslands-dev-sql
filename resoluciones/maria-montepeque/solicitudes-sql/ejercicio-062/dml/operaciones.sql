PRAGMA foreign_keys = ON;

-- Ejercicio 062: Club Futbol Sala
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: el partido 3 (Halcones vs Panteras) termina y pasa
-- de 'en_curso' a 'finalizado'.
UPDATE partidos
SET estado = 'finalizado'
WHERE id_partido = 3;

-- 1 UPDATE de correccion: el arbitro corrige el minuto de un gol mal
-- registrado (Kevin Ramos, segundo gol del partido 1).
UPDATE goles
SET minuto = 27
WHERE id_partido = 1 AND id_jugador = 3 AND minuto = 25;

-- 1 DELETE controlado: se elimina la tarjeta duplicada registrada por
-- error (queda la original del minuto 50).
DELETE FROM tarjetas
WHERE id_partido = 2 AND id_jugador = 5 AND minuto = 52;

-- Caso que debe fallar (queda comentado): eliminar un equipo que tiene
-- jugadores asociados viola la FOREIGN KEY de jugadores.id_equipo.
-- DELETE FROM equipos WHERE id_equipo = 1;
