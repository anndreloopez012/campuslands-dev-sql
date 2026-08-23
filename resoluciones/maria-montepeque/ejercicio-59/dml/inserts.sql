PRAGMA foreign_keys = ON;

-- Ejercicio 59: DEFAULT Nivel Basico
-- Datos de prueba para validar el tema DEFAULT.

INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops'),
    ('Monitores'),
    ('Perifericos');

-- Casos con TODOS los valores explicitos (no dependen de ningun DEFAULT):
-- sirven de contraste contra los casos que si usan DEFAULT.
INSERT INTO productos (id_categoria, sku, nombre_producto, estado, stock, es_fragil, fecha_registro) VALUES
    (1, 'LAP-001', 'Laptop Pro 14', 'disponible', 12, 1, '2026-07-01 09:00:00'),
    (2, 'MON-001', 'Monitor 24 pulgadas', 'agotado', 0, 1, '2026-07-02 10:00:00');

-- Casos validos que usan DEFAULT: se omiten estado, stock, es_fragil y
-- fecha_registro a proposito para que la base los complete sola.
INSERT INTO productos (id_categoria, sku, nombre_producto) VALUES
    (1, 'LAP-002', 'Laptop Basica 15'),
    (2, 'MON-002', 'Monitor 27 pulgadas'),
    (3, 'PER-001', 'Teclado mecanico');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- escribir un estado a mano en vez de dejar que DEFAULT lo complete, y
-- equivocarse en el texto (typo), viola el CHECK de estado.
-- INSERT INTO productos (id_categoria, sku, nombre_producto, estado) VALUES (3, 'PER-002', 'Mouse inalambrico', 'dispnible');
