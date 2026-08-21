-- Ejercicio 22: Pedidos Delivery
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, telefono, direccion) VALUES
    ('Ingrid Say', '5044-1006', 'Zona 3, Ciudad de Guatemala');

INSERT INTO pedidos (id_cliente, id_restaurante, id_repartidor, total, estado, fecha) VALUES
    (2, 1, 4, 95.00, 'pendiente', '2026-07-12 12:00');

-- 2 UPDATE validos
UPDATE pedidos
SET estado = 'entregado'
WHERE id_pedido = 4;

UPDATE restaurantes
SET categoria = 'Pollo frito y parrilla'
WHERE id_restaurante = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM pedidos
WHERE id_pedido = 8;

DELETE FROM pedidos
WHERE estado = 'pendiente' AND id_pedido = 6;
