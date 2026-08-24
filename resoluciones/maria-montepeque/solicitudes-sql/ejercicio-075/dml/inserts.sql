PRAGMA foreign_keys = ON;

-- Ejercicio 075: Track Day Hiperdeportivos
-- Datos base: 3 pilotos, 3 vehiculos, 3 sesiones (2 finalizadas, 1
-- marcada 'finalizada' por error que se corrige despues), 13 tiempos
-- (2 vueltas por piloto en cada una de las 2 sesiones reales, mas 1
-- vuelta cargada por error en la sesion que se cancela) y 6 pagos.

INSERT INTO pilotos (nombre_piloto, licencia) VALUES
    ('Fernanda Lopez', 'LIC-001'),
    ('Bryan Solis', 'LIC-002'),
    ('Karla Rivas', 'LIC-003');

INSERT INTO vehiculos (modelo, categoria) VALUES
    ('Ferrari SF90', 'hipercar'),
    ('McLaren 720S', 'superdeportivo'),
    ('Porsche 911 GT3', 'gt');

-- Sesion 1: Circuito Norte, finalizada.
INSERT INTO sesiones (fecha_sesion, pista, estado) VALUES
    ('2026-08-01', 'Circuito Norte', 'finalizada');

-- Sesion 2: Circuito Sur, finalizada.
INSERT INTO sesiones (fecha_sesion, pista, estado) VALUES
    ('2026-08-03', 'Circuito Sur', 'finalizada');

-- Sesion 3: Circuito Norte. Se marco 'finalizada' y se cargo un
-- tiempo, pero el sistema de cronometraje fallo y la sesion se anulo
-- despues. Se corrige en dml/operaciones.sql.
INSERT INTO sesiones (fecha_sesion, pista, estado) VALUES
    ('2026-08-05', 'Circuito Norte', 'finalizada');

-- Tiempos de la sesion 1 (2 vueltas por piloto, cada uno con su
-- vehiculo).
INSERT INTO tiempos (id_sesion, id_piloto, id_vehiculo, vuelta, tiempo_segundos) VALUES
    (1, 1, 1, 1, 92.345),
    (1, 1, 1, 2, 91.870),
    (1, 2, 2, 1, 93.120),
    (1, 2, 2, 2, 92.560),
    (1, 3, 3, 1, 95.400),
    (1, 3, 3, 2, 94.980);

-- Tiempos de la sesion 2.
INSERT INTO tiempos (id_sesion, id_piloto, id_vehiculo, vuelta, tiempo_segundos) VALUES
    (2, 1, 1, 1, 90.800),
    (2, 1, 1, 2, 90.250),
    (2, 2, 2, 1, 92.900),
    (2, 2, 2, 2, 92.100),
    (2, 3, 3, 1, 94.100),
    (2, 3, 3, 2, 93.750);

-- Tiempo cargado por error para la sesion 3, antes de saber que el
-- cronometraje habia fallado. Quedara huerfano cuando la sesion se
-- marque 'cancelada' en dml/operaciones.sql, y se elimina ahi mismo.
INSERT INTO tiempos (id_sesion, id_piloto, id_vehiculo, vuelta, tiempo_segundos) VALUES
    (3, 1, 1, 1, 91.000);

-- Pagos de las sesiones 1 y 2 (una fila por piloto), todavia
-- pendientes. Se confirman con UPDATE en dml/operaciones.sql.
INSERT INTO pagos (id_piloto, id_sesion, monto) VALUES
    (1, 1, 500.00),
    (2, 1, 500.00),
    (3, 1, 500.00),
    (1, 2, 500.00),
    (2, 2, 500.00),
    (3, 2, 500.00);

-- Caso comentado que debe fallar (queda comentado): cargar de nuevo a
-- Fernanda Lopez en la vuelta 1 de la sesion 1, exactamente el
-- problema que este UNIQUE esta disenado para evitar.
-- INSERT INTO tiempos (id_sesion, id_piloto, id_vehiculo, vuelta, tiempo_segundos) VALUES (1, 1, 1, 1, 92.000);
