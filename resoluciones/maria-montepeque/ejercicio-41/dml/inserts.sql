PRAGMA foreign_keys = ON;

-- Ejercicio 41: Tipos de datos Nivel Basico
-- Datos de prueba para validar el tema Tipos de datos.

INSERT INTO categorias (nombre) VALUES
    ('Computadoras'),
    ('Perifericos'),
    ('Almacenamiento'),
    ('Audio'),
    ('Redes');

-- precio usa REAL (admite decimales), stock usa INTEGER (siempre entero),
-- activo usa el BOOLEAN simulado (0/1).
INSERT INTO productos (id_categoria, nombre, precio, stock, activo) VALUES
    (1, 'Laptop 14 pulgadas', 4599.99, 12, 1),
    (2, 'Mouse inalambrico', 89.50, 40, 1),
    (2, 'Teclado mecanico', 249.00, 25, 1),
    (3, 'SSD 500GB', 349.90, 30, 1),
    (4, 'Audifonos bluetooth', 199.00, 0, 0),   -- activo = 0: producto descontinuado, sin stock
    (5, 'Router WiFi 6', 459.00, 15, 1);

-- fecha_movimiento usa el DATE simulado (TEXT en formato ISO 'YYYY-MM-DD').
INSERT INTO movimientos (id_producto, tipo, cantidad, fecha_movimiento) VALUES
    (1, 'entrada', 12, '2026-07-01'),
    (2, 'entrada', 40, '2026-07-01'),
    (3, 'entrada', 25, '2026-07-02'),
    (4, 'entrada', 30, '2026-07-02'),
    (1, 'salida', 2, '2026-07-10'),
    (2, 'salida', 5, '2026-07-11'),
    (5, 'entrada', 15, '2026-07-03'),
    (5, 'salida', 3, '2026-07-12');

-- Caso valido: activo solo acepta 0 o 1 (BOOLEAN simulado correcto).
INSERT INTO productos (id_categoria, nombre, precio, stock, activo) VALUES
    (1, 'Mini PC', 2100.00, 5, 1);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- activo = 2 rompe la simulacion de BOOLEAN: no es ni 0 ni 1, y el CHECK
-- lo rechaza. Si `activo` fuera TEXT sin restriccion, este error pasaria
-- desapercibido (por eso se prefiere INTEGER + CHECK para simular BOOLEAN).
-- INSERT INTO productos (id_categoria, nombre, precio, stock, activo) VALUES (1, 'Producto Prueba', 100.00, 1, 2);

-- Otro caso que no es recomendable: guardar la fecha con formato libre
-- (no ISO) rompe el orden alfabetico == orden cronologico y el CHECK de
-- fecha_movimiento la rechaza:
-- INSERT INTO movimientos (id_producto, tipo, cantidad, fecha_movimiento) VALUES (1, 'entrada', 5, '10/07/2026');
