-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM resultados;

-- 2. Mostrar solo dos columnas relevantes
SELECT kills, puntos FROM resultados;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM resultados WHERE kills >= 20;

-- 4. Ordenar resultados por puntos
SELECT * FROM resultados ORDER BY puntos DESC;

-- 5. Mostrar los 5 mejores resultados segun puntos
SELECT * FROM resultados ORDER BY puntos DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_resultados FROM resultados;

-- 7. Promedio, minimo y maximo de puntos
SELECT
    AVG(puntos) AS promedio,
    MIN(puntos) AS minimo,
    MAX(puntos) AS maximo
FROM resultados;

-- 8. Agrupar resultados por jugador
SELECT id_jugador, COUNT(*) AS partidas_jugadas, SUM(puntos) AS puntos_totales
FROM resultados
GROUP BY id_jugador;

