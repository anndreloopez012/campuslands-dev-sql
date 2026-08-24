SELECT * FROM facturas;

SELECT numero, fecha
FROM facturas;

SELECT numero, fecha
FROM facturas
WHERE fecha >= '2026-08-03';

SELECT numero, fecha
FROM facturas
ORDER BY fecha DESC;

SELECT
f.numero,
SUM(d.cantidad*d.precio_unitario) AS subtotal
FROM facturas f
JOIN detalle_factura d ON f.id_factura=d.id_factura
GROUP BY f.id_factura,f.numero
ORDER BY subtotal DESC
LIMIT 5;

SELECT COUNT(*) AS total_facturas
FROM facturas;

SELECT
AVG(precio) AS promedio,
MIN(precio) AS minimo,
MAX(precio) AS maximo
FROM productos;

SELECT
p.categoria,
COUNT(*) AS productos
FROM productos p
GROUP BY p.categoria;

SELECT
f.numero,
c.nombre AS cliente,
p.nombre AS producto,
d.cantidad
FROM detalle_factura d
JOIN facturas f ON d.id_factura=f.id_factura
JOIN clientes c ON f.id_cliente=c.id_cliente
JOIN productos p ON d.id_producto=p.id_producto;

SELECT
f.numero,
c.nombre,
SUM(d.cantidad*d.precio_unitario) AS subtotal
FROM facturas f
JOIN clientes c ON f.id_cliente=c.id_cliente
JOIN detalle_factura d ON f.id_factura=d.id_factura
WHERE f.fecha >= '2026-08-02'
GROUP BY f.id_factura,f.numero,c.nombre
ORDER BY subtotal DESC
LIMIT 5;

SELECT
f.numero AS factura,
c.nombre AS cliente,
ROUND(SUM(d.cantidad*d.precio_unitario),2) AS subtotal,
ROUND(SUM(d.cantidad*d.precio_unitario)*(f.impuesto/100.0),2) AS impuesto,
ROUND(SUM(d.cantidad*d.precio_unitario)*(1+f.impuesto/100.0),2) AS total
FROM facturas f
JOIN clientes c ON f.id_cliente=c.id_cliente
JOIN detalle_factura d ON f.id_factura=d.id_factura
GROUP BY f.id_factura,f.numero,c.nombre,f.impuesto
ORDER BY total DESC;

SELECT
p.nombre,
SUM(d.cantidad) AS unidades_vendidas,
CASE
WHEN SUM(d.cantidad)>=3 THEN 'Alta rotacion'
WHEN SUM(d.cantidad)=2 THEN 'Rotacion media'
ELSE 'Rotacion baja'
END AS decision
FROM productos p
JOIN detalle_factura d ON p.id_producto=d.id_producto
GROUP BY p.id_producto,p.nombre
ORDER BY unidades_vendidas DESC;