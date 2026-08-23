PRAGMA foreign_keys = ON;

-- Ejercicio 029: Tienda Sneakers
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Se confirmo el stock del pedido 4 (id_evento = 8): se corrige el
--    estado de 'anulado' a 'valido'. El evento en si (que paso y cuando
--    paso) NO se toca, solo su resultado. WHERE especifico por PK +
--    estado actual.
UPDATE eventos_pedido
SET estado = 'valido'
WHERE id_evento = 8 AND estado = 'anulado';

-- 2. Ana Gomez (id_cliente = 1) actualizo su correo.
UPDATE clientes
SET email = 'ana.gomez.nueva@correo.com'
WHERE id_cliente = 1;

-- 3. Se elimina la entrada de prueba (id_evento = 10): nunca fue un
--    evento real del historico. DELETE seguro porque usa el id exacto
--    de la fila. Es la unica eliminacion del historico; todo lo demas
--    se corrige con UPDATE de estado.
DELETE FROM eventos_pedido
WHERE id_evento = 10;
