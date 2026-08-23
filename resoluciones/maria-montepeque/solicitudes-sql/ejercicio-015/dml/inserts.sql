PRAGMA foreign_keys = ON;

-- Ejercicio 015: Laboratorio Quimico
-- Datos de prueba.

INSERT INTO reactivos (nombre_reactivo, unidad_medida, stock_disponible) VALUES
    ('Acido Sulfurico', 'ml', 500),
    ('Hidroxido de Sodio', 'g', 300),
    ('Etanol', 'ml', 800),
    ('Cloruro de Sodio', 'g', 1000),
    ('Nitrato de Plata', 'g', 150);

-- resultado se deja NULL en las muestras que todavia estan en analisis:
-- es opcional, no lleva NOT NULL. La muestra 9 (codigo "M-TEST") es una
-- entrada de prueba que se cargo por error: se elimina en
-- dml/operaciones.sql.
INSERT INTO muestras (id_reactivo, codigo_muestra, fecha_analisis, resultado, estado) VALUES
    (1, 'M-001', '2026-07-01', 'Positivo - concentracion 4.2%', 'completado'),
    (2, 'M-002', '2026-07-02', 'Negativo', 'completado'),
    (3, 'M-003', '2026-07-03', NULL, 'en_analisis'),
    (1, 'M-004', '2026-07-04', NULL, 'contaminada'),
    (4, 'M-005', '2026-07-05', 'Positivo - concentracion 1.8%', 'completado'),
    (5, 'M-006', '2026-07-06', NULL, 'en_analisis'),
    (2, 'M-007', '2026-07-07', 'Negativo', 'completado'),
    (3, 'M-008', '2026-07-08', NULL, 'en_analisis'),
    (1, 'M-TEST', '2026-07-01', NULL, 'en_analisis');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- unidad_medida fuera de la lista permitida por el CHECK de reactivos.
-- INSERT INTO reactivos (nombre_reactivo, unidad_medida, stock_disponible) VALUES ('Oxigeno', 'kg', 20);
