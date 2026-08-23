-- Ejercicio 04: Restaurante Campus
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO platos (nombre, categoria, precio) VALUES
    ('Cafe americano', 'Bebida', 10.00);

INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario) VALUES
    (6, 4, 1, 12.00);

-- 2 UPDATE validos
UPDATE pedidos
SET estado = 'cerrado'
WHERE id_pedido = 4;

UPDATE platos
SET precio = 48.00
WHERE id_plato = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM detalle_pedido
WHERE id_pedido = 6;

DELETE FROM pedidos
WHERE estado = 'cancelado';

-- 2 operaciones comentadas que deben fallar por restricciones
-- Falla por UNIQUE (mesas.numero): la mesa numero 1 ya existe
-- INSERT INTO mesas (numero, capacidad) VALUES (1, 4);

-- Falla por CHECK (cantidad > 0)
-- INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario)
-- VALUES (1, 2, 0, 25.00);
