.headers on
.mode column

-- Ejercicio 029: Tienda Sneakers
-- Consultas de validacion.

-- 1. Que registros principales existen (el historico completo, con
--    JOIN para mostrar el cliente y el modelo).
SELECT
    ev.id_evento,
    c.nombre_cliente,
    p.nombre_modelo,
    p.talla,
    ev.tipo_evento,
    ev.fecha_evento,
    ev.estado
FROM eventos_pedido ev
JOIN pedidos p ON p.id_pedido = ev.id_pedido
JOIN clientes c ON c.id_cliente = p.id_cliente;

-- 2. Que eventos estan anulados (no confirmados).
SELECT id_evento, id_pedido, tipo_evento, fecha_evento
FROM eventos_pedido
WHERE estado = 'anulado';

-- 3. Que pedido tiene mas eventos registrados en su historico.
SELECT c.nombre_cliente, p.nombre_modelo, COUNT(*) AS total_eventos
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN eventos_pedido ev ON ev.id_pedido = p.id_pedido
GROUP BY p.id_pedido, c.nombre_cliente, p.nombre_modelo
ORDER BY total_eventos DESC;

-- 4. Historico ordenado cronologicamente: que paso y cuando paso.
SELECT c.nombre_cliente, p.nombre_modelo, ev.tipo_evento, ev.fecha_evento, ev.estado
FROM eventos_pedido ev
JOIN pedidos p ON p.id_pedido = ev.id_pedido
JOIN clientes c ON c.id_cliente = p.id_cliente
ORDER BY ev.fecha_evento;

-- 5. Ultimo evento registrado de cada pedido, para saber en que quedo
--    cada uno sin revisar todo el historico (respuesta directa a la
--    pregunta de auditoria del cliente).
SELECT
    c.nombre_cliente,
    p.nombre_modelo,
    ev.tipo_evento,
    ev.fecha_evento,
    ev.estado
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN eventos_pedido ev ON ev.id_pedido = p.id_pedido
WHERE ev.fecha_evento = (
    SELECT MAX(fecha_evento) FROM eventos_pedido WHERE id_pedido = p.id_pedido
)
ORDER BY c.nombre_cliente;
