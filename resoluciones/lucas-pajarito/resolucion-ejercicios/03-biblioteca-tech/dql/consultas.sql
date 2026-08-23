.headers on
.mode column

-- Ejercicio 03: Biblioteca Tech
-- Escriba aqui las consultas obligatorias del README.

/* Consultas obligatorias

Incluya en `dql/consultas.sql` consultas para resolver estos puntos:

1. Listar todos los registros principales de la entidad central.
2. Mostrar solo dos columnas relevantes de esa entidad.
3. Filtrar registros por una condicion numerica o de fecha.
4. Ordenar resultados alfabeticamente o por fecha.
5. Mostrar los 5 registros mas importantes segun una metrica.
6. Contar registros totales.
7. Calcular promedio, minimo o maximo de una columna numerica.
8. Agrupar registros con `GROUP BY`.
9. Relacionar minimo dos tablas con `JOIN`.
10. Crear una consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Crear un reporte con alias legibles para las columnas.
12. Crear una consulta que ayude a tomar una decision del negocio. */

-- 1. Listar todos los registros principales.
    SELECT * FROM prestamos;

-- 2. Mostrar solo dos columnas relevantes.
    SELECT id, id_camper, id_libro, fecha_prestamo FROM prestamos;

-- 3. Filtrar por condicion numerica o de fecha.
    SELECT id, id_camper, id_libro, fecha_prestamo 
    FROM prestamos
    WHERE fecha_prestamo BETWEEN '2026-08-03' AND '2026-08-06';

-- 4. Ordenar resultados.
    SELECT * FROM campers ORDER BY apellido asc;

-- 5. Mostrar top 5 por una metrica.
    SELECT C.id_sede, COUNT(C.id_sede) AS Cantidad, sc.departamento FROM campers C
    INNER JOIN sedes_campus sc 
    ON C.id_sede = sc.id
    GROUP BY id_sede 
    ORDER BY COUNT(C.id_sede) AND departamento DESC
    LIMIT 5;

-- 6. Contar registros totales.
SELECT COUNT(*) AS Total_inscritos FROM campers;

-- 7. Calcular promedio, minimo o maximo.
SELECT MIN(id) id_bajo, MAX(id) id_alto FROM campers;

-- 8. Agrupar con GROUP BY.
SELECT C.id_sede, COUNT(C.id_sede) AS Cantidad, sc.departamento FROM campers C
    INNER JOIN sedes_campus sc 
    ON C.id_sede = sc.id
    GROUP BY id_sede 
    ORDER BY COUNT(C.id_sede) AND departamento DESC
    LIMIT 5;

