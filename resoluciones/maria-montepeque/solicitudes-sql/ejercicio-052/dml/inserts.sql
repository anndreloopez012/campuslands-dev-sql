PRAGMA foreign_keys = ON;

-- Ejercicio 052: Taller de Motos
-- Datos de prueba.

INSERT INTO mecanicos (nombre_mecanico, especialidad) VALUES
    ('Tono Reyes', 'motor'),
    ('Kimberly Sac', 'frenos'),
    ('Marvin Us', 'electrico'),
    ('Elena Poou', 'general');

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Herminio Coy', '5611234'),
    ('Paulina Xicay', '5617890'),
    ('Rodrigo Batres', '5612345'),
    ('Susana Lemus', '5613456'),
    ('Wilmer Chiquin', '5614567');

-- La orden 10 es un duplicado por error de digitacion (mismo
-- cliente, mecanico, placa, fecha, costo y estado que la orden 1): se
-- corrige en dml/operaciones.sql. La orden 7 se cancelo despues de
-- cargar un repuesto; ese repuesto se eliminara de forma controlada.
INSERT INTO ordenes_servicio (id_cliente, id_mecanico, placa_moto, fecha_orden, costo_mano_obra, estado) VALUES
    (1, 1, 'M001ABC', '2026-08-01', 350.00, 'entregado'),
    (2, 2, 'M002DEF', '2026-08-02', 200.00, 'entregado'),
    (3, 3, 'M003GHI', '2026-08-04', 280.00, 'listo'),
    (4, 1, 'M004JKL', '2026-08-05', 450.00, 'en_reparacion'),
    (1, 4, 'M005MNO', '2026-08-07', 150.00, 'recibida'),
    (5, 2, 'M006PQR', '2026-08-08', 300.00, 'entregado'),
    (2, 3, 'M007STU', '2026-08-10', 220.00, 'cancelada'),
    (3, 1, 'M008VWX', '2026-08-11', 380.00, 'en_reparacion'),
    (1, 4, 'M009YZA', '2026-08-13', 180.00, 'recibida'),
    (1, 1, 'M001ABC', '2026-08-01', 350.00, 'entregado');

INSERT INTO repuestos_usados (id_orden, nombre_repuesto, cantidad, costo_unitario) VALUES
    (1, 'Pastillas de freno', 2, 45.00),
    (1, 'Aceite de motor', 1, 60.00),
    (2, 'Bujia', 4, 15.00),
    (3, 'Cable de embrague', 1, 35.00),
    (4, 'Kit de piston', 1, 220.00),
    (4, 'Junta de culata', 1, 40.00),
    (6, 'Cadena de transmision', 1, 180.00),
    (7, 'Bateria', 1, 150.00),
    (8, 'Disco de freno', 2, 55.00);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_mecanico ya existe, viola el UNIQUE.
-- INSERT INTO mecanicos (nombre_mecanico, especialidad) VALUES ('Tono Reyes', 'general');

-- 2) Valor fuera de rango: cantidad = 0 no es un repuesto valido, viola el CHECK.
-- INSERT INTO repuestos_usados (id_orden, nombre_repuesto, cantidad, costo_unitario) VALUES (2, 'Filtro de aire', 0, 25.00);
