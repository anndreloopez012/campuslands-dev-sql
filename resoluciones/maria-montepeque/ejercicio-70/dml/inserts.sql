PRAGMA foreign_keys = ON;

-- Ejercicio 70: DROP Nivel Aplicado
-- Se ejecuta despues de que ddl/schema.sql migro los resultados de la
-- primera jornada y elimino la tabla temporal. Aqui solo se agregan
-- registros nuevos directamente a las tablas definitivas.

INSERT INTO jugadores (nombre, id_equipo) VALUES
    ('Paola Coy', 2);

-- Resultado real de una partida que estaba programada: ya se jugo.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, puntaje_local, puntaje_visitante, estado) VALUES
    (1, 3, '2026-08-15', 4, 2, 'jugada');
