PRAGMA foreign_keys = ON;

-- Ejercicio 79: DELETE Nivel Aplicado
-- Caso de negocio: se registra un dia completo de ventas, se
-- corrigen dos problemas reales con DELETE, y la consulta 5 en
-- dql/consultas.sql es el reporte final que confirma que los totales
-- diarios ya quedaron correctos.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-4001'),
    ('Alejandra Chinchilla', '5555-4002'),
    ('Byron Xicay', '5555-4003'),
    ('Cristina Barrios', '5555-4004');

INSERT INTO productos (nombre_producto, precio) VALUES
    ('Cafe Americano', 15.00),
    ('Cappuccino', 20.00),
    ('Te Chai', 12.00),
    ('Croissant', 18.00);

-- Ventas del 2026-08-01 (dia valido).
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-08-01'),
    (2, 2, 1, '2026-08-01'),
    (3, 3, 3, '2026-08-01'),
    (1, 4, 1, '2026-08-01'),
    (4, 1, 1, '2026-08-01');

-- Venta duplicada: la cajera escaneo dos veces el mismo Cafe
-- Americano de Manuel Estrada.
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-08-01');

-- Ventas del 2026-08-02: la caja registradora fallo y duplico cada
-- cobro de ese dia completo. Se anulan todas juntas.
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (2, 2, 2, '2026-08-02'),
    (3, 1, 1, '2026-08-02'),
    (4, 3, 2, '2026-08-02'),
    (1, 4, 1, '2026-08-02');

-- 1. DELETE de una sola fila: se elimina la venta duplicada del Cafe
-- Americano de Manuel Estrada, con WHERE por id especifico.
DELETE FROM ventas
WHERE id_venta = 6;

-- 2. DELETE multiple: se anula de una sola vez todo el dia
-- 2026-08-02, con un solo DELETE y un WHERE por fecha (no un id a la
-- vez).
DELETE FROM ventas
WHERE fecha_venta = '2026-08-02';

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: intentar el DELETE fisico de un producto que todavia
-- tiene ventas asociadas. SQLite, con PRAGMA foreign_keys = ON, no lo
-- permite mientras existan ventas del 2026-08-01 que dependan de el.
-- DELETE FROM productos WHERE id_producto = 1;
