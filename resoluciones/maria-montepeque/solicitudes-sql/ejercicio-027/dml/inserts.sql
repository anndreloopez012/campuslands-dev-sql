PRAGMA foreign_keys = ON;

-- Ejercicio 027: Taller de Motos
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Jorge Alvarado', '5553001'),
    ('Rosa Mendez', '5553002'),
    ('Tomas Blanco', '5553003'),
    ('Karla Diaz', '5553004'),
    ('Julio Perez', '5553005');

INSERT INTO motos (id_cliente, placa, marca, modelo) VALUES
    (1, 'P001AAA', 'Honda', 'CB190R'),
    (2, 'P002BBB', 'Yamaha', 'FZ25'),
    (3, 'P003CCC', 'Suzuki', 'GN125'),
    (4, 'P004DDD', 'Honda', 'XR150'),
    (5, 'P005EEE', 'Bajaj', 'Pulsar200');

-- La orden 9 es una duplicada por error de digitacion (misma moto,
-- servicio, mecanico, costo y fecha que la orden 1): se corrige en
-- dml/operaciones.sql. Es la unica fila que se elimina; el resto de
-- casos especiales se resuelven corrigiendo el estado, no borrando.
INSERT INTO ordenes_servicio (id_moto, descripcion_servicio, mecanico_asignado, costo, fecha_orden, estado) VALUES
    (1, 'Cambio de aceite y filtro', 'Pedro Ruiz', 150.00, '2026-08-01 09:00', 'completada'),
    (2, 'Revision de frenos', 'Ana Castillo', 220.00, '2026-08-02 10:30', 'completada'),
    (1, 'Ajuste de cadena', 'Pedro Ruiz', 80.00, '2026-08-05 11:00', 'en_proceso'),
    (3, 'Cambio de llantas', 'Luis Marin', 450.00, '2026-08-06 08:00', 'completada'),
    (4, 'Diagnostico electrico', 'Ana Castillo', 100.00, '2026-08-07 09:30', 'completada'),
    (5, 'Cambio de aceite y filtro', 'Pedro Ruiz', 150.00, '2026-08-08 10:00', 'cancelada'),
    (2, 'Pintura de tanque', 'Luis Marin', 300.00, '2026-08-09 14:00', 'completada'),
    (3, 'Revision electrica', 'Ana Castillo', 120.00, '2026-08-10 09:00', 'en_proceso'),
    (1, 'Cambio de aceite y filtro', 'Pedro Ruiz', 150.00, '2026-08-01 09:00', 'completada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- costo en cero, viola el CHECK de ordenes_servicio.
-- INSERT INTO ordenes_servicio (id_moto, descripcion_servicio, mecanico_asignado, costo) VALUES (1, 'Revision gratuita', 'Pedro Ruiz', 0);
