PRAGMA foreign_keys = ON;

-- Ejercicio 005: Cine Horror Nights
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Ana Gomez ya entro a ver la funcion (id_boleto = 1): se corrige el
--    estado de 'vendido' a 'usado'. WHERE especifico por PK + estado
--    actual.
UPDATE boletos
SET estado = 'usado'
WHERE id_boleto = 1 AND estado = 'vendido';

-- 2. El cine lanza una promocion para la pelicula clasica (id_pelicula =
--    5): se baja el precio de boleto de 35.00 a 30.00.
UPDATE peliculas
SET precio_boleto = 30.00
WHERE id_pelicula = 5;

-- 3. Se elimina la entrada de prueba (id_boleto = 9): nunca fue una venta
--    real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM boletos
WHERE id_boleto = 9;
