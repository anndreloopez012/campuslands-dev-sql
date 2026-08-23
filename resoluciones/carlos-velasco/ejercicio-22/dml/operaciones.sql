PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    direccion
)
VALUES (
    6,
    'Valeria Cruz',
    'valeria.cruz@email.com',
    '555-2006',
    'Zona 9, Ciudad de Guatemala'
);

INSERT INTO repartidores (
    id_repartidor,
    nombre_completo,
    telefono,
    vehiculo,
    disponible
)
VALUES (
    6,
    'Daniel Fuentes',
    '555-4006',
    'MOTO',
    1
);

-- UPDATES

UPDATE pedidos
SET estado = 'EN_CAMINO'
WHERE id_pedido = 6;

UPDATE repartidores
SET disponible = 0
WHERE id_repartidor = 6;

-- DELETES

DELETE FROM repartidores
WHERE id_repartidor = 6;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACIONES INVALIDAS

-- CHECK: la calificacion debe estar entre 1 y 5.
-- INSERT INTO restaurantes (
--     id_restaurante,
--     nombre,
--     telefono,
--     categoria,
--     calificacion
-- )
-- VALUES (
--     6,
--     'Restaurante Invalido',
--     '555-3006',
--     'Comida rapida',
--     6.5
-- );

-- FOREIGN KEY: el restaurante referenciado debe existir.
-- INSERT INTO pedidos (
--     id_pedido,
--     id_cliente,
--     id_restaurante,
--     id_repartidor,
--     fecha_pedido,
--     estado,
--     total,
--     tiempo_estimado_min
-- )
-- VALUES (
--     11,
--     1,
--     999,
--     1,
--     '2026-08-16 14:00',
--     'PENDIENTE',
--     60.00,
--     30
-- );