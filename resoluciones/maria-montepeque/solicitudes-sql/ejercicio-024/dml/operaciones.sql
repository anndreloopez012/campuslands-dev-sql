PRAGMA foreign_keys = ON;

-- Ejercicio 024: Liga Videojuego Futbol
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El partido pendiente (id_partido = 4) ya se jugo: se corrige el
--    marcador real y el estado de 'pendiente' a 'jugado'. WHERE
--    especifico por PK + estado actual.
UPDATE partidos
SET goles_local = 2, goles_visitante = 2, estado = 'jugado'
WHERE id_partido = 4 AND estado = 'pendiente';

-- 2. Deportivo Trueno (id_club = 3) asciende de division: de 'segunda'
--    a 'primera'.
UPDATE clubes
SET division = 'primera'
WHERE id_club = 3;

-- 3. Se elimina el partido duplicado (id_partido = 9): es una copia
--    exacta del partido 1 por error de digitacion. DELETE seguro porque
--    usa el id exacto de la fila.
DELETE FROM partidos
WHERE id_partido = 9;
