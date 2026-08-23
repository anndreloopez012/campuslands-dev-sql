PRAGMA foreign_keys = ON;

-- Ejercicio 054: Tienda Sneakers
-- Datos de prueba.

INSERT INTO productos (nombre_producto, marca, precio) VALUES
    ('Air Max Pulse', 'Nike', 450.00),
    ('Ultraboost 22', 'Adidas', 520.00),
    ('Suede Classic', 'Puma', 320.00),
    ('550 Retro', 'New Balance', 480.00),
    ('Old Skool', 'Vans', 280.00);

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Fabiola Mendez', '5621234'),
    ('Sergio Barrios', '5627890'),
    ('Ninoska Tul', '5622345'),
    ('Cristian Lopez', '5623456'),
    ('Yesica Morataya', '5624567');

INSERT INTO tallas (id_producto, numero_talla, stock) VALUES
    (1, 25, 10),
    (1, 26, 5),
    (2, 24, 8),
    (2, 27, 3),
    (3, 23, 12),
    (3, 25, 6),
    (4, 26, 4),
    (5, 24, 15),
    (5, 27, 2),
    (1, 27, 0);

-- El pedido 11 es un duplicado por error de digitacion (mismo
-- cliente, talla, fecha, cantidad y estado que el pedido 1): se
-- corrige en dml/operaciones.sql. El pedido 7 se cancelo antes de
-- confirmarse (nunca descontó stock, stock_descontado = 0); el
-- pedido 8 se cancelo despues de confirmarse (ya habia descontado
-- stock, stock_descontado = 1). El pedido 9 pide la talla 27 de Air
-- Max Pulse, que esta agotada (stock = 0).
INSERT INTO pedidos (id_cliente, id_talla, fecha_pedido, cantidad, estado, stock_descontado) VALUES
    (1, 1, '2026-08-01', 1, 'enviado', 1),
    (2, 3, '2026-08-02', 2, 'enviado', 1),
    (3, 5, '2026-08-03', 1, 'confirmado', 1),
    (4, 7, '2026-08-04', 1, 'pendiente', 0),
    (1, 8, '2026-08-05', 2, 'enviado', 1),
    (5, 9, '2026-08-06', 1, 'pendiente', 0),
    (2, 2, '2026-08-07', 1, 'cancelado', 0),
    (3, 4, '2026-08-08', 1, 'cancelado', 1),
    (4, 10, '2026-08-09', 1, 'pendiente', 0),
    (1, 6, '2026-08-10', 1, 'pendiente', 0),
    (1, 1, '2026-08-01', 1, 'enviado', 1);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: la talla 25 ya existe para el producto 1, viola el UNIQUE compuesto.
-- INSERT INTO tallas (id_producto, numero_talla, stock) VALUES (1, 25, 20);

-- 2) Valor fuera de rango: numero_talla = 50 no es una talla valida, viola el CHECK.
-- INSERT INTO tallas (id_producto, numero_talla, stock) VALUES (2, 50, 5);
