PRAGMA foreign_keys = ON;

-- Ejercicio 63: AUTO_INCREMENT Nivel Intermedio
-- Datos de prueba: 3 clientes, 3 productos, ventas relacionadas.
-- Ningun INSERT indica el id: lo genera AUTOINCREMENT en las 3 tablas.

INSERT INTO clientes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-2001'),
    ('Alejandra Chinchilla', '5555-2002'),
    ('Byron Xicay', '5555-2003');

INSERT INTO productos (nombre, precio) VALUES
    ('Cafe Americano', 15.00),
    ('Capuchino', 18.50),
    ('Pastel de Chocolate', 22.00);

INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES
    (1, 1, 2),
    (2, 2, 1),
    (3, 3, 1),
    (1, 2, 1),
    (2, 1, 3);
-- ids esperados 1..5, asignados automaticamente por AUTOINCREMENT.

-- Se elimina la venta 3 (Byron Xicay, Pastel de Chocolate) para
-- demostrar que AUTOINCREMENT nunca reutiliza un id ya usado.
DELETE FROM ventas WHERE id_venta = 3;

-- Nueva venta: SQLite le asigna el id 6, NO el id 3 que quedo libre.
INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES
    (3, 3, 2);

-- Caso que debe fallar (queda comentado): referenciar un producto que no
-- existe viola la FOREIGN KEY de ventas.id_producto.
-- INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES (1, 999, 1);
