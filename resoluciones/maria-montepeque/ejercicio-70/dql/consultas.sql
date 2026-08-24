.headers on
.mode column

-- Ejercicio 70: DROP Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (partidas con nombre de
-- equipo local y visitante).
SELECT p.id_partida,
       eloc.nombre_equipo AS equipo_local,
       evis.nombre_equipo AS equipo_visitante,
       p.fecha_partida,
       p.puntaje_local,
       p.puntaje_visitante,
       p.estado
FROM partidas p
JOIN equipos eloc ON eloc.id_equipo = p.id_equipo_local
JOIN equipos evis ON evis.id_equipo = p.id_equipo_visitante;

-- 2. Consulta con WHERE: partidas ya jugadas.
SELECT id_partida, fecha_partida, puntaje_local, puntaje_visitante
FROM partidas
WHERE estado = 'jugada';

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, fecha_partida, estado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas por estado.
SELECT estado, COUNT(*) AS total
FROM partidas
GROUP BY estado;

-- 5. Caso de negocio con reporte final (nivel aplicado): se crea un
-- indice de apoyo y una vista de tabla de posiciones, se usan para
-- generar el reporte oficial de la jornada, y se eliminan enseguida
-- porque solo servian para esa validacion puntual.
CREATE INDEX idx_partidas_estado ON partidas (estado);

CREATE VIEW vista_tabla_posiciones AS
    SELECT
        e.id_equipo,
        e.nombre_equipo,
        COUNT(*) AS partidas_jugadas,
        SUM(
            CASE
                WHEN (p.id_equipo_local = e.id_equipo AND p.puntaje_local > p.puntaje_visitante)
                  OR (p.id_equipo_visitante = e.id_equipo AND p.puntaje_visitante > p.puntaje_local)
                THEN 1 ELSE 0
            END
        ) AS partidas_ganadas
    FROM equipos e
    JOIN partidas p
        ON (p.id_equipo_local = e.id_equipo OR p.id_equipo_visitante = e.id_equipo)
       AND p.estado = 'jugada'
    GROUP BY e.id_equipo, e.nombre_equipo;

-- Reporte oficial de la jornada: tabla de posiciones.
SELECT nombre_equipo, partidas_jugadas, partidas_ganadas
FROM vista_tabla_posiciones
ORDER BY partidas_ganadas DESC, nombre_equipo;

-- Una vez entregado el reporte, se eliminan la vista y el indice: ya
-- cumplieron su proposito puntual.
DROP VIEW vista_tabla_posiciones;
DROP INDEX idx_partidas_estado;

-- Validacion especifica de DROP: ni la tabla temporal de la migracion
-- (eliminada en ddl/schema.sql) ni la vista/indice del reporte (recien
-- eliminados) existen ya en el catalogo, pero los datos de partidas y
-- equipos que se usaron para generarlos siguen intactos.
SELECT name, type
FROM sqlite_master
WHERE name IN ('partidas_temporal', 'vista_tabla_posiciones', 'idx_partidas_estado');
-- Debe devolver 0 filas: los 3 objetos se eliminaron con DROP.

SELECT COUNT(*) AS total_partidas FROM partidas;
-- Las partidas reales (con las que se armo el reporte) siguen ahi.
