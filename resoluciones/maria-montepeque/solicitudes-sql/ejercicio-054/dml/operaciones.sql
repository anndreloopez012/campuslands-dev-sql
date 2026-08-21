PRAGMA foreign_keys = ON;

-- Ejercicio 054: Tienda Sneakers
-- Operaciones de mantenimiento: UPDATE de estado (con control de
-- stock) y DELETE controlado.

-- 1. El pedido de Cristian Lopez (id_pedido = 4) se confirmo: se
--    corrige el estado de 'pendiente' a 'confirmado' y se marca que
--    ya descuenta stock; el stock de esa talla baja de 4 a 3.
UPDATE pedidos
SET estado = 'confirmado',
    stock_descontado = 1
WHERE id_pedido = 4 AND estado = 'pendiente';

UPDATE tallas
SET stock = stock - 1
WHERE id_talla = 7;

-- 2. El pedido de Ninoska Tul (id_pedido = 3) se envio: se corrige el
--    estado de 'confirmado' a 'enviado'.
UPDATE pedidos
SET estado = 'enviado'
WHERE id_pedido = 3 AND estado = 'confirmado';

-- 3. DELETE controlado: solo se borra un pedido 'cancelado' si nunca
--    llego a descontar stock (stock_descontado = 0). El pedido 7
--    cumple la condicion; el pedido 8, tambien cancelado pero con
--    stock_descontado = 1 (ya afecto el inventario), no se toca: se
--    conserva para que alguien devuelva el stock manualmente.
DELETE FROM pedidos
WHERE id_pedido = 7
  AND estado = 'cancelado'
  AND stock_descontado = 0;

-- 4. Se elimina el pedido duplicado (id_pedido = 11): es una copia
--    exacta del pedido 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM pedidos
WHERE id_pedido = 11;
