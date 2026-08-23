PRAGMA foreign_keys = ON;

-- Ejercicio 020: Soldadura Industrial
-- Datos de prueba.

INSERT INTO tecnicos (nombre_tecnico, certificacion, anios_experiencia) VALUES
    ('Carlos Ruiz', 'avanzada', 15),
    ('Pedro Gomez', 'intermedia', 8),
    ('Ana Castillo', 'avanzada', 20),
    ('Luis Marin', 'basica', 3),
    ('Sofia Reyes', 'intermedia', 6);

-- La orden 9 es una entrada de prueba (codigo "ORD-TEST") que se cargo
-- por error: se elimina en dml/operaciones.sql.
INSERT INTO ordenes (id_tecnico, codigo_orden, descripcion, costo, fecha_orden, estado) VALUES
    (1, 'ORD-001', 'Soldadura de estructura metalica nave industrial', 4500.00, '2026-07-01', 'aprobada'),
    (3, 'ORD-002', 'Reparacion de tuberia de alta presion', 2800.00, '2026-07-03', 'aprobada'),
    (2, 'ORD-003', 'Soldadura de tanque de almacenamiento', 3200.00, '2026-07-05', 'inspeccionada'),
    (1, 'ORD-004', 'Refuerzo estructural puente peatonal', 5200.00, '2026-07-08', 'en_proceso'),
    (4, 'ORD-005', 'Soldadura de baranda industrial', 800.00, '2026-07-10', 'aprobada'),
    (5, 'ORD-006', 'Reparacion de valvula industrial', 1500.00, '2026-07-12', 'rechazada'),
    (3, 'ORD-007', 'Soldadura de escalera de emergencia', 1200.00, '2026-07-15', 'aprobada'),
    (2, 'ORD-008', 'Fabricacion de soporte metalico', 950.00, '2026-07-18', 'inspeccionada'),
    (1, 'ORD-TEST', 'Entrada de prueba', 4500.00, '2026-07-01', 'en_proceso');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- anios_experiencia fuera de rango, viola el CHECK de tecnicos (esto es
-- exactamente el "valor fuera de rango" que el cliente quiere detectar).
-- INSERT INTO tecnicos (nombre_tecnico, certificacion, anios_experiencia) VALUES ('Diego Paz', 'basica', 80);
