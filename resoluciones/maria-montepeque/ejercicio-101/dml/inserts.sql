PRAGMA foreign_keys = ON;

-- Ejercicio 101: Procedimientos almacenados Nivel Basico
-- Datos de prueba: 3 productos con stock inicial, 4 ventas.
--
-- Cada INSERT en "ventas" dispara automaticamente el trigger
-- trg_actualizar_stock_venta (la alternativa ejecutable al
-- procedimiento almacenado), que descuenta el stock del producto
-- correspondiente sin necesidad de un UPDATE explicito aqui.

INSERT INTO productos (nombre_producto, precio_unitario, stock) VALUES
    ('Cafe Americano', 15.00, 50),
    ('Cafe Latte',      20.00, 30),
    ('Croissant',       12.00, 20);

INSERT INTO ventas (id_producto, nombre_cliente, cantidad, fecha_venta) VALUES
    (1, 'Sofia Martinez',   5, '2026-08-01'),
    (2, 'Pedro Ramirez',    3, '2026-08-02'),
    (1, 'Lucia Fernandez',  2, '2026-08-03'),
    (3, 'Mario Castillo',   4, '2026-08-04');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- venta con cantidad 0 o negativa. El CHECK (cantidad > 0) lo rechaza.
-- INSERT INTO ventas (id_producto, nombre_cliente, cantidad, fecha_venta) VALUES (1, 'Cliente Fantasma', 0, '2026-08-05');
