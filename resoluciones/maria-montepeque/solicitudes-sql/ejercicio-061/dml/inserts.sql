PRAGMA foreign_keys = ON;

-- Ejercicio 061: Delivery de Comida
-- Datos base: 5 clientes, 5 platillos, 4 repartidores, 10 pedidos, 7 pagos.

INSERT INTO clientes (nombre, telefono, direccion) VALUES
    ('Manuel Estrada', '5555-1001', 'Zona 1, Ciudad de Guatemala'),
    ('Alejandra Chinchilla', '5555-1002', 'Zona 10, Ciudad de Guatemala'),
    ('Byron Xicay', '5555-1003', 'Zona 7, Ciudad de Guatemala'),
    ('Cristina Barrios', '5555-1004', 'Zona 15, Ciudad de Guatemala'),
    ('Douglas Pineda', '5555-1005', 'Zona 11, Ciudad de Guatemala');

INSERT INTO menus (nombre_platillo, restaurante, precio) VALUES
    ('Hamburguesa Clasica', 'Burger Point', 45.00),
    ('Pizza Familiar', 'Pizza Nostra', 95.00),
    ('Pollo Frito Combo', 'Pollo Real', 55.00),
    ('Sushi Mixto', 'Sakura Sushi', 120.00),
    ('Tacos al Pastor', 'Tacos Don Beto', 38.00);

INSERT INTO repartidores (nombre, placa_vehiculo) VALUES
    ('Sergio Lopez', 'M-001AAA'),
    ('Fernanda Castillo', 'M-002BBB'),
    ('Kevin Morales', 'M-003CCC');

-- Repartidor con calificacion explicita distinta al DEFAULT.
INSERT INTO repartidores (nombre, placa_vehiculo, calificacion_promedio) VALUES
    ('Ana Lucia Reyes', 'M-004DDD', 4.6);

-- pedidos: algunos sin repartidor asignado todavia (estado 'pendiente').
INSERT INTO pedidos (id_cliente, id_menu, id_repartidor, cantidad, estado) VALUES
    (1, 1, 1, 2, 'entregado'),
    (2, 2, 2, 1, 'entregado'),
    (3, 3, 1, 1, 'entregado'),
    (4, 4, 3, 1, 'en_camino'),
    (5, 5, 2, 3, 'entregado'),
    (1, 2, 3, 1, 'entregado'),
    (2, 3, NULL, 2, 'pendiente'),
    (3, 1, NULL, 1, 'pendiente'),
    (4, 5, 1, 2, 'cancelado'),
    (5, 4, 4, 1, 'entregado');

-- pagos: uno por pedido ya facturado (no se pagan pedidos pendientes ni cancelados).
INSERT INTO pagos (id_pedido, monto, metodo_pago, estado_pago) VALUES
    (1, 90.00, 'efectivo', 'pagado'),
    (2, 95.00, 'tarjeta', 'pagado'),
    (3, 55.00, 'app', 'pagado'),
    (5, 114.00, 'app', 'pagado'),
    (6, 95.00, 'tarjeta', 'pagado'),
    (10, 120.00, 'efectivo', 'pagado');

-- Pago de un pedido todavia en camino, registrado como pendiente.
INSERT INTO pagos (id_pedido, monto, metodo_pago) VALUES
    (4, 120.00, 'tarjeta');

-- Caso que debe fallar (queda comentado): un segundo pago para el mismo
-- pedido viola UNIQUE (id_pedido) en pagos.
-- INSERT INTO pagos (id_pedido, monto, metodo_pago) VALUES (1, 90.00, 'efectivo');
