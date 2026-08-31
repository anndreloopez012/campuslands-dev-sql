PRAGMA foreign_keys = ON;

-- Ejercicio 086: Delivery de Comida
-- Datos base: 4 clientes, 5 platillos, 2 repartidores, 5 pedidos (2
-- entregados con pago, 1 en camino sin pago, 1 marcado entregado por
-- error con un pago que se corrige, 1 recibido) y sus pagos.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-8801'),
    ('Alejandra Chinchilla', '5555-8802'),
    ('Byron Xicay', '5555-8803'),
    ('Cristina Barrios', '5555-8804');

INSERT INTO menus (nombre_platillo, precio, categoria) VALUES
    ('Hamburguesa Clasica', 45.00, 'comida'),
    ('Pizza Pepperoni', 60.00, 'comida'),
    ('Gaseosa', 12.00, 'bebida'),
    ('Flan de Caramelo', 20.00, 'postre'),
    ('Tacos al Pastor', 35.00, 'comida');

INSERT INTO repartidores (nombre_repartidor, vehiculo) VALUES
    ('Hugo Marroquin', 'motocicleta'),
    ('Esteban Cifuentes', 'bicicleta');

-- Pedido 1: Manuel, Hamburguesa Clasica x2, entregado.
INSERT INTO pedidos (id_cliente, id_menu, id_repartidor, cantidad, estado) VALUES
    (1, 1, 1, 2, 'entregado');
INSERT INTO pagos (id_pedido, monto, metodo_pago) VALUES
    (1, 90.00, 'tarjeta');

-- Pedido 2: Alejandra, Pizza Pepperoni x1, entregado.
INSERT INTO pedidos (id_cliente, id_menu, id_repartidor, cantidad, estado) VALUES
    (2, 2, 2, 1, 'entregado');
INSERT INTO pagos (id_pedido, monto, metodo_pago) VALUES
    (2, 60.00, 'efectivo');

-- Pedido 3: Byron, Gaseosa x3, en camino (todavia sin pago).
INSERT INTO pedidos (id_cliente, id_menu, id_repartidor, cantidad, estado) VALUES
    (3, 3, 1, 3, 'en_camino');

-- Pedido 4: Cristina, Tacos al Pastor x2. Se marco 'entregado' y se
-- proceso el pago, pero despues se confirmo que la clienta cancelo el
-- pedido antes de que saliera el repartidor. Se corrige en
-- dml/operaciones.sql.
INSERT INTO pedidos (id_cliente, id_menu, id_repartidor, cantidad, estado) VALUES
    (4, 5, 2, 2, 'entregado');
INSERT INTO pagos (id_pedido, monto, metodo_pago) VALUES
    (4, 70.00, 'tarjeta');

-- Pedido 5: Manuel, Flan de Caramelo x1, recien recibido.
INSERT INTO pedidos (id_cliente, id_menu, id_repartidor, cantidad, estado) VALUES
    (1, 4, 1, 1, 'recibido');

-- Caso comentado que debe fallar (queda comentado): registrar un
-- segundo pago para el pedido 1, exactamente el tipo de dato
-- duplicado que este UNIQUE esta disenado para evitar.
-- INSERT INTO pagos (id_pedido, monto, metodo_pago) VALUES (1, 90.00, 'tarjeta');
