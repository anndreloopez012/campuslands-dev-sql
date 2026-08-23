PRAGMA foreign_keys = ON;

-- Ejercicio 017: Streaming Musica
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Se resolvio el conflicto de "Furia de Acero" (id_cancion = 6): se
--    corrige el estado de 'retirada_temporalmente' a 'disponible'. Esto
--    es exactamente lo que pidio el cliente: corregir, no borrar. WHERE
--    especifico por PK + estado actual.
UPDATE canciones
SET estado = 'disponible'
WHERE id_cancion = 6 AND estado = 'retirada_temporalmente';

-- 2. Se corrige la clasificacion de genero de DJ Pulso (id_artista = 3):
--    de 'electronica' a 'rock' (se habia clasificado mal originalmente).
UPDATE artistas
SET genero_principal = 'rock'
WHERE id_artista = 3;

-- 3. Se elimina la entrada de prueba (id_cancion = 9): nunca fue una
--    cancion real, es el unico caso donde SI se borra (no se corrige un
--    estado porque no hay nada real que corregir). DELETE seguro porque
--    usa el id exacto de la fila.
DELETE FROM canciones
WHERE id_cancion = 9;
