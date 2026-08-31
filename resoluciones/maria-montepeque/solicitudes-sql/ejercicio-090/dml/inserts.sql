PRAGMA foreign_keys = ON;

-- Ejercicio 090: Laboratorio Quimico
-- Datos base: 3 tecnicos, 4 formulas, 5 reactivos, 6 muestras (2
-- finalizadas, 1 rechazada, 2 en_analisis, 1 recibida), 3 resultados
-- y 7 lineas de detalle (incluye 1 cargada por error en una muestra
-- todavia en_analisis).

INSERT INTO tecnicos (nombre_tecnico, codigo_tecnico) VALUES
    ('Sofia Ramirez', 'T-001'),
    ('Carlos Perez', 'T-002'),
    ('Marta Lopez', 'T-003');

INSERT INTO formulas (nombre_formula, categoria) VALUES
    ('Solucion Buffer pH7', 'control_calidad'),
    ('Acido Sulfurico Diluido', 'sintesis'),
    ('Cloruro de Sodio Estandar', 'control_calidad'),
    ('Etanol 96%', 'sintesis');

INSERT INTO reactivos (nombre_reactivo, unidad_medida, stock_disponible) VALUES
    ('Agua Destilada', 'L', 500),
    ('Hidroxido de Sodio', 'kg', 50),
    ('Acido Clorhidrico', 'L', 30),
    ('Cloruro de Sodio', 'kg', 100),
    ('Etanol Puro', 'L', 80);

-- Muestra 1: Buffer pH7 de Sofia, finalizada y aprobada.
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (1, 1, '2026-08-01', 'finalizada');
INSERT INTO resultados (id_muestra, fecha_resultado, valor_medido, veredicto) VALUES
    (1, '2026-08-02', 7.02, 'aprobado');
INSERT INTO detalle_reactivos (id_muestra, id_reactivo, cantidad_usada) VALUES
    (1, 1, 2);

-- Muestra 2: Acido Sulfurico Diluido de Carlos, finalizada y aprobada.
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (2, 2, '2026-08-02', 'finalizada');
INSERT INTO resultados (id_muestra, fecha_resultado, valor_medido, veredicto) VALUES
    (2, '2026-08-03', 95.50, 'aprobado');
INSERT INTO detalle_reactivos (id_muestra, id_reactivo, cantidad_usada) VALUES
    (2, 3, 1),
    (2, 1, 1);

-- Muestra 3: Cloruro de Sodio Estandar de Sofia, todavia en_analisis.
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (3, 1, '2026-08-03', 'en_analisis');
INSERT INTO detalle_reactivos (id_muestra, id_reactivo, cantidad_usada) VALUES
    (3, 4, 0.5);

-- Linea de reactivo cargada por error para la muestra 3 (todavia
-- 'en_analisis'): el tecnico anoto hidroxido de sodio, que esta
-- formula no necesita. Se corrige con DELETE en dml/operaciones.sql.
INSERT INTO detalle_reactivos (id_muestra, id_reactivo, cantidad_usada) VALUES
    (3, 2, 0.3);

-- Muestra 4: Etanol 96% de Marta, rechazada por pureza fuera de rango.
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (4, 3, '2026-08-04', 'rechazada');
INSERT INTO resultados (id_muestra, fecha_resultado, valor_medido, veredicto) VALUES
    (4, '2026-08-05', 89.00, 'rechazado');
INSERT INTO detalle_reactivos (id_muestra, id_reactivo, cantidad_usada) VALUES
    (4, 5, 1);

-- Muestra 5: Buffer pH7 de Carlos, recien recibida (sin analizar).
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (1, 2, '2026-08-05', 'recibida');

-- Muestra 6: Acido Sulfurico Diluido de Marta, en_analisis.
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (2, 3, '2026-08-06', 'en_analisis');
INSERT INTO detalle_reactivos (id_muestra, id_reactivo, cantidad_usada) VALUES
    (6, 3, 0.5);

-- Caso comentado que debe fallar (queda comentado): registrar un
-- segundo resultado oficial para la muestra 1, exactamente el
-- problema de historico contradictorio que este UNIQUE esta disenado
-- para evitar.
-- INSERT INTO resultados (id_muestra, fecha_resultado, valor_medido, veredicto) VALUES (1, '2026-08-06', 6.90, 'aprobado');
