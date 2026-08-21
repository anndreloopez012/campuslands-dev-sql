PRAGMA foreign_keys = ON;

-- Ejercicio 025: Track Day Hiperdeportivos
-- Datos de prueba.

INSERT INTO pilotos (nombre_piloto, licencia, categoria) VALUES
    ('Andres Lopez', 'LIC-001', 'profesional'),
    ('Marta Vega', 'LIC-002', 'semi_profesional'),
    ('Carlos Ruiz', 'LIC-003', 'amateur'),
    ('Diana Cruz', 'LIC-004', 'profesional'),
    ('Pedro Gomez', 'LIC-005', 'semi_profesional');

INSERT INTO vehiculos (id_piloto, modelo, potencia_hp) VALUES
    (1, 'Ferrari SF90', 986),
    (2, 'Lamborghini Huracan STO', 640),
    (3, 'Porsche 911 GT3', 502),
    (4, 'McLaren 720S', 710),
    (5, 'Nissan GT-R Nismo', 600);

-- La sesion 9 es una duplicada por error de digitacion (mismo vehiculo,
-- tiempo, fecha y clima que la sesion 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO sesiones (id_vehiculo, tiempo_vuelta_segundos, fecha_sesion, clima, estado) VALUES
    (1, 92.450, '2026-08-10 09:00', 'seco', 'valida'),
    (2, 98.120, '2026-08-10 09:30', 'seco', 'valida'),
    (3, 105.780, '2026-08-10 10:00', 'seco', 'en_revision'),
    (4, 95.340, '2026-08-11 09:00', 'lluvia', 'valida'),
    (1, 91.980, '2026-08-11 09:30', 'seco', 'valida'),
    (5, 99.650, '2026-08-11 10:00', 'nublado', 'valida'),
    (2, 97.500, '2026-08-12 09:00', 'seco', 'valida'),
    (4, 94.870, '2026-08-12 09:30', 'seco', 'valida'),
    (1, 92.450, '2026-08-10 09:00', 'seco', 'valida');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- tiempo_vuelta_segundos en cero, viola el CHECK de sesiones.
-- INSERT INTO sesiones (id_vehiculo, tiempo_vuelta_segundos, clima) VALUES (3, 0, 'seco');
