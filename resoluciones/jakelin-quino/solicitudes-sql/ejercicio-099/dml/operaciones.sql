PRAGMA foreign_keys = ON;

-- Ejercicio 099: Liga Videojuego Futbol
INSERT INTO jornadas (club_local_id, club_visita_id, goles_local, goles_visita) VALUES (2, 1, 2, 2);

UPDATE clubes SET puntos = puntos + 3 WHERE id = 1;

DELETE FROM usuarios WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM clubes WHERE usuario_id = usuarios.id);