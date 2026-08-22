SELECT * FROM envios;

SELECT id_envio, estado
FROM envios;

SELECT id_envio, fecha_envio, costo
FROM envios
WHERE costo >= 80;

SELECT id_envio, fecha_envio, estado
FROM envios
ORDER BY fecha_envio DESC;

SELECT id_envio, costo
FROM envios
ORDER BY costo DESC
LIMIT 5;

SELECT COUNT(*) AS total_envios
FROM envios;

SELECT
AVG(costo) AS promedio,
MIN(costo) AS minimo,
MAX(costo) AS maximo
FROM envios;

SELECT
estado,
COUNT(*) AS cantidad
FROM envios
GROUP BY estado;

SELECT
e.id_envio,
c.nombre AS cliente,
p.descripcion AS paquete,
r.origen,
r.destino,
e.estado
FROM envios e
JOIN paquetes p ON e.id_paquete = p.id_paquete
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN rutas r ON e.id_ruta = r.id_ruta;

SELECT
e.id_envio,
c.nombre,
e.costo
FROM envios e
JOIN paquetes p ON e.id_paquete = p.id_paquete
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE e.estado = 'entregado'
ORDER BY e.costo DESC
LIMIT 5;

SELECT
c.nombre AS cliente,
COUNT(e.id_envio) AS envios,
SUM(e.costo) AS total_pagado
FROM clientes c
JOIN paquetes p ON c.id_cliente = p.id_cliente
JOIN envios e ON p.id_paquete = e.id_paquete
GROUP BY c.id_cliente, c.nombre
ORDER BY total_pagado DESC;

SELECT
r.codigo,
r.origen,
r.destino,
COUNT(e.id_envio) AS envios_realizados,
SUM(e.costo) AS ingresos
FROM rutas r
LEFT JOIN envios e ON r.id_ruta = e.id_ruta
GROUP BY r.id_ruta, r.codigo, r.origen, r.destino
ORDER BY ingresos DESC;

SELECT
r.codigo,
r.origen,
r.destino,
COUNT(e.id_envio) AS volumen,
CASE
WHEN COUNT(e.id_envio) >= 3 THEN 'Alta demanda'
WHEN COUNT(e.id_envio) = 2 THEN 'Demanda media'
ELSE 'Baja demanda'
END AS decision
FROM rutas r
LEFT JOIN envios e ON r.id_ruta = e.id_ruta
GROUP BY r.id_ruta, r.codigo, r.origen, r.destino
ORDER BY volumen DESC;