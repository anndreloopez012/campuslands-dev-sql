PRAGMA foreign_keys = ON;

-- Ejercicio 45: PRIMARY KEY Nivel Intermedio
-- Datos de prueba para validar el tema PRIMARY KEY.

INSERT INTO productos (codigo_barras, nombre, precio) VALUES
    ('750100001', 'Cafe americano', 15.00),
    ('750100002', 'Capuchino', 22.00),
    ('750100003', 'Sandwich de pollo', 38.00),
    ('750100004', 'Bagel con queso', 28.00),
    ('750100005', 'Pastel de chocolate', 25.00);

INSERT INTO clientes (nombre, correo) VALUES
    ('Ana Ramirez', 'ana.ramirez@correo.com'),
    ('Luis Gomez', 'luis.gomez@correo.com'),
    ('Karla Diaz', NULL),
    ('Pedro Suarez', 'pedro.suarez@correo.com'),
    ('Sofia Leon', 'sofia.leon@correo.com');

INSERT INTO ventas (id_cliente, codigo_barras, cantidad, fecha_venta) VALUES
    (1, '750100001', 2, '2026-07-01'),
    (2, '750100002', 1, '2026-07-01'),
    (3, '750100003', 1, '2026-07-01'),
    (4, '750100001', 1, '2026-07-01'),
    (3, '750100004', 2, '2026-07-02'),
    (1, '750100002', 1, '2026-07-02'),
    (5, '750100003', 1, '2026-07-02'),
    (2, '750100004', 1, '2026-07-03'),
    (4, '750100002', 2, '2026-07-03'),
    (5, '750100001', 1, '2026-07-03');

-- Caso valido: el mismo codigo_barras se vende muchas veces (en ventas no es
-- PRIMARY KEY, solo FOREIGN KEY); lo que NO puede repetirse es el codigo de
-- barras dentro del catalogo `productos`, que es donde SI es PRIMARY KEY.
INSERT INTO ventas (id_cliente, codigo_barras, cantidad, fecha_venta) VALUES
    (1, '750100001', 3, '2026-07-04');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- '750100001' ya existe en productos; repetirlo viola la PRIMARY KEY natural.
-- INSERT INTO productos (codigo_barras, nombre, precio) VALUES ('750100001', 'Te caliente', 12.00);

-- Otro caso comentado que debe fallar: reutilizar un id_cliente ya
-- existente (PRIMARY KEY subrogada duplicada).
-- INSERT INTO clientes (id_cliente, nombre, correo) VALUES (1, 'Otro Cliente', 'otro@correo.com');
