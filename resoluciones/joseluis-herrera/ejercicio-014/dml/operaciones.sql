INSERT INTO compradores (id_comprador, nombre, email, ciudad)
VALUES (6, 'Diego Castillo', 'diego.castillo@gmail.com', 'Amatitlan');

INSERT INTO productos (id_producto, id_vendedor, nombre, sku, precio, stock)
VALUES (11, 1, 'Hub USB 7 Puertos', 'SKU-HUB-001', 275.00, 20);

UPDATE compradores
SET ciudad = 'Quetzaltenango'
WHERE id_comprador = 6;

UPDATE productos
SET precio = 300.00,
    stock = 18
WHERE id_producto = 11;

DELETE FROM compradores
WHERE id_comprador = 6;

DELETE FROM productos
WHERE id_producto = 11;

-- OPERACION INVALIDA: UNIQUE
-- INSERT INTO vendedores (id_vendedor, nombre, email, telefono)
-- VALUES (6, 'Nuevo Vendedor', 'ventas@techsolutions.com', '55510006');

-- OPERACION INVALIDA: FOREIGN KEY
-- INSERT INTO productos (id_producto, id_vendedor, nombre, sku, precio, stock)
-- VALUES (12, 999, 'Producto Invalido', 'SKU-INVALIDO-001', 100.00, 5);