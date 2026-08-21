PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. INSERT adicional
-- =========================================================

INSERT INTO proveedores (
    id_proveedor,
    nombre,
    telefono,
    email
) VALUES (
    6,
    'Ciclo Express',
    '5551006',
    'contacto@cicloexpress.com'
);

-- =========================================================
-- 2. INSERT adicional
-- =========================================================

INSERT INTO bicicletas (
    id_bicicleta,
    codigo,
    modelo,
    categoria,
    precio,
    id_marca
) VALUES (
    6,
    'BIKE-006',
    'Domane AL 2',
    'CARRETERA',
    1350.00,
    1
);

-- =========================================================
-- 3. UPDATE válido
-- =========================================================

UPDATE proveedores
SET telefono = '5551016'
WHERE id_proveedor = 6;

-- =========================================================
-- 4. UPDATE válido
-- =========================================================

UPDATE bicicletas
SET precio = 1390.00
WHERE id_bicicleta = 6;

-- =========================================================
-- 5. DELETE controlado
-- =========================================================

DELETE FROM bicicletas
WHERE id_bicicleta = 6;

-- =========================================================
-- 6. DELETE controlado
-- =========================================================

DELETE FROM proveedores
WHERE id_proveedor = 6;

-- =========================================================
-- OPERACIONES QUE DEBEN FALLAR
-- Se mantienen comentadas.
-- =========================================================

-- CHECK: la cantidad debe ser mayor que cero.
-- INSERT INTO movimientos_inventario (
--     id_movimiento,
--     id_bicicleta,
--     id_proveedor,
--     tipo_movimiento,
--     cantidad,
--     fecha_movimiento
-- ) VALUES (
--     11,
--     1,
--     1,
--     'ENTRADA',
--     0,
--     '2026-08-10 10:00:00'
-- );

-- UNIQUE: el codigo BIKE-001 ya existe.
-- INSERT INTO bicicletas (
--     id_bicicleta,
--     codigo,
--     modelo,
--     categoria,
--     precio,
--     id_marca
-- ) VALUES (
--     7,
--     'BIKE-001',
--     'Modelo Duplicado',
--     'URBANA',
--     500.00,
--     1
-- );

-- FOREIGN KEY: la marca 999 no existe.
-- INSERT INTO bicicletas (
--     id_bicicleta,
--     codigo,
--     modelo,
--     categoria,
--     precio,
--     id_marca
-- ) VALUES (
--     8,
--     'BIKE-008',
--     'Bicicleta Invalida',
--     'URBANA',
--     600.00,
--     999
-- );