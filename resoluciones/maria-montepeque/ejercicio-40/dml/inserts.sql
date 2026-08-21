-- Ejercicio 40: Normalizacion Integrador Avanzado
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (clientes 1-2, vendedores 1-2, productos 1-6 y las operaciones 1-3 con su
--  detalle_producto y movimientos vienen del CSV original; el resto se
--  agrega para cumplir el minimo de datos del ejercicio)

INSERT INTO clientes (nombre) VALUES
    ('Sergio Ramos'),
    ('Paola Mejia'),
    ('Karla Xoc'),
    ('Boris Tzul'),
    ('Diana Say');

INSERT INTO vendedores (nombre) VALUES
    ('Lucia Diaz'),
    ('Mateo Ruiz'),
    ('Fernando Us'),
    ('Silvia Cot'),
    ('Pablo Ixim');

INSERT INTO productos (nombre) VALUES
    ('Tablet'),
    ('Case'),
    ('Laptop'),
    ('Mouse'),
    ('Monitor'),
    ('Cable HDMI');

INSERT INTO operaciones (id_cliente, id_vendedor) VALUES
    (1, 1),   -- operacion 1 del CSV: Sergio Ramos, Lucia Diaz
    (2, 1),   -- operacion 2 del CSV: Paola Mejia, Lucia Diaz
    (1, 2),   -- operacion 3 del CSV: Sergio Ramos, Mateo Ruiz
    (3, 3),   -- operacion adicional
    (4, 4),   -- operacion adicional
    (5, 5);   -- operacion adicional

INSERT INTO detalle_producto (id_operacion, id_producto) VALUES
    -- operacion 1 (CSV): Tablet|Case
    (1, 1),
    (1, 2),
    -- operacion 2 (CSV): Laptop|Mouse
    (2, 3),
    (2, 4),
    -- operacion 3 (CSV): Monitor|Cable HDMI
    (3, 5),
    (3, 6),
    -- operaciones adicionales para completar el minimo de 10 lineas de detalle
    (4, 1),
    (4, 4),
    (5, 3),
    (5, 2),
    (5, 5),
    (6, 6);

INSERT INTO movimientos (id_operacion, metodo_pago, cuotas, zona_entrega, estado) VALUES
    -- operacion 1 (CSV): pagos Tarjeta|Efectivo, cuotas 1|0, entregas Envio Norte|Tienda, estados Pagado|Entregado
    (1, 'Tarjeta', 1, 'Envio Norte', 'Pagado'),
    (1, 'Efectivo', 0, 'Tienda', 'Entregado'),
    -- operacion 2 (CSV): pagos Credito, cuotas 3, entregas Envio Centro, estados Pendiente
    (2, 'Credito', 3, 'Envio Centro', 'Pendiente'),
    -- operacion 3 (CSV): pagos Transferencia, cuotas 1, entregas Envio Norte, estados Pagado
    (3, 'Transferencia', 1, 'Envio Norte', 'Pagado'),
    -- operaciones adicionales
    (4, 'Tarjeta', 2, 'Envio Sur', 'Pendiente'),
    (5, 'Efectivo', 0, 'Tienda', 'Entregado'),
    (5, 'Credito', 4, 'Envio Centro', 'Pendiente'),
    (6, 'Transferencia', 1, 'Envio Norte', 'Pagado');

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (clientes.nombre): el cliente ya existe
-- INSERT INTO clientes (nombre) VALUES ('Sergio Ramos');

-- Falla por CHECK (cuotas >= 0)
-- INSERT INTO movimientos (id_operacion, metodo_pago, cuotas, zona_entrega, estado) VALUES (1, 'Credito', -1, 'Envio Norte', 'Pendiente');
