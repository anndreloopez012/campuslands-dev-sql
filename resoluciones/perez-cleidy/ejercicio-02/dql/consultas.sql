.headers on
.mode column

-- Ejercicio 02: Campus Shop
-- Escriba aqui las consultas obligatorias del README.

-- 1. Listar todos los registros principales.
SELECT * FROM clientes;

-- 2. Mostrar solo dos columnas relevantes.
SELECT nombre_producto, precio FROM productos;

-- 3. Filtrar por condicion numerica o de fecha.

SELECT * FROM ventas WHERE fecha > '2026-06-12';
-- 4. Ordenar resultados.

-- 5. Mostrar top 5 por una metrica.

SELECT * FROM ventas LIMIT 5;

-- 6. Contar registros totales.
SELECT count(*) AS total_categoria FROM categoria;   

-- 7. Calcular promedio, minimo o maximo.
SELECT min(precio_total) FROM ventas;
-- 8. Agrupar con GROUP BY.
SELECT id_cliente, count(*) as cantidad_clientes FROM clientes GROUP BY id_cliente;

-- 9. Relacionar minimo dos tablas con JOIN.
SELECT p.nombre, f.precio_total FROM clientes p INNER JOIN ventas f ON p.id_cliente=f.id_ventas;
-- 10. Usar WHERE, ORDER BY y LIMIT.


SELECT * FROM productos WHERE precio > 1000 ORDER BY precio LIMIT 3;
-- 11. Crear reporte con alias.
SELECT 
    p.nombre_producto As [Articulos tecnologicos],
    s.nombre_categoria As [Tipos de productos]

    From ventas As b 
    INNER JOIN ventas AS f ON b.id_ventas = f.id_ventas
    INNER JOIN productos As p ON p.id_producto=p.id_producto
    INNER JOIN categoria As S ON S.id_categoria= S.id_categoria
    GROUP BY p.id_producto, s.nombre_categoria;


-- 12. Consulta para decision del negocio.
SELECT 
    s.nombre AS [clientes],
    b.fecha AS [Fecha de Venta],
    SUM(f.precio_total) AS [Ingreso Diario]
FROM ventas AS b
INNER JOIN ventas AS f ON b.id_ventas = f.id_ventas
INNER JOIN clientes AS s ON s.id_cliente = s.id_cliente
GROUP BY s.nombre, b.fecha
ORDER BY [Ingreso Diario] ASC;