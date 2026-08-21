PRAGMA foreign_keys = ON;

-- Ejercicio 031: Renta Autos de Lujo
-- Datos de prueba.

INSERT INTO vehiculos (placa, marca, modelo, precio_dia, estado) VALUES
    ('LUX-001', 'Ferrari', '488 GTB', 1200.00, 'disponible'),
    ('LUX-002', 'Lamborghini', 'Huracan', 1400.00, 'disponible'),
    ('LUX-003', 'Porsche', '911 Carrera', 800.00, 'disponible'),
    ('LUX-004', 'Mercedes-Benz', 'AMG GT', 950.00, 'disponible'),
    ('LUX-005', 'Aston Martin', 'DB11', 1100.00, 'disponible');

INSERT INTO clientes (nombre_cliente, licencia) VALUES
    ('Jorge Alvarado', 'LIC-1001'),
    ('Rosa Mendez', 'LIC-1002'),
    ('Tomas Blanco', 'LIC-1003'),
    ('Karla Diaz', 'LIC-1004'),
    ('Julio Perez', 'LIC-1005');

-- La reserva 9 es una duplicada por error de digitacion (mismo
-- vehiculo, cliente, fechas y monto que la reserva 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO reservas (id_vehiculo, id_cliente, fecha_inicio, fecha_fin, monto_total, estado) VALUES
    (1, 1, '2026-08-10', '2026-08-12', 2400.00, 'finalizada'),
    (3, 2, '2026-08-11', '2026-08-14', 2400.00, 'finalizada'),
    (2, 3, '2026-08-15', '2026-08-17', 2800.00, 'en_curso'),
    (4, 4, '2026-08-16', '2026-08-18', 1900.00, 'confirmada'),
    (5, 5, '2026-08-18', '2026-08-20', 2200.00, 'confirmada'),
    (1, 2, '2026-08-20', '2026-08-21', 1200.00, 'cancelada'),
    (3, 1, '2026-08-22', '2026-08-23', 800.00, 'confirmada'),
    (2, 2, '2026-08-13', '2026-08-15', 1100.00, 'finalizada'),
    (1, 1, '2026-08-10', '2026-08-12', 2400.00, 'confirmada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_total en cero, viola el CHECK de reservas.
-- INSERT INTO reservas (id_vehiculo, id_cliente, fecha_inicio, fecha_fin, monto_total) VALUES (2, 3, '2026-08-25', '2026-08-26', 0);
