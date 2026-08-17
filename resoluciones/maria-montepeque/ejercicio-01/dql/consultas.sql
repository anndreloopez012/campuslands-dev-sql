-- Ejercicio 01: CineMax SQLite
-- Entidad central: boletos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM boletos;

-- 2. Mostrar solo dos columnas relevantes
SELECT asiento, precio_pagado FROM boletos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM boletos WHERE precio_pagado > 35;

-- 4. Ordenar resultados por fecha
SELECT * FROM boletos ORDER BY fecha_compra;

-- 5. Mostrar los 5 registros mas caros
SELECT * FROM boletos ORDER BY precio_pagado DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_boletos FROM boletos;

-- 7. Promedio, minimo y maximo de precio pagado
SELECT
    AVG(precio_pagado) AS promedio,
    MIN(precio_pagado) AS minimo,
    MAX(precio_pagado) AS maximo
FROM boletos;

-- 8. Agrupar boletos por estado
SELECT estado, COUNT(*) AS cantidad
FROM boletos
GROUP BY estado;

-- 9. Relacionar boletos, funciones y peliculas con JOIN
SELECT b.id_boleto, p.titulo, f.fecha_hora, b.asiento
FROM boletos b
JOIN funciones f ON f.id_funcion = b.id_funcion
JOIN peliculas p ON p.id_pelicula = f.id_pelicula;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM boletos
WHERE estado = 'pagado'
ORDER BY precio_pagado DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    p.titulo AS pelicula,
    s.nombre AS sala,
    b.asiento AS asiento,
    b.precio_pagado AS precio
FROM boletos b
JOIN funciones f ON f.id_funcion = b.id_funcion
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala;

-- 12. Consulta para decision de negocio: pelicula con mas boletos pagados
SELECT p.titulo, COUNT(*) AS boletos_pagados
FROM boletos b
JOIN funciones f ON f.id_funcion = b.id_funcion
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
WHERE b.estado = 'pagado'
GROUP BY p.titulo
ORDER BY boletos_pagados DESC
LIMIT 1;
