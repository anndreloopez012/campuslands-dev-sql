-- Ejercicio 15: Taller de Motos
-- Datos base: 5 clientes, 5 motos, 5 servicios, 10 ordenes de servicio

INSERT INTO clientes (nombre, telefono, correo) VALUES
    ('Manuel Estrada', '5022-1001', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', '5022-1002', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', '5022-1003', 'byron.xicay@correo.com'),
    ('Cristina Barrios', '5022-1004', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', '5022-1005', 'douglas.pineda@correo.com');

INSERT INTO motos (id_cliente, placa, marca, anio) VALUES
    (1, 'P001BCD', 'Yamaha', 2019),
    (2, 'P002BCD', 'Honda', 2021),
    (3, 'P003BCD', 'Suzuki', 2018),
    (4, 'P004BCD', 'Bajaj', 2022),
    (5, 'P005BCD', 'Honda', 2020);

INSERT INTO servicios (nombre, precio) VALUES
    ('Cambio de aceite', 150.00),
    ('Ajuste de frenos', 200.00),
    ('Cambio de llantas', 450.00),
    ('Revision general', 300.00),
    ('Cambio de bateria', 250.00);

INSERT INTO ordenes_servicio (id_moto, id_servicio, fecha, estado, costo) VALUES
    (1, 1, '2026-07-01', 'completado', 150.00),
    (1, 2, '2026-07-15', 'completado', 200.00),
    (2, 3, '2026-07-02', 'completado', 450.00),
    (2, 4, '2026-07-20', 'pendiente', 300.00),
    (3, 1, '2026-07-03', 'completado', 150.00),
    (3, 5, '2026-07-18', 'en_proceso', 250.00),
    (4, 4, '2026-07-04', 'completado', 300.00),
    (4, 2, '2026-07-22', 'pendiente', 200.00),
    (5, 1, '2026-07-05', 'completado', 150.00),
    (5, 3, '2026-07-25', 'en_proceso', 450.00);
