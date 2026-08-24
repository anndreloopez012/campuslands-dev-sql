INSERT INTO clientes VALUES
(6,'Maria Hernandez','50010006','55510006','Villa Nueva');

INSERT INTO pedidos VALUES
(11,6,1,3,'2026-08-07 13:00',99,'PENDIENTE');

UPDATE clientes
SET telefono='55519999'
WHERE id_cliente=6;

UPDATE pedidos
SET estado='ENTREGADO'
WHERE id_pedido=11;

DELETE FROM pedidos
WHERE id_pedido=11;

DELETE FROM clientes
WHERE id_cliente=6;

-- INSERT INTO repartidores VALUES
-- (6,'Repartidor','MOT001','55520006','DISPONIBLE');

-- INSERT INTO pedidos VALUES
-- (12,999,1,1,'2026-08-08 12:00',80,'PENDIENTE');