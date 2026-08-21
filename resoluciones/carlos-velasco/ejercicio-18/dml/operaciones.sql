PRAGMA foreign_keys = ON;

-- INSERT ADICIONALES

INSERT INTO compras
(id_compra, id_medicamento, fecha_compra, cantidad, precio_compra, proveedor)
VALUES
(11, 1, '2026-08-11', 75, 5.10, 'Distribuidora Medica GT');

INSERT INTO ventas
(id_venta, id_medicamento, fecha_venta, cantidad, precio_unitario, cliente)
VALUES
(11, 2, '2026-08-12', 3, 12.75, 'Fernando Ruiz');

-- UPDATE

UPDATE medicamentos
SET precio_venta = 9.00
WHERE id_medicamento = 1;

UPDATE medicamentos
SET stock = stock + 15
WHERE id_medicamento = 3;

-- DELETE

DELETE FROM ventas
WHERE id_venta = 11;

DELETE FROM compras
WHERE id_compra = 11;

-- OPERACIONES INVALIDAS

-- CHECK: cantidad no puede ser menor o igual a cero.
-- INSERT INTO ventas
-- (id_venta, id_medicamento, fecha_venta, cantidad, precio_unitario, cliente)
-- VALUES
-- (12, 4, '2026-08-13', 0, 10.50, 'Cliente Invalido');

-- FOREIGN KEY: el medicamento relacionado debe existir.
-- INSERT INTO compras
-- (id_compra, id_medicamento, fecha_compra, cantidad, precio_compra, proveedor)
-- VALUES
-- (12, 999, '2026-08-13', 10, 5.00, 'Proveedor Invalido');