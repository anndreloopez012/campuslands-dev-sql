PRAGMA foreign_keys = ON;

-- Ejercicio 43: Tipos de datos Nivel Aplicado
-- Datos de prueba para validar el tema Tipos de datos.

INSERT INTO clientes (nombre, correo, fecha_registro, frecuente) VALUES
    ('Ana Ramirez', 'ana.ramirez@correo.com', '2026-01-10', 1),
    ('Luis Gomez', 'luis.gomez@correo.com', '2026-02-05', 0),
    ('Karla Diaz', NULL, '2026-03-01', 0),   -- correo NULL: cliente no lo proporciono
    ('Pedro Suarez', 'pedro.suarez@correo.com', '2026-01-20', 1),
    ('Sofia Leon', 'sofia.leon@correo.com', '2026-02-15', 0);

INSERT INTO productos (nombre, categoria, precio, disponible) VALUES
    ('Cafe americano', 'Bebida', 15.00, 1),
    ('Capuchino', 'Bebida', 22.00, 1),
    ('Sandwich de pollo', 'Comida', 38.00, 1),
    ('Bagel con queso', 'Comida', 28.00, 1),
    ('Pastel de chocolate', 'Postre', 25.00, 0);   -- disponible = 0: agotado hoy

-- id_cliente NULL representa una venta a un cliente no registrado (mostrador).
INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta, hora_venta, pagado_tarjeta) VALUES
    (1, 1, 2, 15.00, '2026-07-01', '07:30', 1),
    (2, 2, 1, 22.00, '2026-07-01', '08:15', 0),
    (NULL, 3, 1, 38.00, '2026-07-01', '12:05', 1),
    (4, 1, 1, 15.00, '2026-07-01', '13:40', 0),
    (3, 4, 2, 28.00, '2026-07-02', '08:00', 1),
    (1, 2, 1, 22.00, '2026-07-02', '09:10', 1),
    (5, 3, 1, 38.00, '2026-07-02', '12:30', 0),
    (NULL, 1, 3, 15.00, '2026-07-02', '17:45', 1),
    (2, 4, 1, 28.00, '2026-07-03', '08:20', 0),
    (4, 2, 2, 22.00, '2026-07-03', '09:00', 1),
    (5, 1, 1, 15.00, '2026-07-03', '16:10', 1);

-- Caso valido: id_cliente NULL es correcto para una venta de mostrador.
INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta, hora_venta, pagado_tarjeta) VALUES
    (NULL, 4, 1, 28.00, '2026-07-03', '18:30', 0);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- hora_venta = '25:99' no es una hora valida; el CHECK con GLOB la rechaza.
-- INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta, hora_venta, pagado_tarjeta) VALUES (1, 1, 1, 15.00, '2026-07-04', '25:99', 1);

-- Otro caso que no es recomendable: guardar precio_unitario como TEXT ('15
-- quetzales') en vez de REAL rompe cualquier operacion aritmetica (SUM,
-- AVG) sobre esa columna. Aqui falla porque la columna es REAL y el CHECK
-- de cantidad tambien se viola con 0:
-- INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta, hora_venta, pagado_tarjeta) VALUES (1, 1, 0, 15.00, '2026-07-04', '10:00', 1);
