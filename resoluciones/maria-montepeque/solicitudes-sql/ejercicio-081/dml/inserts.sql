PRAGMA foreign_keys = ON;

-- Ejercicio 081: Renta Autos de Lujo
-- Datos base: 4 clientes, 4 vehiculos, 4 reservas (2 finalizadas con
-- pago, 1 en curso sin pago todavia, 1 reservada que se cancela con
-- una inspeccion cargada por error) y sus inspecciones/pagos.

INSERT INTO clientes (nombre_cliente, licencia, telefono) VALUES
    ('Manuel Estrada', 'LIC-2001', '5555-7001'),
    ('Alejandra Chinchilla', 'LIC-2002', '5555-7002'),
    ('Byron Xicay', 'LIC-2003', '5555-7003'),
    ('Cristina Barrios', 'LIC-2004', '5555-7004');

INSERT INTO vehiculos (modelo, placa, categoria, tarifa_diaria) VALUES
    ('Ferrari 488', 'LUX-001', 'deportivo', 1200.00),
    ('Lamborghini Huracan', 'LUX-002', 'deportivo', 1500.00),
    ('Rolls Royce Phantom', 'LUX-003', 'lujo', 2000.00),
    ('Mustang Convertible', 'LUX-004', 'convertible', 800.00);

-- Reserva 1: Manuel, Ferrari 488, 2 dias, finalizada.
INSERT INTO reservas (id_cliente, id_vehiculo, fecha_inicio, fecha_fin, estado) VALUES
    (1, 1, '2026-08-01', '2026-08-03', 'finalizada');
INSERT INTO inspecciones (id_reserva, tipo_inspeccion, estado_vehiculo) VALUES
    (1, 'entrega', 'Sin danos, tanque lleno'),
    (1, 'devolucion', 'Sin danos, tanque lleno');
INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES
    (1, 2400.00, 'tarjeta');

-- Reserva 2: Alejandra, Rolls Royce Phantom, 3 dias, finalizada.
INSERT INTO reservas (id_cliente, id_vehiculo, fecha_inicio, fecha_fin, estado) VALUES
    (2, 3, '2026-08-02', '2026-08-05', 'finalizada');
INSERT INTO inspecciones (id_reserva, tipo_inspeccion, estado_vehiculo) VALUES
    (2, 'entrega', 'Sin danos'),
    (2, 'devolucion', 'Rayon leve en puerta trasera');
INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES
    (2, 6000.00, 'transferencia');

-- Reserva 3: Byron, Lamborghini Huracan, 2 dias, en curso (todavia no
-- se devuelve, sin pago registrado todavia).
INSERT INTO reservas (id_cliente, id_vehiculo, fecha_inicio, fecha_fin, estado) VALUES
    (3, 2, '2026-08-06', '2026-08-08', 'en_curso');
INSERT INTO inspecciones (id_reserva, tipo_inspeccion, estado_vehiculo) VALUES
    (3, 'entrega', 'Sin danos, tanque lleno');

-- Reserva 4: Cristina, Mustang Convertible, todavia 'reservada'. Se
-- registro por error una inspeccion de entrega antes de que la
-- clienta llegara; ella cancelo la reserva antes de recoger el
-- vehiculo. Se corrige en dml/operaciones.sql.
INSERT INTO reservas (id_cliente, id_vehiculo, fecha_inicio, fecha_fin, estado) VALUES
    (4, 4, '2026-08-04', '2026-08-05', 'reservada');
INSERT INTO inspecciones (id_reserva, tipo_inspeccion, estado_vehiculo) VALUES
    (4, 'entrega', 'Sin danos, tanque lleno');

-- Caso comentado que debe fallar (queda comentado): registrar un
-- segundo pago para la reserva 1, exactamente el problema que
-- describio el cliente (pagos duplicados en la hoja de calculo). El
-- UNIQUE (id_reserva) en pagos lo bloquea.
-- INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES (1, 2400.00, 'tarjeta');
