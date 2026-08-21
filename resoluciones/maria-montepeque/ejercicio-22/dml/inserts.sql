-- Ejercicio 22: Pedidos Delivery
-- Datos base: 5 clientes, 5 restaurantes, 5 repartidores, 10 pedidos

INSERT INTO clientes (nombre, telefono, direccion) VALUES
    ('Manuel Estrada', '5044-1001', 'Zona 1, Ciudad de Guatemala'),
    ('Alejandra Chinchilla', '5044-1002', 'Zona 10, Ciudad de Guatemala'),
    ('Byron Xicay', '5044-1003', 'Zona 7, Ciudad de Guatemala'),
    ('Cristina Barrios', '5044-1004', 'Zona 15, Ciudad de Guatemala'),
    ('Douglas Pineda', '5044-1005', 'Zona 11, Ciudad de Guatemala');

INSERT INTO restaurantes (nombre, categoria) VALUES
    ('Pollo Real', 'Pollo frito'),
    ('Pizza Vesuvio', 'Pizza'),
    ('Sushi Kanji', 'Comida japonesa'),
    ('Tacos El Compadre', 'Comida mexicana'),
    ('Cafe Campus', 'Cafeteria');

INSERT INTO repartidores (nombre, telefono, vehiculo) VALUES
    ('Jorge Lemus', '5044-2001', 'moto'),
    ('Fernanda Ruiz', '5044-2002', 'moto'),
    ('Hector Aguilar', '5044-2003', 'bicicleta'),
    ('Paola Sandoval', '5044-2004', 'carro'),
    ('Ricardo Solis', '5044-2005', 'moto');

INSERT INTO pedidos (id_cliente, id_restaurante, id_repartidor, total, estado, fecha) VALUES
    (1, 1, 1, 85.00, 'entregado', '2026-07-01 12:30'),
    (1, 3, 2, 150.00, 'entregado', '2026-07-05 19:00'),
    (2, 2, 3, 120.00, 'entregado', '2026-07-02 13:00'),
    (2, 4, 1, 65.00, 'en_camino', '2026-07-08 20:15'),
    (3, 1, 4, 90.00, 'entregado', '2026-07-03 12:45'),
    (3, 5, 5, 30.00, 'pendiente', '2026-07-09 08:30'),
    (4, 3, 2, 175.00, 'entregado', '2026-07-04 19:30'),
    (4, 2, 3, 110.00, 'cancelado', '2026-07-10 14:00'),
    (5, 4, 1, 70.00, 'entregado', '2026-07-05 13:15'),
    (5, 5, 5, 25.00, 'entregado', '2026-07-11 09:00');
