-- Ejercicio 11: Transporte Rutas
-- Datos base: 5 rutas, 5 buses, 5 conductores, 10 viajes

INSERT INTO rutas (origen, destino, distancia_km) VALUES
    ('Ciudad Central', 'Puerto Norte', 120.5),
    ('Ciudad Central', 'Valle Sur', 85.0),
    ('Puerto Norte', 'Valle Sur', 150.0),
    ('Ciudad Central', 'Montaña Este', 60.0),
    ('Valle Sur', 'Montaña Este', 95.0);

INSERT INTO buses (placa, capacidad) VALUES
    ('P-001ABC', 40),
    ('P-002ABC', 45),
    ('P-003ABC', 40),
    ('P-004ABC', 50),
    ('P-005ABC', 35);

INSERT INTO conductores (nombre, licencia) VALUES
    ('Walter Chacon', 'LIC-2001'),
    ('Norma Gudiel', 'LIC-2002'),
    ('Estuardo Lima', 'LIC-2003'),
    ('Brenda Coy', 'LIC-2004'),
    ('Sergio Ical', 'LIC-2005');

INSERT INTO viajes (id_ruta, id_bus, id_conductor, fecha_hora, pasajeros, estado) VALUES
    (1, 1, 1, '2026-08-05 06:00', 38, 'finalizado'),
    (2, 2, 2, '2026-08-05 07:00', 42, 'finalizado'),
    (3, 3, 3, '2026-08-05 08:00', 35, 'en_curso'),
    (4, 4, 4, '2026-08-05 09:00', 48, 'programado'),
    (5, 5, 5, '2026-08-05 10:00', 30, 'programado'),
    (1, 2, 1, '2026-08-06 06:00', 40, 'programado'),
    (2, 1, 2, '2026-08-06 07:00', 20, 'cancelado'),
    (3, 4, 3, '2026-08-06 08:00', 45, 'programado'),
    (4, 3, 4, '2026-08-06 09:00', 33, 'programado'),
    (5, 1, 5, '2026-08-07 06:00', 28, 'programado');
