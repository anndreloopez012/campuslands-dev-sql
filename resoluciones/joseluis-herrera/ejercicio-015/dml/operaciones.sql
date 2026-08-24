INSERT INTO clientes (id_cliente, nombre, telefono, email)
VALUES (6, 'Maria Hernandez', '55510006', 'maria.hernandez@gmail.com');

INSERT INTO motos (id_moto, id_cliente, placa, marca, modelo, anio)
VALUES (6, 6, 'MOT006', 'KTM', 'Duke 200', 2024);

UPDATE clientes
SET telefono = '55519999'
WHERE id_cliente = 6;

UPDATE motos
SET modelo = 'Duke 250'
WHERE id_moto = 6;

DELETE FROM motos
WHERE id_moto = 6;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACION INVALIDA: UNIQUE
-- INSERT INTO clientes (id_cliente, nombre, telefono, email)
-- VALUES (7, 'Cliente Duplicado', '55510007', 'carlos.ramirez@gmail.com');

-- OPERACION INVALIDA: CHECK
-- INSERT INTO servicios (id_servicio, nombre, descripcion, precio_base)
-- VALUES (6, 'Servicio Invalido', 'Precio no permitido', -100.00);