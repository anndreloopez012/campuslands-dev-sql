PRAGMA foreign_keys = ON;

-- Ejercicio 041: Hotel Gamers
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado
-- (con criterios seguros, como pide el nivel 3 de este ejercicio).

-- 1. Daniela Us hizo check-in (id_reserva = 4): se corrige el estado
--    de 'confirmada' a 'en_curso'. WHERE especifico por PK + estado
--    actual.
UPDATE reservas
SET estado = 'en_curso'
WHERE id_reserva = 4 AND estado = 'confirmada';

-- 2. Marlon Chinchilla hizo check-out de su suite gamer
--    (id_reserva = 3): se corrige el estado de 'en_curso' a
--    'finalizada'.
UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 3 AND estado = 'en_curso';

-- 3. DELETE controlado: solo se borra una reserva cancelada si NO
--    tiene ningun consumo asociado (si tuviera un consumo, como un
--    deposito ya cobrado, se conserva como historial). La reserva 6
--    (Roberto Salazar) cumple la condicion; la reserva 7 (Paola
--    Fuentes, que si tiene un consumo) no la cumple y por eso no se
--    toca.
DELETE FROM reservas
WHERE id_reserva = 6
  AND estado = 'cancelada'
  AND NOT EXISTS (
      SELECT 1 FROM consumos WHERE consumos.id_reserva = reservas.id_reserva
  );

-- 4. Se elimina la reserva duplicada (id_reserva = 9): es una copia
--    exacta de la reserva 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (este si es un error de
--    captura, no una decision de negocio).
DELETE FROM reservas
WHERE id_reserva = 9;
