PRAGMA foreign_keys = ON;

-- Ejercicio 014: Mecanica de Autos
-- Datos de prueba (una semana: 2026-08-10 a 2026-08-16).

INSERT INTO vehiculos (placa, marca, modelo, nombre_dueno) VALUES
    ('P111AAA', 'Toyota', 'Corolla', 'Jorge Alvarado'),
    ('P222BBB', 'Honda', 'Civic', 'Rosa Mendez'),
    ('P333CCC', 'Nissan', 'Sentra', 'Tomas Blanco'),
    ('P444DDD', 'Ford', 'Focus', 'Karla Diaz'),
    ('P555EEE', 'Chevrolet', 'Spark', 'Julio Perez');

-- La reparacion 9 es una entrada de prueba (diagnostico "Entrada de
-- prueba") que se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO reparaciones (id_vehiculo, diagnostico, costo, fecha_reparacion, garantia_dias, estado) VALUES
    (1, 'Cambio de frenos', 450.00, '2026-08-10 09:00', 30, 'completada'),
    (2, 'Diagnostico de motor', 200.00, '2026-08-11 10:00', 15, 'completada'),
    (3, 'Cambio de bateria', 350.00, '2026-08-11 14:00', 90, 'completada'),
    (1, 'Alineacion y balanceo', 180.00, '2026-08-12 08:30', 30, 'en_proceso'),
    (4, 'Cambio de aceite', 120.00, '2026-08-13 11:00', 30, 'completada'),
    (5, 'Reparacion de transmision', 1200.00, '2026-08-14 09:00', 60, 'cancelada'),
    (2, 'Cambio de llantas', 800.00, '2026-08-15 10:00', 90, 'completada'),
    (3, 'Revision electrica', 150.00, '2026-08-16 12:00', 15, 'en_proceso'),
    (1, 'Entrada de prueba', 450.00, '2026-08-10 09:00', 30, 'en_proceso');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- costo en cero, viola el CHECK de reparaciones.
-- INSERT INTO reparaciones (id_vehiculo, diagnostico, costo) VALUES (2, 'Revision gratuita', 0);
