PRAGMA foreign_keys = ON;

-- Ejercicio 076: Cafeteria Campus
-- Datos base: 5 productos, 4 clientes, 4 ventas (2 cerradas con pago
-- desde el inicio, 1 abierta que se cierra despues, 1 abierta con una
-- linea cargada por error que se corrige antes de cerrarla) y sus
-- lineas de detalle.

INSERT INTO productos (nombre_producto, precio, categoria) VALUES
    ('Cafe Americano', 15.00, 'bebida'),
    ('Te Helado', 12.00, 'bebida'),
    ('Sandwich Jamon', 35.00, 'comida'),
    ('Muffin Chocolate', 18.00, 'comida'),
    ('Papas Fritas', 20.00, 'snack');

INSERT INTO clientes (nombre_cliente, carnet_estudiante) VALUES
    ('Manuel Estrada', 'CAR-1001'),
    ('Alejandra Chinchilla', 'CAR-1002'),
    ('Byron Xicay', 'CAR-1003'),
    ('Cristina Barrios', 'CAR-1004');

-- Venta 1: Manuel, ya cerrada y pagada.
INSERT INTO ventas (id_cliente, estado) VALUES
    (1, 'cerrada');
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
    (1, 1, 2, 15.00),
    (1, 4, 1, 18.00);
INSERT INTO pagos (id_venta, monto, metodo_pago) VALUES
    (1, 48.00, 'efectivo');

-- Venta 2: Alejandra, ya cerrada y pagada.
INSERT INTO ventas (id_cliente, estado) VALUES
    (2, 'cerrada');
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
    (2, 3, 1, 35.00),
    (2, 5, 2, 20.00);
INSERT INTO pagos (id_venta, monto, metodo_pago) VALUES
    (2, 75.00, 'tarjeta');

-- Venta 3: Byron, todavia abierta. Se cierra y se paga en
-- dml/operaciones.sql.
INSERT INTO ventas (id_cliente, estado) VALUES
    (3, 'abierta');
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
    (3, 2, 1, 12.00),
    (3, 5, 1, 20.00);

-- Venta 4: Cristina, todavia abierta. Se agrego por error un
-- Sandwich Jamon que la clienta no pidio; se corrige con DELETE en
-- dml/operaciones.sql mientras la venta sigue abierta (sin pago
-- todavia, es seguro corregirla).
INSERT INTO ventas (id_cliente, estado) VALUES
    (4, 'abierta');
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
    (4, 1, 1, 15.00),
    (4, 3, 1, 35.00);

-- Caso comentado que debe fallar (queda comentado): registrar de
-- nuevo Cafe Americano como otra linea separada en la venta 1,
-- exactamente el problema que este UNIQUE esta disenado para evitar.
-- INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES (1, 1, 1, 15.00);
