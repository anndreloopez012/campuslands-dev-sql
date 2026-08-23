PRAGMA foreign_keys = ON;

-- Ejercicio 030: Cine Horror Nights
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La funcion de Posesion 13 (id_funcion = 5) ya termino: se corrige
--    el estado de 'en_curso' a 'finalizada'. WHERE especifico por PK +
--    estado actual.
UPDATE funciones
SET estado = 'finalizada'
WHERE id_funcion = 5 AND estado = 'en_curso';

-- 2. Se corrige la duracion de Posesion 13 (id_pelicula = 4): de 95 a
--    100 minutos (dato mal registrado originalmente).
UPDATE peliculas
SET duracion_min = 100
WHERE id_pelicula = 4;

-- 3. Se elimina la funcion de prueba (id_funcion = 9): nunca fue una
--    funcion real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM funciones
WHERE id_funcion = 9;
