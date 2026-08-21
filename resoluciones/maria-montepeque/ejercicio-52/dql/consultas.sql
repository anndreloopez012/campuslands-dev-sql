.headers on
.mode column

-- Ejercicio 52: UNIQUE Nivel Aplicado
-- Consultas de validacion y reporte final.

-- 1. Mostrar todos los datos principales.
SELECT * FROM partidas;

-- 2. Consulta con WHERE.
SELECT id_partida, equipo_local, equipo_visitante, fecha_partida
FROM partidas
WHERE marcador_local > marcador_visitante;

-- 3. Consulta con ORDER BY.
SELECT nickname, id_equipo
FROM jugadores
ORDER BY nickname;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_partidas,
    COUNT(DISTINCT fecha_partida) AS dias_de_torneo
FROM partidas;

-- 5. Validacion especifica del tema UNIQUE:
--    a) el indice unico por expresion LOWER(nickname) impide nicknames que
--       solo se diferencian por mayusculas/minusculas; se confirma
--       comparando el total de jugadores contra el total de nicknames
--       distintos normalizados a minusculas (deben coincidir).
SELECT
    COUNT(*) AS total_jugadores,
    COUNT(DISTINCT LOWER(nickname)) AS nicknames_normalizados_distintos
FROM jugadores;

--    b) el UNIQUE compuesto en partidas impide repetir el mismo
--       enfrentamiento en la misma fecha; se confirma agrupando por
--       (equipo_local, equipo_visitante, fecha_partida) y verificando que
--       ningun grupo tiene mas de una fila.
SELECT equipo_local, equipo_visitante, fecha_partida, COUNT(*) AS veces
FROM partidas
GROUP BY equipo_local, equipo_visitante, fecha_partida
HAVING COUNT(*) > 1;

-- Reporte final de negocio: tabla de posiciones del torneo (victorias,
-- empates y derrotas por equipo), considerando tanto de local como de
-- visitante.
SELECT
    e.nombre AS equipo,
    SUM(CASE
        WHEN p.equipo_local = e.id_equipo AND p.marcador_local > p.marcador_visitante THEN 1
        WHEN p.equipo_visitante = e.id_equipo AND p.marcador_visitante > p.marcador_local THEN 1
        ELSE 0
    END) AS victorias,
    SUM(CASE WHEN p.marcador_local = p.marcador_visitante THEN 1 ELSE 0 END) AS empates,
    SUM(CASE
        WHEN p.equipo_local = e.id_equipo AND p.marcador_local < p.marcador_visitante THEN 1
        WHEN p.equipo_visitante = e.id_equipo AND p.marcador_visitante < p.marcador_local THEN 1
        ELSE 0
    END) AS derrotas
FROM equipos e
JOIN partidas p ON e.id_equipo = p.equipo_local OR e.id_equipo = p.equipo_visitante
GROUP BY e.nombre
ORDER BY victorias DESC;
