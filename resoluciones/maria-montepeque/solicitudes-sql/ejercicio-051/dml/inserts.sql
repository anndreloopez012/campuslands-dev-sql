PRAGMA foreign_keys = ON;

-- Ejercicio 051: Cafeteria Campus
-- Datos de prueba.

INSERT INTO productos (nombre_producto, categoria, precio) VALUES
    ('Cafe Americano', 'bebida', 12.00),
    ('Capuchino', 'bebida', 18.00),
    ('Croissant', 'panaderia', 15.00),
    ('Sandwich de Pollo', 'comida', 28.00),
    ('Papas Fritas', 'snack', 14.00),
    ('Agua Embotellada', 'bebida', 8.00);

INSERT INTO clientes (nombre_cliente, carnet) VALUES
    ('Kimberly Solares', '2024-01123'),
    ('Estuardo Ba', '2024-00987'),
    ('Melany Roblero', '2023-01456'),
    ('Josue Tojin', '2024-01789'),
    ('Andrea Chavez', '2023-00654');

-- La venta 9 es un duplicado por error de digitacion (mismo cliente,
-- fecha y estado que la venta 1): se corrige en dml/operaciones.sql.
-- La venta 7 se cancelo despues de que ya se habia tomado el pedido;
-- su detalle se eliminara de forma controlada.
INSERT INTO ventas (id_cliente, fecha_venta, estado) VALUES
    (1, '2026-08-01', 'pagada'),
    (2, '2026-08-01', 'pagada'),
    (1, '2026-08-02', 'pagada'),
    (3, '2026-08-03', 'pendiente_pago'),
    (4, '2026-08-04', 'pagada'),
    (1, '2026-08-05', 'pagada'),
    (5, '2026-08-06', 'cancelada'),
    (2, '2026-08-07', 'pagada'),
    (1, '2026-08-01', 'pagada');

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
    (1, 1, 2, 12.00),
    (1, 3, 1, 15.00),
    (2, 2, 1, 18.00),
    (3, 4, 1, 28.00),
    (3, 6, 1, 8.00),
    (4, 5, 2, 14.00),
    (5, 1, 1, 12.00),
    (6, 1, 3, 12.00),
    (7, 4, 1, 28.00),
    (8, 2, 2, 18.00),
    (8, 3, 1, 15.00);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: el carnet ya existe, viola el UNIQUE.
-- INSERT INTO clientes (nombre_cliente, carnet) VALUES ('Otro Estudiante', '2024-01123');

-- 2) Valor fuera de rango: cantidad = 0 no es una linea de venta valida, viola el CHECK.
-- INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES (2, 5, 0, 14.00);
