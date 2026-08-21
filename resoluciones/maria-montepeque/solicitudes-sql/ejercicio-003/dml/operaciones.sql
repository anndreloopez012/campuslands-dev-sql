PRAGMA foreign_keys = ON;

-- Ejercicio 003: Torneo Esports
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. ShadowFox (id_jugador = 1) gano su ultima partida: se suman 50
--    puntos a su acumulado. No se reemplaza el valor, se incrementa sobre
--    el actual.
UPDATE jugadores
SET puntos_totales = puntos_totales + 50
WHERE id_jugador = 1;

-- 2. BlazeStorm (id_jugador = 7) vuelve de su descanso: se corrige su
--    estado de 'inactivo' a 'activo'. WHERE especifico por PK + estado
--    actual.
UPDATE jugadores
SET estado = 'activo'
WHERE id_jugador = 7 AND estado = 'inactivo';

-- 3. Se elimina la cuenta de prueba (id_jugador = 9): nunca compitio y
--    solo ensucia los reportes. DELETE seguro porque usa el id exacto de
--    la fila.
DELETE FROM jugadores
WHERE id_jugador = 9;
