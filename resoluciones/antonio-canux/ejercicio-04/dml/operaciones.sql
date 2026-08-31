INSERT INTO platos (nombre, categoria, precio) 
    VALUES ('Cafe americano', 'Bebida', 10.00);

INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario) 
    VALUES (6, 4, 1, 12.00);

UPDATE pedidos
    SET estado = 'cerrado'
    WHERE id_pedido = 4;

UPDATE platos
    SET precio = 48.00
    WHERE id_plato = 1;

DELETE FROM detalle_pedido
    WHERE id_pedido = 6;

DELETE FROM pedidos
    WHERE estado = 'cancelado';

-- 2 operaciones que fallará por restricciones
-- INSERT INTO mesas (numero, capacidad) VALUES (1, 4);

-- Fallará por CHECK (cantidad > 0)
-- INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario)
-- VALUES (1, 2, 0, 25.00);
