.headers on
.mode column

-- Ejercicio 039: Mecanica de Autos
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: diagnostico,
--    vehiculo y cliente).
SELECT
    d.id_diagnostico,
    c.nombre_cliente,
    v.placa,
    v.marca,
    v.modelo,
    d.fecha_diagnostico,
    d.descripcion,
    d.costo_reparacion,
    d.estado
FROM diagnosticos d
JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
JOIN clientes c ON c.id_cliente = v.id_cliente;

-- 2. Que diagnosticos no estan reparados todavia.
SELECT id_diagnostico, id_vehiculo, fecha_diagnostico, estado
FROM diagnosticos
WHERE estado <> 'reparado';

-- 3. Que cliente tiene mas diagnosticos registrados en el taller.
SELECT c.nombre_cliente, COUNT(*) AS total_diagnosticos
FROM clientes c
JOIN vehiculos v ON v.id_cliente = c.id_cliente
JOIN diagnosticos d ON d.id_vehiculo = v.id_vehiculo
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_diagnosticos DESC, c.nombre_cliente;

-- 4. Diagnosticos ordenados por fecha.
SELECT c.nombre_cliente, v.placa, d.descripcion, d.fecha_diagnostico
FROM diagnosticos d
JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
JOIN clientes c ON c.id_cliente = v.id_cliente
ORDER BY d.fecha_diagnostico;

-- 5. Reparaciones actualmente en garantia, para saber cuales estan
--    cubiertas si el cliente regresa con la misma falla.
SELECT
    c.nombre_cliente,
    v.marca,
    v.modelo,
    v.placa,
    d.descripcion,
    d.garantia_meses,
    d.fecha_ultimo_cambio
FROM diagnosticos d
JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
JOIN clientes c ON c.id_cliente = v.id_cliente
WHERE d.estado = 'en_garantia'
ORDER BY d.fecha_ultimo_cambio DESC;
