-- 1. Listar todos los registros principales de la entidad central
SELECT * 
    FROM ventas;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, precio_unitario 
    FROM ventas;

-- 3. Filtrar registros por una condicion numerica
SELECT * 
    FROM ventas 
    WHERE cantidad > 1;

-- 4. Ordenar resultados por fecha
SELECT * 
    FROM ventas 
    ORDER BY fecha_venta;

-- 5. Mostrar las 5 ventas con mayor monto (cantidad * precio_unitario)
SELECT *, (cantidad * precio_unitario) AS monto
    FROM ventas
    ORDER BY monto DESC
    LIMIT 5;

