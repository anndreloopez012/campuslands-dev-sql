.headers on
.mode column

-- Ejercicio 106: Triggers Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_partida, e.nombre_equipo, p.puntaje, p.fecha_partida, p.resultado
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo;

-- 2. Consulta con WHERE: solo las partidas ganadas.
SELECT id_partida, id_equipo, puntaje, fecha_partida
FROM partidas
WHERE resultado = 'victoria';

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, id_equipo, puntaje, fecha_partida
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas jugadas por equipo (las que quedan tras el DELETE).
SELECT id_equipo, COUNT(*) AS total_partidas
FROM partidas
GROUP BY id_equipo;

-- 5. Caso de negocio con Triggers: la tabla de posiciones del
-- torneo. Compara el puntaje_total que mantuvieron los 3 triggers
-- (columna desnormalizada) contra un SUM(puntaje) calculado en el
-- momento a partir de "partidas". Los dos valores deben coincidir
-- exactamente para cada equipo: esa coincidencia es la validacion
-- final de que los triggers hicieron bien su trabajo despues de la
-- serie de INSERT, UPDATE y DELETE de dml/inserts.sql.
SELECT e.nombre_equipo,
       e.puntaje_total,
       COALESCE(SUM(p.puntaje), 0) AS puntaje_calculado
FROM equipos e
LEFT JOIN partidas p ON p.id_equipo = e.id_equipo
GROUP BY e.id_equipo, e.nombre_equipo, e.puntaje_total
ORDER BY e.puntaje_total DESC;

-- Caso comentado que no es recomendable, dejar comentado: modificar
-- equipos.puntaje_total directamente con un UPDATE, en vez de dejar
-- que los triggers lo mantengan a traves de cambios en "partidas".
-- La sentencia no falla (no hay ningun CHECK que lo impida, solo que
-- sea >= 0), pero se verifico con Python (sqlite3) que, despues de
-- este UPDATE manual, puntaje_total (9999) para "Dragones Digitales"
-- deja de coincidir con el SUM(puntaje) real de sus partidas (190),
-- que es justo la comparacion de la consulta 5. Bypasear los
-- triggers escribiendo directo sobre la columna desnormalizada la
-- desincroniza en silencio.
-- UPDATE equipos SET puntaje_total = 9999 WHERE id_equipo = 1;
