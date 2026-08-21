PRAGMA foreign_keys = ON;

-- Ejercicio 045: Soldadura Industrial
-- Datos de prueba.

INSERT INTO tecnicos (nombre_tecnico, certificacion) VALUES
    ('Manuel Xitumul', 'estructural'),
    ('Brenda Coyoy', 'avanzada'),
    ('Herberth Sical', 'basica'),
    ('Yesenia Tzul', 'estructural');

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Metalurgica San Jose', '5601234'),
    ('Constructora Andina', '5607890'),
    ('Talleres Vial', '5602345'),
    ('Industrias Quetzal', '5603456'),
    ('Ferreteria Central', '5604567');

-- La orden 9 es un duplicado por error de digitacion (mismo cliente,
-- tecnico, descripcion, fecha, costo y estado que la orden 1): se
-- corrige en dml/operaciones.sql.
INSERT INTO ordenes (id_cliente, id_tecnico, descripcion, fecha_orden, costo_total, estado) VALUES
    (1, 1, 'Reparacion de estructura metalica', '2026-08-01', 1200.00, 'entregada'),
    (2, 2, 'Soldadura de portones industriales', '2026-08-03', 800.00, 'en_proceso'),
    (3, 3, 'Refuerzo de rampa de carga', '2026-08-05', 1500.00, 'inspeccion'),
    (4, 1, 'Fabricacion de soporte de tanque', '2026-08-06', 2000.00, 'recibida'),
    (1, 1, 'Soldadura de tuberia industrial', '2026-08-08', 950.00, 'en_proceso'),
    (5, 3, 'Reparacion de reja perimetral', '2026-08-09', 600.00, 'recibida'),
    (2, 4, 'Refuerzo de plataforma', '2026-08-11', 1800.00, 'rechazada'),
    (3, 2, 'Soldadura de escalera industrial', '2026-08-12', 700.00, 'recibida'),
    (1, 1, 'Reparacion de estructura metalica', '2026-08-01', 1200.00, 'entregada');

-- Materiales por orden. La orden 7 (rechazada) no llego a usar
-- materiales; el material 8 (orden 8, todavia 'recibida') se
-- eliminara de forma controlada en dml/operaciones.sql.
INSERT INTO materiales (id_orden, nombre_material, cantidad, costo_unitario) VALUES
    (1, 'Electrodo E6011', 10, 25.00),
    (1, 'Placa de acero 1/4 pulgada', 2, 150.00),
    (2, 'Electrodo E7018', 15, 30.00),
    (3, 'Perfil estructural IPN', 4, 220.00),
    (4, 'Placa de acero 3/8 pulgada', 3, 180.00),
    (5, 'Electrodo E6011', 8, 25.00),
    (6, 'Malla de refuerzo', 1, 120.00),
    (8, 'Electrodo E7018', 5, 30.00);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_tecnico ya existe, viola el UNIQUE.
-- INSERT INTO tecnicos (nombre_tecnico, certificacion) VALUES ('Manuel Xitumul', 'basica');

-- 2) Valor fuera de rango: costo_total = 0 no es una orden valida, viola el CHECK.
-- INSERT INTO ordenes (id_cliente, id_tecnico, descripcion, fecha_orden, costo_total) VALUES (2, 3, 'Prueba costo cero', '2026-08-13', 0);
