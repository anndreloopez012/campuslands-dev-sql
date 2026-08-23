PRAGMA foreign_keys = ON;

-- Ejercicio 002: Taller de Motos
-- Datos de prueba.

INSERT INTO motos (placa, marca, modelo, nombre_dueno) VALUES
    ('P001AAA', 'Honda', 'CB190R', 'Jorge Alvarado'),
    ('P002BBB', 'Yamaha', 'FZ25', 'Rosa Mendez'),
    ('P003CCC', 'Suzuki', 'GN125', 'Tomas Blanco'),
    ('P004DDD', 'Honda', 'XR150', 'Karla Diaz'),
    ('P005EEE', 'Bajaj', 'Pulsar200', 'Julio Perez');

-- Ordenes base. La orden 8 es una duplicada por error de digitacion (mismo
-- moto, servicio, mecanico, costo y fecha que la orden 2): se corrige en
-- dml/operaciones.sql.
INSERT INTO ordenes_trabajo (id_moto, descripcion_servicio, mecanico_asignado, costo, fecha_orden, estado) VALUES
    (1, 'Cambio de aceite y filtro', 'Pedro Ruiz', 150.00, '2026-08-01 09:00', 'completada'),
    (2, 'Revision de frenos', 'Ana Castillo', 220.00, '2026-08-02 10:30', 'completada'),
    (1, 'Ajuste de cadena', 'Pedro Ruiz', 80.00, '2026-08-05 11:00', 'en_proceso'),
    (3, 'Cambio de llantas', 'Luis Marin', 450.00, '2026-08-06 08:00', 'completada'),
    (4, 'Diagnostico electrico', 'Ana Castillo', 100.00, '2026-08-07 09:30', 'completada'),
    (5, 'Cambio de aceite y filtro', 'Pedro Ruiz', 150.00, '2026-08-08 10:00', 'cancelada'),
    (2, 'Pintura de tanque', 'Luis Marin', 300.00, '2026-08-09 14:00', 'completada'),
    (2, 'Revision de frenos', 'Ana Castillo', 220.00, '2026-08-02 10:30', 'completada'),
    (2, 'Cambio de bujias', 'Pedro Ruiz', 60.00, '2026-08-10 09:00', 'completada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- costo en cero o negativo, viola el CHECK de ordenes_trabajo.
-- INSERT INTO ordenes_trabajo (id_moto, descripcion_servicio, mecanico_asignado, costo) VALUES (1, 'Revision gratuita', 'Pedro Ruiz', 0);
