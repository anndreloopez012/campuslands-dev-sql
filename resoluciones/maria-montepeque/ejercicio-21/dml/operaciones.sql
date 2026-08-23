-- Ejercicio 21: Logistica Envios
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, telefono, correo) VALUES
    ('Ingrid Say', '5033-1006', 'ingrid.say@correo.com');

INSERT INTO envios (id_paquete, id_ruta, fecha_envio, estado, costo) VALUES
    (2, 4, '2026-07-28', 'pendiente', 150.00);

-- 2 UPDATE validos
UPDATE envios
SET estado = 'entregado'
WHERE id_envio = 3;

UPDATE rutas
SET distancia_km = 210.0
WHERE id_ruta = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM envios
WHERE id_envio = 8;

DELETE FROM envios
WHERE estado = 'cancelado' AND id_envio = 10;
