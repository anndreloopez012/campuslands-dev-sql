.headers on
.mode column

-- Ejercicio 077: Taller de Motos
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las lineas de
-- repuestos con su repuesto, su orden y su moto.
SELECT dr.id_detalle,
       r.nombre_repuesto,
       o.id_orden,
       m.placa,
       dr.cantidad,
       dr.precio_unitario,
       (dr.cantidad * dr.precio_unitario) AS subtotal
FROM detalle_repuestos dr
JOIN repuestos r ON r.id_repuesto = dr.id_repuesto
JOIN ordenes_servicio o ON o.id_orden = dr.id_orden
JOIN motos m ON m.id_moto = o.id_moto;

-- 2. Que ordenes estan recibidas, en reparacion, finalizadas o
-- canceladas.
SELECT id_orden, id_moto, estado
FROM ordenes_servicio
ORDER BY estado;

-- 3. Que moto tiene mas ordenes de servicio (ranking de actividad).
SELECT m.placa, m.modelo, COUNT(*) AS total_ordenes
FROM motos m
JOIN ordenes_servicio o ON o.id_moto = m.id_moto
GROUP BY m.id_moto, m.placa, m.modelo
ORDER BY total_ordenes DESC, m.placa;

-- 4. Lineas de repuestos ordenadas por subtotal, de mayor a menor.
SELECT r.nombre_repuesto, dr.cantidad, dr.precio_unitario,
       (dr.cantidad * dr.precio_unitario) AS subtotal
FROM detalle_repuestos dr
JOIN repuestos r ON r.id_repuesto = dr.id_repuesto
ORDER BY subtotal DESC;

-- 5. Reporte para decision de negocio: repuestos mas usados por
-- cantidad total, para decidir cuales mantener siempre en stock
-- (GROUP BY + HAVING).
SELECT r.nombre_repuesto,
       SUM(dr.cantidad) AS unidades_usadas
FROM detalle_repuestos dr
JOIN repuestos r ON r.id_repuesto = dr.id_repuesto
GROUP BY r.id_repuesto, r.nombre_repuesto
HAVING SUM(dr.cantidad) >= 1
ORDER BY unidades_usadas DESC, r.nombre_repuesto;
