-- Ejercicio 05: Inventario de Bicicletas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO marcas (nombre) VALUES
    ('Bianchi');

INSERT INTO movimientos_inventario (id_bicicleta, id_proveedor, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    (4, 4, 'salida', 2, '2026-07-14');

-- 2 UPDATE validos
UPDATE bicicletas
SET stock = stock - 2
WHERE id_bicicleta = 1;

UPDATE proveedores
SET telefono = '5558888'
WHERE id_proveedor = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM movimientos_inventario
WHERE tipo_movimiento = 'salida'
  AND id_bicicleta = 6;

DELETE FROM movimientos_inventario
WHERE id_movimiento = 4;
