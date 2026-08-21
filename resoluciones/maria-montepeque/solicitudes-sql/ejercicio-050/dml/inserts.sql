PRAGMA foreign_keys = ON;

-- Ejercicio 050: Track Day Hiperdeportivos
-- Datos de prueba.

INSERT INTO pilotos (nombre_piloto, licencia) VALUES
    ('Andrea Solares', 'LIC-4471'),
    ('Diego Palma', 'LIC-2289'),
    ('Renata Ixchel', 'LIC-5502'),
    ('Carlos Mota', 'LIC-3317'),
    ('Valentina Roca', 'LIC-6650');

INSERT INTO vehiculos (placa, modelo, potencia_hp) VALUES
    ('TRK101', 'GT-Fenix X1', 650),
    ('TRK102', 'Velaria RS', 720),
    ('TRK103', 'Nimbus GTR', 610),
    ('TRK104', 'Aureon Spyder', 700),
    ('TRK105', 'Kessler V12', 780);

INSERT INTO sesiones (numero_sesion, fecha_sesion, pista) VALUES
    (1, '2026-08-01', 'circuito_norte'),
    (2, '2026-08-02', 'circuito_sur'),
    (3, '2026-08-03', 'circuito_mixto');

-- El tiempo 11 es un duplicado por error de digitacion (mismo
-- piloto, vehiculo, sesion, vuelta y tiempo que el tiempo 1): se
-- corrige en dml/operaciones.sql. El tiempo 9 quedo en 0 segundos
-- porque Renata Ixchel se salio de pista y nunca completo la vuelta
-- (se borrara de forma controlada). El tiempo 10 nace 'valido' pero
-- se descalificara tras revisar el video (corte de pista).
INSERT INTO tiempos (id_piloto, id_vehiculo, id_sesion, vuelta, tiempo_segundos, estado) VALUES
    (1, 1, 1, 1, 88.452, 'valido'),
    (2, 2, 1, 1, 85.120, 'valido'),
    (3, 3, 1, 1, 90.334, 'valido'),
    (1, 1, 1, 2, 87.998, 'valido'),
    (4, 4, 2, 1, 86.775, 'valido'),
    (2, 2, 2, 1, 84.560, 'valido'),
    (5, 5, 2, 1, 83.910, 'valido'),
    (1, 1, 2, 2, 86.200, 'valido'),
    (3, 3, 3, 1, 0, 'invalido'),
    (4, 4, 3, 1, 89.100, 'valido'),
    (1, 1, 1, 1, 88.452, 'valido');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados. Cada uno demuestra uno de los tres errores que pidio
-- detectar el cliente:

-- 1) Registro repetido: la licencia ya existe, viola el UNIQUE.
-- INSERT INTO pilotos (nombre_piloto, licencia) VALUES ('Otro Piloto', 'LIC-4471');

-- 2) Relacion invalida: id_piloto = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO tiempos (id_piloto, id_vehiculo, id_sesion, vuelta, tiempo_segundos) VALUES (99, 1, 1, 1, 90.0);

-- 3) Valor fuera de rango: tiempo_segundos negativo, viola el CHECK.
-- INSERT INTO tiempos (id_piloto, id_vehiculo, id_sesion, vuelta, tiempo_segundos) VALUES (2, 2, 1, 3, -5.0);
