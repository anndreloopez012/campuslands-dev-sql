PRAGMA foreign_keys = ON;

-- Ejercicio 040: Laboratorio Quimico
-- Datos de prueba.

INSERT INTO formulas (nombre_formula, tipo) VALUES
    ('Compuesto Alfa-7', 'acida'),
    ('Solucion Beta-12', 'basica'),
    ('Mezcla Gamma-3', 'neutra'),
    ('Compuesto Delta-9', 'acida'),
    ('Solucion Epsilon-5', 'basica');

INSERT INTO reactivos (nombre_reactivo, unidad_medida) VALUES
    ('Acido Sulfurico', 'ml'),
    ('Hidroxido de Sodio', 'g'),
    ('Cloruro de Sodio', 'g'),
    ('Etanol', 'ml'),
    ('Sulfato de Cobre', 'mol');

-- La muestra 10 es un duplicado por error de digitacion (misma
-- formula, reactivo, fecha, concentracion y resultado que la muestra
-- 1): se corrige en dml/operaciones.sql.
INSERT INTO muestras (id_formula, id_reactivo, fecha_analisis, concentracion, resultado) VALUES
    (1, 1, '2026-08-01', 85.5, 'valido'),
    (2, 2, '2026-08-02', 42.0, 'valido'),
    (1, 3, '2026-08-03', 95.2, 'valido'),
    (3, 4, '2026-08-04', 12.8, 'pendiente'),
    (1, 2, '2026-08-05', 5.5, 'invalido'),
    (4, 1, '2026-08-06', 60.0, 'valido'),
    (1, 4, '2026-08-07', 3.2, 'invalido'),
    (5, 5, '2026-08-08', 77.0, 'pendiente'),
    (2, 3, '2026-08-09', 50.0, 'valido'),
    (1, 1, '2026-08-01', 85.5, 'valido');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados. Cada uno demuestra uno de los tres errores que pidio
-- detectar el cliente:

-- 1) Registro repetido: nombre_formula ya existe, viola el UNIQUE.
-- INSERT INTO formulas (nombre_formula, tipo) VALUES ('Compuesto Alfa-7', 'neutra');

-- 2) Relacion invalida: id_formula = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO muestras (id_formula, id_reactivo, fecha_analisis, concentracion) VALUES (99, 1, '2026-08-10', 50.0);

-- 3) Valor fuera de rango: concentracion = 150 no es un porcentaje valido, viola el CHECK.
-- INSERT INTO muestras (id_formula, id_reactivo, fecha_analisis, concentracion) VALUES (2, 3, '2026-08-10', 150.0);
