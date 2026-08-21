PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    ciudad
)
VALUES (
    6,
    'Laura Castillo',
    'laura.castillo@email.com',
    '555-1006',
    'Jalapa'
);

INSERT INTO paquetes (
    id_paquete,
    id_cliente,
    peso_kg,
    tipo,
    descripcion
)
VALUES (
    11,
    6,
    1.50,
    'CAJA',
    'Material promocional'
);

-- UPDATES

UPDATE rutas
SET distancia_km = 203.0
WHERE id_ruta = 1;

UPDATE envios
SET estado = 'ENTREGADO',
    fecha_entrega = '2026-08-12'
WHERE id_envio = 7;

-- DELETES

DELETE FROM paquetes
WHERE id_paquete = 11;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACIONES INVALIDAS

-- CHECK: peso_kg debe ser mayor que cero.
-- INSERT INTO paquetes (
--     id_paquete,
--     id_cliente,
--     peso_kg,
--     tipo,
--     descripcion
-- )
-- VALUES (
--     12,
--     1,
--     -2.00,
--     'CAJA',
--     'Paquete invalido'
-- );

-- FOREIGN KEY: la ruta referenciada debe existir.
-- INSERT INTO envios (
--     id_envio,
--     id_paquete,
--     id_ruta,
--     fecha_envio,
--     estado,
--     costo
-- )
-- VALUES (
--     12,
--     1,
--     999,
--     '2026-08-15',
--     'PENDIENTE',
--     75.00
-- );