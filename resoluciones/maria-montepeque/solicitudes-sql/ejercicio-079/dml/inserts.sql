PRAGMA foreign_keys = ON;

-- Ejercicio 079: Tienda Sneakers
-- Datos base: 4 clientes, 4 productos, 5 tallas, 4 pedidos (2
-- entregados, 1 enviado, 1 pendiente con una linea cargada por error)
-- y sus lineas de detalle.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-5001'),
    ('Alejandra Chinchilla', '5555-5002'),
    ('Byron Xicay', '5555-5003'),
    ('Cristina Barrios', '5555-5004');

INSERT INTO productos (nombre_producto, marca) VALUES
    ('Air Max 90', 'Nike'),
    ('Superstar', 'Adidas'),
    ('Chuck Taylor', 'Converse'),
    ('Ultraboost', 'Adidas');

INSERT INTO tallas (numero_talla) VALUES
    ('38'), ('39'), ('40'), ('41'), ('42');

-- Pedido 1: Manuel, entregado.
INSERT INTO pedidos (id_cliente, estado) VALUES
    (1, 'entregado');
INSERT INTO detalle_pedidos (id_pedido, id_producto, id_talla, cantidad, precio_unitario) VALUES
    (1, 1, 3, 1, 650.00),
    (1, 3, 3, 1, 380.00);

-- Pedido 2: Alejandra, entregado.
INSERT INTO pedidos (id_cliente, estado) VALUES
    (2, 'entregado');
INSERT INTO detalle_pedidos (id_pedido, id_producto, id_talla, cantidad, precio_unitario) VALUES
    (2, 2, 2, 1, 480.00),
    (2, 4, 2, 1, 720.00);

-- Pedido 3: Byron, enviado.
INSERT INTO pedidos (id_cliente, estado) VALUES
    (3, 'enviado');
INSERT INTO detalle_pedidos (id_pedido, id_producto, id_talla, cantidad, precio_unitario) VALUES
    (3, 1, 4, 2, 650.00);

-- Pedido 4: Cristina, todavia pendiente. Se agrego por error un
-- Ultraboost talla 41 que la clienta no pidio; se corrige con DELETE
-- en dml/operaciones.sql mientras el pedido sigue pendiente (todavia
-- sin confirmar, es seguro corregirlo).
INSERT INTO pedidos (id_cliente, estado) VALUES
    (4, 'pendiente');
INSERT INTO detalle_pedidos (id_pedido, id_producto, id_talla, cantidad, precio_unitario) VALUES
    (4, 2, 1, 1, 480.00),
    (4, 4, 4, 1, 720.00);

-- Caso comentado que debe fallar (queda comentado): registrar de
-- nuevo Air Max 90 talla 3 como otra linea separada en el pedido 1,
-- exactamente el problema que este UNIQUE esta disenado para evitar.
-- INSERT INTO detalle_pedidos (id_pedido, id_producto, id_talla, cantidad, precio_unitario) VALUES (1, 1, 3, 1, 650.00);
