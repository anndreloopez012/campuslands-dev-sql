PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO ordenes (
    id_orden,
    id_vendedor,
    id_producto,
    id_comprador,
    cantidad,
    precio_unitario,
    fecha_orden,
    estado
) VALUES (
    13,
    3,
    5,
    2,
    2,
    650.00,
    '2026-08-13 10:20',
    'Pagada'
);

INSERT INTO productos (
    id_producto,
    id_vendedor,
    nombre,
    categoria,
    precio,
    stock,
    estado
) VALUES (
    11,
    5,
    'Hub USB-C',
    'Accesorios',
    320.00,
    14,
    'Disponible'
);

-- UPDATES

UPDATE productos
SET precio = 720.00,
    stock = 26
WHERE id_producto = 10;

UPDATE ordenes
SET estado = 'Enviada'
WHERE id_orden = 12;

-- DELETES

DELETE FROM ordenes
WHERE id_orden = 13;

DELETE FROM productos
WHERE id_producto = 11;

-- OPERACIONES INVALIDAS

-- UNIQUE: correo de vendedor duplicado
-- INSERT INTO vendedores (
--     id_vendedor,
--     nombre_completo,
--     correo,
--     ciudad,
--     fecha_registro,
--     estado
-- ) VALUES (
--     6,
--     'Pedro Sanchez',
--     'carlos.ramirez@marketplace.com',
--     'Escuintla',
--     '2026-08-13',
--     'Activo'
-- );

-- FOREIGN KEY: vendedor inexistente
-- INSERT INTO productos (
--     id_producto,
--     id_vendedor,
--     nombre,
--     categoria,
--     precio,
--     stock,
--     estado
-- ) VALUES (
--     12,
--     99,
--     'Cargador USB-C',
--     'Accesorios',
--     250.00,
--     10,
--     'Disponible'
-- );