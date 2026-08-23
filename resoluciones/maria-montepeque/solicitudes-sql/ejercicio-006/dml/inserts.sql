PRAGMA foreign_keys = ON;

-- Ejercicio 006: Renta Autos de Lujo
-- Datos de prueba.

INSERT INTO vehiculos (marca, modelo, placa, precio_dia, estado) VALUES
    ('Ferrari', '488 GTB', 'LUX-001', 1200.00, 'disponible'),
    ('Lamborghini', 'Huracan', 'LUX-002', 1400.00, 'disponible'),
    ('Porsche', '911 Carrera', 'LUX-003', 800.00, 'disponible'),
    ('Mercedes-Benz', 'AMG GT', 'LUX-004', 950.00, 'disponible'),
    ('Aston Martin', 'DB11', 'LUX-005', 1100.00, 'disponible');

-- La reserva 8 es una entrada de prueba (cliente "Cuenta de Prueba") que
-- se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO reservas (id_vehiculo, nombre_cliente, fecha_inicio, fecha_fin, monto_total, estado) VALUES
    (1, 'Jorge Alvarado', '2026-08-10', '2026-08-12', 2400.00, 'finalizada'),
    (3, 'Rosa Mendez', '2026-08-11', '2026-08-14', 2400.00, 'finalizada'),
    (2, 'Tomas Blanco', '2026-08-15', '2026-08-17', 2800.00, 'en_curso'),
    (4, 'Karla Diaz', '2026-08-16', '2026-08-18', 1900.00, 'confirmada'),
    (5, 'Julio Perez', '2026-08-18', '2026-08-20', 2200.00, 'confirmada'),
    (1, 'Rosa Mendez', '2026-08-20', '2026-08-21', 1200.00, 'cancelada'),
    (3, 'Jorge Alvarado', '2026-08-22', '2026-08-23', 800.00, 'confirmada'),
    (1, 'Cuenta de Prueba', '2026-08-10', '2026-08-12', 2400.00, 'confirmada'),
    (4, 'Jorge Alvarado', '2026-08-24', '2026-08-25', 950.00, 'confirmada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_total en cero, viola el CHECK de reservas.
-- INSERT INTO reservas (id_vehiculo, nombre_cliente, fecha_inicio, fecha_fin, monto_total) VALUES (2, 'Diego Paz', '2026-08-26', '2026-08-27', 0);
