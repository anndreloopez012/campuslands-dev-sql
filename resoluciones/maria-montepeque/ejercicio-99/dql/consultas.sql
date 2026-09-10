.headers on
.mode column

-- Ejercicio 99: Vistas Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales usando la vista (evita repetir el JOIN de 3 tablas).
SELECT * FROM vista_detalle_ventas;

-- 2. Consulta con WHERE sobre la vista: solo las lineas de venta con total mayor a 25.
SELECT id_venta, nombre_cliente, nombre_producto, total_linea
FROM vista_detalle_ventas
WHERE total_linea > 25;

-- 3. Consulta con ORDER BY sobre la vista: lineas de venta de mayor a menor total.
SELECT id_venta, nombre_producto, total_linea
FROM vista_detalle_ventas
ORDER BY total_linea DESC;

-- 4. Conteo o resumen: total de ventas y total facturado por cliente, reutilizando la vista.
SELECT nombre_cliente,
       COUNT(*) AS total_ventas,
       SUM(total_linea) AS total_facturado
FROM vista_detalle_ventas
GROUP BY nombre_cliente;

-- 5. Validacion especifica de Vistas: la MISMA vista sirve de base
-- para un reporte distinto (ingresos por producto), sin volver a
-- escribir el JOIN de ventas+clientes+productos. Esto es justo el
-- proposito de una vista: centralizar la combinacion de tablas una
-- sola vez y reutilizarla en varias consultas de negocio.
SELECT nombre_producto,
       SUM(total_linea) AS total_facturado
FROM vista_detalle_ventas
GROUP BY nombre_producto
ORDER BY total_facturado DESC;

-- Caso comentado que no es recomendable, dejar comentado: crear una
-- vista que referencia una columna que no existe. SQLite NO valida
-- el SELECT de una vista en el momento del CREATE VIEW (evaluacion
-- perezosa): la sentencia se ejecuta sin error aunque
-- "total_calculado" no exista en "ventas". El problema aparece recien
-- al consultar la vista: se verifico con Python (sqlite3) que
-- "SELECT * FROM vista_ventas_mal" falla con el error "no such
-- column: total_calculado". Por eso siempre hay que probar una vista
-- nueva con un SELECT despues de crearla, y no confiar en que el
-- CREATE VIEW sin errores signifique que esta bien definida.
-- CREATE VIEW vista_ventas_mal AS
-- SELECT id_venta, total_calculado FROM ventas;
-- SELECT * FROM vista_ventas_mal;
