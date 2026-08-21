PRAGMA foreign_keys = ON;

-- Ejercicio 61: DEFAULT Nivel Aplicado
-- Datos de prueba: 5 clientes, 5 productos, 8 ventas.

-- clientes: se omiten tipo_cliente y fecha_registro en varios registros
-- para que se apliquen los DEFAULT ('regular' y date('now')).
INSERT INTO clientes (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com');

INSERT INTO clientes (nombre, correo, tipo_cliente) VALUES
    ('Byron Xicay', 'byron.xicay@correo.com', 'frecuente'),
    ('Cristina Barrios', 'cristina.barrios@correo.com', 'vip');

INSERT INTO clientes (nombre, correo, tipo_cliente, fecha_registro) VALUES
    ('Douglas Pineda', 'douglas.pineda@correo.com', 'regular', '2026-01-15');

-- productos: se omiten categoria y/o disponible para que apliquen los
-- DEFAULT ('bebida' y 1).
INSERT INTO productos (nombre, precio) VALUES
    ('Cafe Americano', 15.00),
    ('Capuchino', 18.50);

INSERT INTO productos (nombre, categoria, precio) VALUES
    ('Pastel de Chocolate', 'postre', 22.00),
    ('Papas Fritas', 'snack', 14.00);

INSERT INTO productos (nombre, categoria, precio, disponible) VALUES
    ('Te Helado', 'bebida', 12.00, 0);

-- ventas: se omiten cantidad, fecha_venta y/o estado para que apliquen
-- los DEFAULT (1, datetime('now') y 'pendiente').
INSERT INTO ventas (id_cliente, id_producto) VALUES
    (1, 1),
    (2, 3);

INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES
    (3, 2, 2),
    (4, 4, 3);

INSERT INTO ventas (id_cliente, id_producto, estado) VALUES
    (1, 3, 'pagada'),
    (5, 1, 'pagada');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta, estado) VALUES
    (3, 2, 1, '2026-08-19 10:00', 'pagada'),
    (4, 4, 2, '2026-08-20 12:30', 'cancelada');

-- Caso que debe fallar (queda comentado): cantidad = 0 viola el
-- CHECK (cantidad > 0), incluso usando el DEFAULT de estado.
-- INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES (1, 1, 0);
