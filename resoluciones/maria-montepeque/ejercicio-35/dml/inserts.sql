-- Ejercicio 35: Normalizacion Inventario Proveedores
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (categorias 1-3, proveedores 1-2, bodegas 1-2 y productos 1-3 con sus
--  movimientos vienen del CSV original; el resto se agrega para cumplir el
--  minimo de datos del ejercicio)
--
-- Nota sobre el CSV original: cada fila mezclaba el catalogo del producto
-- (categoria, proveedor, telefono) con dos movimientos escondidos en las
-- columnas `entradas` y `salidas`. Cada fila del CSV se transforma aqui en
-- UN producto (con su categoria y proveedor) y DOS movimientos (una entrada
-- y una salida) en `movimientos`.

INSERT INTO categorias (nombre) VALUES
    ('Computadoras'),
    ('Accesorios'),
    ('Mobiliario'),
    ('Electrodomesticos'),
    ('Perifericos');

INSERT INTO proveedores (nombre, telefono) VALUES
    ('TecnoMayor', '5551-1000'),
    ('Muebles GT', '5551-2000'),
    ('ElectroDistribuciones', '5551-3000'),
    ('Oficina Total', '5551-4000'),
    ('Repuestos Express', '5551-5000');

INSERT INTO bodegas (nombre) VALUES
    ('Bodega Norte'),
    ('Bodega Sur'),
    ('Bodega Centro'),
    ('Bodega Oriente'),
    ('Bodega Occidente');

INSERT INTO productos (nombre, id_categoria, id_proveedor) VALUES
    ('Laptop X1', 1, 1),               -- producto 1 del CSV
    ('Mouse Pro', 2, 1),                -- producto 2 del CSV
    ('Silla Gamer', 3, 2),              -- producto 3 del CSV
    ('Teclado Mecanico', 2, 1),         -- producto adicional
    ('Refrigeradora Compacta', 4, 3);   -- producto adicional

INSERT INTO movimientos (id_producto, id_bodega, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    -- movimiento 1 del CSV: Laptop X1, Bodega Norte, entradas 10, salidas 2
    (1, 1, 'entrada', 10, '2026-06-01'),
    (1, 1, 'salida', 2, '2026-06-05'),
    -- movimiento 2 del CSV: Mouse Pro, Bodega Norte, entradas 50, salidas 12
    (2, 1, 'entrada', 50, '2026-06-01'),
    (2, 1, 'salida', 12, '2026-06-06'),
    -- movimiento 3 del CSV: Silla Gamer, Bodega Sur, entradas 8, salidas 1
    (3, 2, 'entrada', 8, '2026-06-02'),
    (3, 2, 'salida', 1, '2026-06-07'),
    -- movimientos adicionales para completar el minimo de 10 lineas de detalle
    (4, 3, 'entrada', 30, '2026-06-03'),
    (4, 3, 'salida', 5, '2026-06-08'),
    (5, 4, 'entrada', 6, '2026-06-04'),
    (5, 4, 'salida', 1, '2026-06-09'),
    (1, 1, 'entrada', 5, '2026-06-15'),
    (2, 1, 'salida', 3, '2026-06-16');

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (proveedores.nombre): el proveedor ya existe
-- INSERT INTO proveedores (nombre, telefono) VALUES ('TecnoMayor', '5551-9999');

-- Falla por CHECK (cantidad > 0)
-- INSERT INTO movimientos (id_producto, id_bodega, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 1, 'entrada', 0, '2026-06-20');
