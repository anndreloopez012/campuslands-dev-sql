PRAGMA foreign_keys = ON;

-- Ejercicio 012: Club Futbol Sala
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Se le pago el bono a Pedro Gomez por su gol (id_evento = 5): se
--    corrige el estado de 'registrado' a 'pagado'. WHERE especifico por
--    PK + estado actual.
UPDATE eventos
SET estado = 'pagado'
WHERE id_evento = 5 AND estado = 'registrado';

-- 2. Rayos del Sur asciende de categoria (id_equipo = 3): de 'segunda' a
--    'primera'.
UPDATE equipos
SET categoria = 'primera'
WHERE id_equipo = 3;

-- 3. Se elimina el evento de prueba (id_evento = 9): nunca fue un gol
--    real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM eventos
WHERE id_evento = 9;
