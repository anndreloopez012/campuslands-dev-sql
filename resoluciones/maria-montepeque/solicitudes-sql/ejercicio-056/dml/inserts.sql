PRAGMA foreign_keys = ON;

-- Ejercicio 056: Renta Autos de Lujo
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, licencia_conducir) VALUES
    ('Alejandro Duarte', 'DL-88213'),
    ('Camila Rosales', 'DL-77104'),
    ('Esteban Marroquin', 'DL-65590'),
    ('Ligia Franco', 'DL-91832'),
    ('Roberto Sagastume', 'DL-54471');

INSERT INTO vehiculos (placa, modelo, tarifa_diaria) VALUES
    ('LUX101', 'Porsche 911', 3500.00),
    ('LUX102', 'Ferrari Roma', 4800.00),
    ('LUX103', 'Lamborghini Huracan', 5200.00),
    ('LUX104', 'Mercedes AMG GT', 3200.00),
    ('LUX105', 'Audi R8', 3900.00);

-- La reserva 10 es un duplicado por error de digitacion (mismo
-- cliente, vehiculo, fechas y estado que la reserva 1): se corrige
-- en dml/operaciones.sql.
INSERT INTO reservas (id_cliente, id_vehiculo, fecha_inicio, fecha_fin, estado) VALUES
    (1, 1, '2026-08-01', '2026-08-03', 'finalizada'),
    (2, 2, '2026-08-02', '2026-08-04', 'finalizada'),
    (3, 3, '2026-08-05', '2026-08-08', 'finalizada'),
    (1, 4, '2026-08-06', '2026-08-07', 'en_curso'),
    (4, 1, '2026-08-09', '2026-08-11', 'finalizada'),
    (5, 5, '2026-08-10', '2026-08-12', 'confirmada'),
    (2, 3, '2026-08-13', '2026-08-14', 'cancelada'),
    (3, 2, '2026-08-15', '2026-08-17', 'confirmada'),
    (1, 5, '2026-08-18', '2026-08-19', 'confirmada'),
    (1, 1, '2026-08-01', '2026-08-03', 'finalizada');

-- Pagos. El pago de la reserva 7 (cancelada) se reembolso: al estar
-- su reserva cancelada, se podra borrar de forma controlada. La
-- reserva 9 todavia no tiene pago registrado.
INSERT INTO pagos (id_reserva, monto, fecha_pago, metodo, estado) VALUES
    (1, 7000.00, '2026-08-01', 'tarjeta', 'completado'),
    (2, 9600.00, '2026-08-02', 'tarjeta', 'completado'),
    (3, 15600.00, '2026-08-05', 'transferencia', 'completado'),
    (4, 3200.00, '2026-08-06', 'efectivo', 'completado'),
    (5, 7000.00, '2026-08-09', 'tarjeta', 'completado'),
    (6, 7800.00, '2026-08-10', 'tarjeta', 'completado'),
    (7, 5200.00, '2026-08-13', 'tarjeta', 'reembolsado'),
    (8, 9600.00, '2026-08-15', 'transferencia', 'completado');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: la placa ya existe, viola el UNIQUE.
-- INSERT INTO vehiculos (placa, modelo, tarifa_diaria) VALUES ('LUX101', 'Porsche Cayman', 2800.00);

-- 2) Fechas invalidas: fecha_fin antes que fecha_inicio, viola el CHECK.
-- INSERT INTO reservas (id_cliente, id_vehiculo, fecha_inicio, fecha_fin) VALUES (2, 4, '2026-08-20', '2026-08-18');
