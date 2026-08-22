INSERT INTO clientes VALUES
(6,'Maria Hernandez','CF006','maria@email.com','Villa Nueva');

INSERT INTO facturas VALUES
(6,6,'F0006','2026-08-06',12);

UPDATE clientes
SET direccion='Zona 12'
WHERE id_cliente=6;

UPDATE facturas
SET impuesto=15
WHERE id_factura=6;

DELETE FROM facturas
WHERE id_factura=6;

DELETE FROM clientes
WHERE id_cliente=6;

-- INSERT INTO clientes VALUES
-- (7,'Duplicado','CF001','dup@email.com','Zona 1');

-- INSERT INTO detalle_factura VALUES
-- (11,999,1,1,4500);