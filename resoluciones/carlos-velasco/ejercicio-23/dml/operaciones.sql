PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    correo,
    telefono
) VALUES
(6, 'Mariana Lopez', 'ML100006', 'mariana.lopez@email.com', '55510006');

INSERT INTO productos (
    id_producto,
    nombre,
    descripcion,
    precio,
    stock
) VALUES
(6, 'Webcam Full HD', 'Camara web para videollamadas', 75.00, 22);

-- UPDATES

UPDATE clientes
SET telefono = '55510999'
WHERE id_cliente = 1;

UPDATE productos
SET precio = 89.00
WHERE id_producto = 3;

-- DELETES

DELETE FROM clientes
WHERE id_cliente = 6;

DELETE FROM productos
WHERE id_producto = 6;

-- OPERACIONES INVALIDAS

-- CHECK: precio no puede ser menor o igual a cero.
-- INSERT INTO productos (
--     id_producto,
--     nombre,
--     descripcion,
--     precio,
--     stock
-- ) VALUES (
--     7,
--     'Producto Invalido',
--     'Registro de prueba',
--     -50.00,
--     10
-- );

-- UNIQUE: el numero de factura no puede repetirse.
-- INSERT INTO facturas (
--     id_factura,
--     id_cliente,
--     numero_factura,
--     fecha,
--     impuesto,
--     estado
-- ) VALUES (
--     6,
--     1,
--     'FAC-2026-001',
--     '2026-08-06',
--     0.19,
--     'EMITIDA'
-- );