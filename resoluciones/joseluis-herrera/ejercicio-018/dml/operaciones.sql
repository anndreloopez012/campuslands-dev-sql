INSERT INTO medicamentos (
    id_medicamento,
    id_laboratorio,
    nombre,
    principio_activo,
    precio_venta,
    stock,
    fecha_vencimiento
) VALUES (
    6,
    1,
    'Alka-Seltzer',
    'Acido acetilsalicilico',
    6.25,
    30,
    '2027-12-20'
);

INSERT INTO compras (
    id_compra,
    id_medicamento,
    fecha_compra,
    cantidad,
    precio_unitario,
    proveedor
) VALUES (
    11,
    6,
    '2026-08-15',
    40,
    3.80,
    'Distribuidora Salud'
);

UPDATE medicamentos
SET precio_venta = 6.50
WHERE id_medicamento = 6;

UPDATE medicamentos
SET stock = 150
WHERE id_medicamento = 1;

DELETE FROM compras
WHERE id_compra = 11;

DELETE FROM medicamentos
WHERE id_medicamento = 6;

-- INSERT INTO medicamentos (
--     id_medicamento,
--     id_laboratorio,
--     nombre,
--     principio_activo,
--     precio_venta,
--     stock,
--     fecha_vencimiento
-- ) VALUES (
--     7,
--     1,
--     'Aspirina 100mg',
--     'Acido acetilsalicilico',
--     2.50,
--     50,
--     '2027-06-30'
-- );

-- INSERT INTO medicamentos (
--     id_medicamento,
--     id_laboratorio,
--     nombre,
--     principio_activo,
--     precio_venta,
--     stock,
--     fecha_vencimiento
-- ) VALUES (
--     8,
--     999,
--     'Medicamento Invalido',
--     'Principio activo',
--     5.00,
--     20,
--     '2027-10-10'
-- );