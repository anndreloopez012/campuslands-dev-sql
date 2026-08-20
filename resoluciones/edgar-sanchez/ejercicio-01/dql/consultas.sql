-- 1. Listar todos los registros principales de la entidad central (funciones)
SELECT 
    funcion_id, 
    pelicula_id, 
    sala_id, 
    fecha_hora_inicio, 
    precio_boleto 
FROM funciones;

-- 2. Mostrar solo dos columnas relevantes de esa entidad
SELECT 
    fecha_hora_inicio, 
    precio_boleto 
FROM funciones;

-- 3. Filtrar registros por una condicion numerica o de fecha
SELECT 
    funcion_id, 
    fecha_hora_inicio, 
    precio_boleto 
FROM funciones 
WHERE precio_boleto >= 50.00;

-- 4. Ordenar resultados alfabeticamente o por fecha
SELECT 
    pelicula_id, 
    titulo, 
    duracion_minutos, 
    genero 
FROM peliculas 
ORDER BY titulo ASC;

-- 5. Mostrar los 5 registros mas importantes segun una metrica (boletos de mayor monto)
SELECT 
    boleto_id, 
    funcion_id, 
    numero_asiento, 
    monto_pagado 
FROM boletos 
ORDER BY monto_pagado DESC 
LIMIT 5;

-- 6. Contar registros totales
SELECT 
    COUNT(*) AS total_boletos_vendidos 
FROM boletos;

-- 7. Calcular promedio, minimo o maximo de una columna numerica
SELECT 
    AVG(precio_boleto) AS precio_promedio,
    MIN(precio_boleto) AS precio_minimo,
    MAX(precio_boleto) AS precio_maximo
FROM funciones;

-- 8. Agrupar registros con GROUP BY
SELECT 
    metodo_pago, 
    COUNT(boleto_id) AS total_ventas, 
    SUM(monto_pagado) AS recaudacion_total
FROM boletos
GROUP BY metodo_pago;

-- 9. Relacionar minimo dos tablas con JOIN
SELECT 
    f.funcion_id,
    p.titulo AS pelicula,
    s.nombre_sala AS sala,
    f.fecha_hora_inicio,
    f.precio_boleto
FROM funciones f
INNER JOIN peliculas p ON f.pelicula_id = p.pelicula_id
INNER JOIN salas s ON f.sala_id = s.sala_id;

-- 10. Crear una consulta con WHERE, ORDER BY y LIMIT
SELECT 
    b.boleto_id,
    b.numero_asiento,
    b.monto_pagado,
    b.fecha_venta
FROM boletos b
WHERE b.metodo_pago = 'Tarjeta'
ORDER BY b.monto_pagado DESC
LIMIT 3;

-- 11. Crear un reporte con alias legibles para las columnas
SELECT 
    p.titulo AS "Título de la Película",
    s.nombre_sala AS "Sala de Proyección",
    f.fecha_hora_inicio AS "Horario de Función",
    b.numero_asiento AS "Asiento",
    b.monto_pagado AS "Monto Total (Q)"
FROM boletos b
INNER JOIN funciones f ON b.funcion_id = f.funcion_id
INNER JOIN peliculas p ON f.pelicula_id = p.pelicula_id
INNER JOIN salas s ON f.sala_id = s.sala_id;

-- 12. Consulta para toma de decisiones: Taquilla por Película y Ocupación
SELECT 
    p.titulo AS pelicula,
    COUNT(b.boleto_id) AS boletos_vendidos,
    COALESCE(SUM(b.monto_pagado), 0.00) AS ingresos_totales,
    ROUND(AVG(f.precio_boleto), 2) AS precio_promedio_funcion
FROM peliculas p
LEFT JOIN funciones f ON p.pelicula_id = f.pelicula_id
LEFT JOIN boletos b ON f.funcion_id = b.funcion_id
GROUP BY p.pelicula_id, p.titulo
ORDER BY ingresos_totales DESC;