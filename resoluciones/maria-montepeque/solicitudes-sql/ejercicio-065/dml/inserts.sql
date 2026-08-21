PRAGMA foreign_keys = ON;

-- Ejercicio 065: Laboratorio Quimico
-- Datos base: 3 tecnicos, 4 formulas, 4 reactivos, 10 muestras, 6 resultados.

INSERT INTO tecnicos (nombre, especialidad) VALUES
    ('Manuel Estrada', 'Quimica Analitica'),
    ('Alejandra Chinchilla', 'Quimica Organica'),
    ('Byron Xicay', 'Bioquimica');

INSERT INTO formulas (nombre, descripcion) VALUES
    ('Formula A-12', 'Compuesto de limpieza industrial'),
    ('Formula B-07', 'Solucion desinfectante'),
    ('Formula C-21', 'Aditivo para alimentos'),
    ('Formula D-03', 'Conservante quimico');

INSERT INTO reactivos (nombre, unidad_medida) VALUES
    ('Acido Sulfurico', 'ml'),
    ('Hidroxido de Sodio', 'g'),
    ('Etanol', 'ml'),
    ('Cloruro de Sodio', 'g');

INSERT INTO muestras (id_formula, id_reactivo, id_tecnico, fecha_muestra, estado) VALUES
    (1, 1, 1, '2026-07-01', 'finalizada'),
    (2, 2, 2, '2026-07-02', 'finalizada'),
    (1, 3, 3, '2026-07-03', 'finalizada'),
    (3, 1, 1, '2026-07-04', 'en_analisis'),
    (4, 4, 2, '2026-07-05', 'pendiente'),
    (2, 1, 3, '2026-07-06', 'finalizada'),
    (1, 2, 1, '2026-07-07', 'finalizada'),
    (3, 3, 2, '2026-07-08', 'pendiente'),
    (1, 1, 3, '2026-07-09', 'finalizada'),
    (2, 4, 1, '2026-07-10', 'en_analisis');

-- resultados: solo de muestras ya 'finalizada'.
INSERT INTO resultados (id_muestra, valor_medido, unidad, aprobado) VALUES
    (1, 98.5, '%', 1),
    (2, 45.0, 'g', 1),
    (3, 12.3, 'ml', 0),
    (6, 50.2, 'g', 1),
    (7, 99.1, '%', 1),
    (9, 97.8, '%', 1);

-- Caso que debe fallar (queda comentado): un segundo resultado para la
-- misma muestra viola UNIQUE (id_muestra) en resultados.
-- INSERT INTO resultados (id_muestra, valor_medido, unidad) VALUES (1, 90.0, '%');
