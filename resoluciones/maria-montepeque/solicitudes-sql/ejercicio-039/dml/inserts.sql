PRAGMA foreign_keys = ON;

-- Ejercicio 039: Mecanica de Autos
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Walter Xitamul', '5591234'),
    ('Silvia Cabrera', '5597890'),
    ('Oscar Ramos', '5592345'),
    ('Ingrid Say', '5593456'),
    ('Manuel Estrada', '5594567');

-- Walter Xitamul (id_cliente = 1) tiene dos vehiculos registrados.
INSERT INTO vehiculos (placa, marca, modelo, id_cliente) VALUES
    ('P123ABC', 'Toyota', 'Corolla', 1),
    ('P456DEF', 'Honda', 'Civic', 2),
    ('P789GHI', 'Toyota', 'Hilux', 1),
    ('P321JKL', 'Mazda', '3', 3),
    ('P654MNO', 'Nissan', 'Sentra', 4),
    ('P987PQR', 'Kia', 'Rio', 5);

-- El diagnostico 10 es un duplicado por error de digitacion (mismo
-- vehiculo, fecha, descripcion, costo y estado que el diagnostico 1):
-- se corrige en dml/operaciones.sql. Es el unico caso donde se usa
-- DELETE, porque es un error de captura y no un dato real del taller.
INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, costo_reparacion, estado, garantia_meses, fecha_ultimo_cambio) VALUES
    (1, '2026-08-01', 'Cambio de frenos delanteros', 450.00, 'reparado', 3, '2026-08-02'),
    (2, '2026-08-03', 'Falla en sistema electrico', 900.00, 'en_garantia', 6, '2026-08-05'),
    (3, '2026-08-04', 'Revision de motor por ruido', 1200.00, 'en_reparacion', 0, '2026-08-04'),
    (4, '2026-08-06', 'Cambio de bateria', 300.00, 'reparado', 12, '2026-08-06'),
    (1, '2026-08-08', 'Alineacion y balanceo', 250.00, 'diagnosticado', 0, '2026-08-08'),
    (5, '2026-08-10', 'Fuga de aceite en carter', 700.00, 'en_garantia', 6, '2026-08-11'),
    (2, '2026-08-12', 'Cambio de llanta por pinchazo', 180.00, 'reparado', 0, '2026-08-12'),
    (6, '2026-08-14', 'Diagnostico de aire acondicionado', 500.00, 'diagnosticado', 0, '2026-08-14'),
    (3, '2026-08-16', 'Cambio de amortiguadores', 1100.00, 'en_garantia', 12, '2026-08-17'),
    (1, '2026-08-01', 'Cambio de frenos delanteros', 450.00, 'reparado', 3, '2026-08-02');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- costo_reparacion negativo, viola el CHECK de diagnosticos.
-- INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, costo_reparacion, fecha_ultimo_cambio) VALUES (4, '2026-08-20', 'Prueba costo negativo', -50.00, '2026-08-20');
