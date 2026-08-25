PRAGMA foreign_keys = ON;

-- Ejercicio 080: Cine Horror Nights
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que el proyector fallo durante la
-- funcion 3 y se cancela.
UPDATE funciones
SET estado = 'cancelada'
WHERE id_funcion = 3 AND estado = 'finalizada';

-- 1 DELETE controlado: el boleto de la funcion 3 todavia no tenia
-- pago registrado, asi que es seguro eliminarlo ahora que la funcion
-- se cancelo. Un boleto ya pagado (como los de las funciones 1 y 2)
-- nunca se borraria por este mismo motivo.
DELETE FROM boletos
WHERE id_funcion = 3
  AND id_boleto NOT IN (SELECT id_boleto FROM pagos);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar un boleto que ya tiene pago registrado (resultado oficial
-- del cine). El DELETE de arriba solo alcanza boletos sin pago, por
-- diseno.
-- DELETE FROM boletos WHERE id_boleto = 1;
