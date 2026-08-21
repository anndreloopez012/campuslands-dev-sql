PRAGMA foreign_keys = ON;

-- Ejercicio 058: Viajes y Paracaidismo
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Ana Gomez', '5551001'),
    ('Luis Marroquin', '5551002'),
    ('Karen Solis', '5551003'),
    ('Diego Paz', '5551004'),
    ('Rosa Chavez', '5551005');

INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES
    ('Salto en Paracaidas Nivel 1', 'paracaidismo', 1500.00),
    ('Tour Volcanes Guatemala', 'turismo', 2200.00),
    ('Salto en Paracaidas Tandem', 'paracaidismo', 1800.00),
    ('Aventura Selva Peten', 'viaje', 3200.00),
    ('Ruta Cafetera', 'turismo', 950.00);

-- La reserva 10 es un duplicado por error de digitacion (mismo
-- cliente, experiencia, fecha y estado que la reserva 1): se corrige
-- en dml/operaciones.sql. La reserva 9 se cancelo sin llegar a
-- registrar ningun pago; la reserva 6 tambien se cancelo, pero si
-- tenia un deposito ya reembolsado.
INSERT INTO reservas (id_cliente, id_experiencia, fecha_reserva, estado) VALUES
    (1, 1, '2026-07-01', 'completada'),
    (2, 2, '2026-07-05', 'completada'),
    (3, 3, '2026-07-10', 'confirmada'),
    (4, 1, '2026-07-12', 'confirmada'),
    (5, 4, '2026-07-15', 'completada'),
    (1, 5, '2026-07-18', 'cancelada'),
    (1, 1, '2026-07-20', 'pendiente'),
    (2, 3, '2026-07-22', 'completada'),
    (3, 2, '2026-07-24', 'cancelada'),
    (1, 1, '2026-07-01', 'completada');

INSERT INTO pagos (id_reserva, monto, fecha_pago, estado) VALUES
    (1, 1500.00, '2026-07-01', 'completado'),
    (2, 2200.00, '2026-07-05', 'completado'),
    (3, 900.00, '2026-07-10', 'completado'),
    (4, 1500.00, '2026-07-12', 'completado'),
    (5, 3200.00, '2026-07-15', 'completado'),
    (6, 950.00, '2026-07-18', 'reembolsado'),
    (8, 1800.00, '2026-07-22', 'completado');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_experiencia ya existe, viola el UNIQUE.
-- INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES ('Tour Volcanes Guatemala', 'viaje', 2000.00);

-- 2) Valor fuera de rango: monto = 0 no es un pago valido, viola el CHECK.
-- INSERT INTO pagos (id_reserva, monto, fecha_pago) VALUES (4, 0, '2026-07-25');
