INSERT INTO marcas (
    id_marca,
    nombre,
    pais_origen
) VALUES (
    6,
    'Bianchi',
    'Italia'
);

INSERT INTO proveedores (
    id_proveedor,
    nombre_empresa,
    telefono,
    email
) VALUES (
    6,
    'Ciclos del Pacifico',
    '55510006',
    'ventas@ciclospacifico.com'
);

UPDATE bicicletas
SET precio = 875.00
WHERE id_bicicleta = 1;

UPDATE bicicletas
SET stock_actual = stock_actual + 3
WHERE id_bicicleta = 3;

DELETE FROM marcas
WHERE id_marca = 6;

DELETE FROM proveedores
WHERE id_proveedor = 6;

-- Operacion invalida: CHECK
-- INSERT INTO bicicletas (id_bicicleta, id_marca, id_proveedor, modelo, tipo, precio, stock_actual)
-- VALUES (6, 1, 1, 'Modelo Invalido', 'MTB', 0, 5);

-- Operacion invalida: FOREIGN KEY
-- INSERT INTO movimientos_inventario (id_movimiento, id_bicicleta, tipo_movimiento, cantidad, fecha_movimiento, observacion)
-- VALUES (11, 999, 'ENTRADA', 5, '2026-08-01', 'Bicicleta inexistente');