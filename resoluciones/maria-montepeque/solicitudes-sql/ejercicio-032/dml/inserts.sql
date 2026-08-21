PRAGMA foreign_keys = ON;

-- Ejercicio 032: Academia Kickboxing
-- Datos de prueba.

INSERT INTO planes (nombre_plan, precio_mensual) VALUES
    ('Plan Basico', 250.00),
    ('Plan Intermedio', 350.00),
    ('Plan Avanzado', 480.00),
    ('Plan Elite Personalizado', 700.00);

INSERT INTO alumnos (id_plan, nombre_completo, entrenador_asignado) VALUES
    (1, 'Andres Lopez', 'Pedro Ruiz'),
    (2, 'Marta Vega', 'Ana Castillo'),
    (3, 'Carlos Ruiz', 'Luis Marin'),
    (1, 'Diana Cruz', 'Pedro Ruiz'),
    (4, 'Pedro Gomez', 'Ana Castillo');

-- El pago 9 es una duplicada por error de digitacion (mismo alumno,
-- monto, fecha y metodo que el pago 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO pagos (id_alumno, monto_pagado, fecha_pago, metodo_pago, estado) VALUES
    (1, 250.00, '2026-08-01 09:00', 'efectivo', 'confirmado'),
    (2, 350.00, '2026-08-01 10:00', 'tarjeta', 'confirmado'),
    (3, 480.00, '2026-08-02 09:30', 'transferencia', 'pendiente'),
    (4, 250.00, '2026-08-02 11:00', 'efectivo', 'confirmado'),
    (5, 700.00, '2026-08-03 09:00', 'tarjeta', 'confirmado'),
    (1, 250.00, '2026-09-01 09:00', 'efectivo', 'confirmado'),
    (2, 350.00, '2026-09-01 10:00', 'tarjeta', 'rechazado'),
    (4, 250.00, '2026-09-02 11:00', 'efectivo', 'confirmado'),
    (1, 250.00, '2026-08-01 09:00', 'efectivo', 'confirmado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_pagado en cero, viola el CHECK de pagos.
-- INSERT INTO pagos (id_alumno, monto_pagado, metodo_pago) VALUES (3, 0, 'efectivo');
