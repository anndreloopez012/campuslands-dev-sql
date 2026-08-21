PRAGMA foreign_keys = ON;

-- Ejercicio 029: Tienda Sneakers
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Ana Gomez', 'ana.gomez@correo.com'),
    ('Luis Marroquin', 'luis.marroquin@correo.com'),
    ('Karen Solis', 'karen.solis@correo.com'),
    ('Diego Paz', 'diego.paz@correo.com'),
    ('Rosa Chavez', 'rosa.chavez@correo.com');

INSERT INTO pedidos (id_cliente, nombre_modelo, talla, precio) VALUES
    (1, 'Air Max 90', 38, 450.00),
    (2, 'Ultraboost 22', 39, 520.00),
    (3, 'Jordan Retro 1', 41, 680.00),
    (4, 'Chuck Taylor All Star', 37, 320.00),
    (5, 'Yeezy Boost 350', 42, 750.00);

-- El evento 8 (pedido 4) queda 'anulado' temporalmente en espera de
-- confirmar stock: se corrige en dml/operaciones.sql. El evento 10 es
-- una entrada de prueba (comentario "Entrada de prueba") que se cargo
-- por error: tambien se elimina en operaciones. Es la unica fila del
-- historico que se borra.
INSERT INTO eventos_pedido (id_pedido, tipo_evento, fecha_evento, estado, comentario) VALUES
    (1, 'creado', '2026-08-01 10:00', 'valido', 'Pedido registrado'),
    (1, 'pagado', '2026-08-01 10:15', 'valido', 'Pago confirmado con tarjeta'),
    (2, 'creado', '2026-08-02 11:00', 'valido', 'Pedido registrado'),
    (2, 'pagado', '2026-08-02 11:20', 'valido', 'Pago confirmado'),
    (1, 'enviado', '2026-08-03 09:00', 'valido', 'Enviado por paqueteria'),
    (3, 'creado', '2026-08-04 12:00', 'valido', 'Pedido registrado'),
    (1, 'entregado', '2026-08-05 15:00', 'valido', 'Entregado al cliente'),
    (4, 'creado', '2026-08-06 10:30', 'anulado', 'Pedido registrado, en espera de confirmar stock'),
    (5, 'creado', '2026-08-07 09:00', 'valido', 'Pedido registrado'),
    (1, 'creado', '2026-08-01 10:00', 'valido', 'Entrada de prueba');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- tipo_evento fuera de la lista permitida por el CHECK de eventos_pedido.
-- INSERT INTO eventos_pedido (id_pedido, tipo_evento, estado) VALUES (2, 'extraviado', 'valido');
