INSERT INTO marcas (nombre) VALUES
    ('Bianchi');

INSERT INTO movimientos_inventario (id_bicicleta, id_proveedor, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    (4, 4, 'salida', 2, '2026-07-14');

UPDATE bicicletas
SET stock = stock - 2
WHERE id_bicicleta = 1;

UPDATE proveedores
SET telefono = '5558888'
WHERE id_proveedor = 2;


DELETE FROM movimientos_inventario
WHERE tipo_movimiento = 'salida'
  AND id_bicicleta = 6;

DELETE FROM movimientos_inventario
WHERE id_movimiento = 4;

-- 2 operaciones que fallarán por restricciones
-- Falla por UNIQUE (marcas.nombre): la marca ya existe
-- INSERT INTO marcas (nombre) VALUES ('Trek');

-- Falla por CHECK (cantidad > 0)
-- INSERT INTO movimientos_inventario (id_bicicleta, id_proveedor, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 1, 'entrada', 0, '2026-07-20');
